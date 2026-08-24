FarmButton.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm

    if autoFarm then
        FarmButton.Text = "فرام صناديق: [مفعل]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

        pcall(function()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
        end)
    else
        FarmButton.Text = "فرام صناديق: [معطل]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)

        pcall(function()
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
        end)

        return
    end

    task.spawn(function()

        -- =====================================================
        -- فحص التوظيف مرة واحدة فقط عند تشغيل الفرام
        -- =====================================================
        if autoFarm then
            local status = checkEmploymentStatusText()

            if status ~= "employed" then
                task.wait(0.3)

                if autoFarm then
                    clickCenter()
                    task.wait(0.5)
                end
            end
        end

        -- =====================================================
        -- بداية الفرام
        -- =====================================================
        while autoFarm do

            pcall(function()
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
            end)

            if LocalPlayer.Character
                and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

                local hrp = LocalPlayer.Character.HumanoidRootPart
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")

                checkAndUnsit(humanoid)

                local speed = tonumber(SpeedInput.Text) or 25

                -- =================================================
                -- إذا ما معه صندوق
                -- =================================================
                if not playerHasBox() then

                    if isInsideGrocery(hrp.Position) then

                        local internalPoint = getClosestInternalAisle(hrp.Position)

                        moveToPosition(hrp, internalPoint, speed)
                        if not autoFarm then break end

                        moveToPosition(hrp, waypoints[6], speed)
                        if not autoFarm then break end

                        -- لا يوجد فحص توظيف هنا
                        -- لأنه تم الفحص مرة واحدة عند التشغيل

                        if autoFarm then
                            moveToPosition(hrp, waypoints[7], speed)
                        end

                    else

                        local startIndex = getClosestStartPoint(hrp.Position)

                        for i = startIndex, 3 do
                            if not autoFarm then break end

                            moveToPosition(hrp, waypoints[i], speed)
                        end

                        for i = 4, 6 do
                            if not autoFarm then break end

                            moveToPosition(hrp, waypoints[i], speed)
                        end

                        if not autoFarm then break end

                        -- لا يوجد فحص توظيف هنا أيضاً

                        moveToPosition(hrp, waypoints[7], speed)
                    end

                    if not autoFarm then break end

                    task.wait(0.2)

                    -- =============================================
                    -- ضغط E خمس مرات لالتقاط الصندوق
                    -- =============================================
                    for _ = 1, 5 do

                        if not autoFarm or playerHasBox() then
                            break
                        end

                        pressEKey()
                        task.wait(0.15)
                    end

                    task.wait(0.2)
                end

                if not autoFarm then break end

                -- =================================================
                -- إذا معه صندوق
                -- =================================================
                if playerHasBox() then

                    moveToPosition(hrp, waypoints[8], speed)
                    if not autoFarm then break end

                    task.wait(0.2)

                    -- البحث عن مكان التوصيل الحقيقي
                    local realDeliveryPoint = findHiddenDeliveryTarget()

                    if realDeliveryPoint then

                        local targetAislePoint =
                            getClosestAislePoint(realDeliveryPoint)

                        -- الذهاب للممر
                        moveToPosition(hrp, targetAislePoint, speed)
                        if not autoFarm then break end

                        task.wait(0.2)

                        -- الذهاب لمكان التوصيل
                        moveToPosition(
                            hrp,
                            Vector3.new(
                                realDeliveryPoint.X,
                                hrp.Position.Y,
                                realDeliveryPoint.Z
                            ),
                            speed
                        )

                        if not autoFarm then break end

                        -- الانتظار حتى يختفي هدف التوصيل
                        while autoFarm
                            and isTargetStillActive(realDeliveryPoint) do

                            checkAndUnsit(humanoid)
                            task.wait(0.3)
                        end

                        task.wait(0.2)

                        -- الرجوع للممر
                        moveToPosition(hrp, targetAislePoint, speed)

                        if not autoFarm then break end

                        task.wait(0.2)

                        -- =========================================
                        -- الرجوع الطبيعي
                        -- 8 -> 7 -> 6
                        -- =========================================
                        moveToPosition(hrp, waypoints[8], speed)

                        if not autoFarm then break end

                        moveToPosition(hrp, waypoints[7], speed)

                        if not autoFarm then break end

                        moveToPosition(hrp, waypoints[6], speed)

                        if not autoFarm then break end

                        -- =================================================
                        -- مهم:
                        -- لا يوجد فحص توظيف هنا
                        -- يكمل مباشرة للدورة التالية
                        -- =================================================

                        if autoFarm then
                            moveToPosition(hrp, waypoints[7], speed)
                        end

                    else
                        -- لم يجد مكان التوصيل
                        task.wait(1)
                    end
                end

                task.wait(0.2)

            else
                task.wait(1)
            end
        end

        -- =====================================================
        -- إيقاف Shift عند إيقاف الفرام
        -- =====================================================
        pcall(function()
            VirtualInputManager:SendKeyEvent(
                false,
                Enum.KeyCode.LeftShift,
                false,
                game
            )
        end)
    end)
end)