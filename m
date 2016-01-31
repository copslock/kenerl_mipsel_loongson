Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2016 14:03:28 +0100 (CET)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33144 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011382AbcAaND1SApCn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Jan 2016 14:03:27 +0100
Received: by mail-lb0-f171.google.com with SMTP id x4so62406206lbm.0;
        Sun, 31 Jan 2016 05:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=q0hbYAPkSwRGGgyMTs23kFruzWm6QrEtSGyavvAhd6s=;
        b=0b9CgpOz7jZFbxlywRYItCDq+NPbGA8oj6II2yGwkE7gJgLYHCMGkDM77d0b8n4aIx
         lppkb7JLUyq4S7Cn+XseGwS4ysOBIaKuaky6xgMt+UH1zMFsEdhDQuAP44JvbX92FK7c
         pCGji3kJzoLGYuVyFDSRf1NqJPfjhCbDMYwczynRw0G04kPB6o2Q4OQCf2A+76yZDKUz
         jwjQoEjXf//fx0z0UTvvss6WMoRw9JEEPNvJx5TK0nQw/jTqznskRl+bHwaKnYOB5rKF
         7IfdLEtRbzamONU+nmkGUhF6eGbFmOMybubQ6PqT1a4GbZ89flYp1p9fAyFHZZOQqN82
         5ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=q0hbYAPkSwRGGgyMTs23kFruzWm6QrEtSGyavvAhd6s=;
        b=PU7DBXRopO9PVmDs1c97v50AtVgTcWOtRFV5QCOw+0JQVyFD2TC997UnIYN38DLt1g
         PEpazj2aJgfD4/Mm4sbVE+ry3TffAQOUBHxORhMH0aXL47OcEgYHn4lX4DVDcR+h753k
         pS8m55n7hKcs1870hb+6jkzQ4Y4hOqyTh+qFPTOw5QTtaHcct/8Fzjr3EAy6QtUJp1cx
         KyUET/gsSplkOkFcbo/6p1SdQblDU04hcskJTN59GHBEP+O7ERNwYa8+5aeeOV3hcRuK
         yHtCI12e5y1XMpaMXn8erNZN3adUgbyEfrLqft76sd2cYdK9LbTYlZouV7OzsSQqn7IP
         3Vyg==
X-Gm-Message-State: AG10YOS2hgYYmsF14VVncD1D/VfXQCsbzbhofGYDMX7i2ARmhKSP4++BiWOtNx6Ngd7ZwA==
X-Received: by 10.112.172.233 with SMTP id bf9mr6552533lbc.121.1454245401794;
        Sun, 31 Jan 2016 05:03:21 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id ja4sm3257451lbc.8.2016.01.31.05.03.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jan 2016 05:03:21 -0800 (PST)
Date:   Sun, 31 Jan 2016 16:28:44 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Alban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: phy: please review ATH79 USB phy driver
Message-Id: <20160131162844.7230eb766ab73138795891d7@gmail.com>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello!

In current linux-mips master branch from git://git.linux-mips.org/pub/scm/ralf/linux
there are two commits

    commit 76654c7be21c1704607e9ed22cf5d18d430fd828
    Author: Alban Bedel <albeu@free.fr>
    Date:   Mon Nov 16 22:22:04 2015 +0100

        MIPS: ath79: Enable the USB port on the TL-WR1043ND

    commit 25ee4e47a316f55a1ceaa0deda8c5fa812cefeae
    Author: Alban Bedel <albeu@free.fr>
    Date:   Mon Nov 16 22:22:03 2015 +0100

        MIPS: ath79: Add the EHCI controller and USB phy to the AR9132 dtsi

The commits add USB support for TL-WR1043ND.
I have tried to run linux on TL-WR1043ND, but USB port does not work
through USB phy driver absence.

I have found the appropriate phy driver patches in the ath79 branch
in the https://github.com/AlbanBedel/linux repo and at linux-mips patchwork site

    https://patchwork.linux-mips.org/patch/11497/

    commit ceccaefd0ec63b61c03a0e0eadc607ab9f2253d0
    Author: Alban Bedel <albeu@free.fr>
    Date:   Tue Sep 1 14:06:54 2015 +0200

        phy: Add a driver for the ATH79 USB phy


    https://patchwork.linux-mips.org/patch/11495/

    commit 4572165504c10f5a31a7807d8ba4e7bb135f8a27
    Author: Alban Bedel <albeu@free.fr>
    Date:   Thu Nov 12 00:08:59 2015 +0100

        phy: Add a driver for simple phy

After applying these patches TL-WR1043ND USB port works fine.

However, I can't find these patches in git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git
so they are not enqueued for merging into mainline linux kernel.

Could you please review the patches?

-- 
Best regards,
  Antony Pavlov
