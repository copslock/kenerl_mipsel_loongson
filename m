Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 03:15:55 +0100 (CET)
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36565 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012540AbcBDCPFgrbgx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 03:15:05 +0100
Received: by mail-pf0-f174.google.com with SMTP id n128so26676748pfn.3;
        Wed, 03 Feb 2016 18:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eUXHj/hLyYZVm4DaehSvGMh5Y2S9WbMvg1kWnV+8Bes=;
        b=Wp19QLeWTWWw65anSWkwR5Il86mN+lVROdae2dsKKejFJXjWDuJnhVTKCdYQ//HVCH
         qEjjc3EL21N9OJlMG7b6QjRFGsV9HFpO1J/QckFog0nEQL/kGSPCXHChh7uXTCf1ticw
         CWuihnkJeZ0EFniWmEpC5CUeETNzoi+b43M00mi9VKuHVDNKLZ78+gjy5d9GYksmo0kT
         bA0f/CGBX2YqYqPO77uFQwF4BUQLaowPiJVMSYbk1a0Fulaz5Zvnc8a+Dh4imEZmkLzz
         dWHucdJ91uD5WwxJrlqCembPnkov7uuy25vW740SdNy5bebDuGlkJXETcSoyTKiPkTMx
         h/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eUXHj/hLyYZVm4DaehSvGMh5Y2S9WbMvg1kWnV+8Bes=;
        b=EGxn5flgfy5X4PG8+geIqolMeP6MMLAvsehpad1YyloBZUJeVqGzFia0X0F3EmBQSF
         WE/LH6PO9B4vPy21yLX2IXdUIVLC3P/ANho8CvRkseBGm17kXa4P4o+9nonaQBRTrU6b
         kzBCAa3PxTc4D7Mz7AFIgECS3hZgHyZSS8KbiA0xanygAEp1Vw/GCazpfJublTR4LaNj
         y66zTjbFBRGCg3d/rQFybMBfcNmdpVtTkbwxonJzOmybbQU5iiHQODfj1e2PTSxvISoV
         mXM8mMXgbsecmwpyAbpNVeXGsJOwqx3TBMYG5DGFhSEwixvoVmJsboinu27N5mTzVMco
         uJxA==
X-Gm-Message-State: AG10YOToX7MXgzrhRGXOrjIkUvhH6GK7Mc/02+Eqbt70++uEyBFsBZRcRxxtWXjQLAqAqg==
X-Received: by 10.66.139.134 with SMTP id qy6mr7285138pab.45.1454552099933;
        Wed, 03 Feb 2016 18:14:59 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id l14sm12646282pfb.73.2016.02.03.18.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 18:14:59 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, jaedon.shin@gmail.com,
        dragan.stancevic@gmail.com, jogo@openwrt.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/4] MIPS: BMIPS: Remove maxcpus from BCM97435SVMB DTS
Date:   Wed,  3 Feb 2016 18:14:52 -0800
Message-Id: <1454552093-17897-4-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
References: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Now that SMP properly works on 7435, do not restrict the number of core,
unleash them all.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm97435svmb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 1df088183523..68f486eba3f7 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -14,7 +14,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200 maxcpus=1";
+		bootargs = "console=ttyS0,115200";
 		stdout-path = &uart0;
 	};
 };
-- 
2.1.0
