Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 17:30:04 +0200 (CEST)
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35637 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024719AbcC3PaCrwLRN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 17:30:02 +0200
Received: by mail-wm0-f44.google.com with SMTP id 191so94257082wmq.0;
        Wed, 30 Mar 2016 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZrkR6TBXqVYXNbNiSOEAY2L7Rf2V/yH/PwgqdeGTxCc=;
        b=TES8b9LPg/56Bo+D9L1stbwiv2KdJQZPSS1vt3aG4IGPEVZj+H2LhQVl4RYbXeHgA8
         hN0zFbMpJuW/D1+vN3eWomAyaVBjlj2PEu0RLx5AfLj8T/ss/gVp3bnt5jXwYDcL0qPm
         rdC1KsxbY92L8f0POSt4x1wDUM2/tAkNVjxKzkSV/Trm1N/H94da3Jny51K6eQMS0s+f
         XwzM6XHRZYFMUZO94DKp3mGKacNwPPeUP2G1iP8W8TMmjJWxm7O6M0of7n3lCuct3yLi
         5PgrXo5EapvBhWjSrKT92fmx5K8lZR89G14saOJ6VX8M9RlKG7QIb8mxQW4QpaxOKPcw
         KnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZrkR6TBXqVYXNbNiSOEAY2L7Rf2V/yH/PwgqdeGTxCc=;
        b=f/u9GPrmidKwexJ4u7ootPuMsfS0z/60qjP5wg4brKNNailyIqHZEfcd01O3VCWElk
         FJK/508QfN5uOf8qV0QkstREled2lUvtCw9U4Ta2htMK+k3/WwmB66WaGYL0cI90Jt0j
         LJa0BtGNN9jKCD+R483AA+lkIKm1sa2hnDy5QcrgVij1PXwGOqTrTVZGrocPg6+hhHYz
         Q0YFLilX2mSd4aZSu6zgB5JIuoJnGagZyAy0uH76OmYOe2NLzMQYi5DrrUcNHCLz1H2z
         PW5MgDlOXPMVf62MBGsY+ljhBEXJQ2nT4LTts6zr1XVBNautvm+0C0JHyHQytk2GYP5n
         KHpg==
X-Gm-Message-State: AD7BkJKIbOI/g/vo5imkstzjeL+PJm884yo3EPcIggg1FGz+i6Ll7saHxfNKidficKF3wA==
X-Received: by 10.194.60.165 with SMTP id i5mr11454616wjr.178.1459351795643;
        Wed, 30 Mar 2016 08:29:55 -0700 (PDT)
Received: from sudip-tp.guest.codethink.co.uk (82-70-136-246.dsl.in-addr.zen.co.uk. [82.70.136.246])
        by smtp.gmail.com with ESMTPSA id w8sm4485577wjf.19.2016.03.30.08.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 08:29:54 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH] MIPS: ath79: fix build failure
Date:   Wed, 30 Mar 2016 16:29:49 +0100
Message-Id: <1459351789-24544-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.1.4
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

The ath79_defconfig build of mips was faling with the errors:

arch/mips/ath79/setup.c: In function 'plat_mem_setup':
arch/mips/ath79/setup.c:226:20: error: invalid storage class for function 'ath79_of_plat_time_init'
 static void __init ath79_of_plat_time_init(void)
                    ^
arch/mips/ath79/setup.c:226:1: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
 static void __init ath79_of_plat_time_init(void)
 ^
arch/mips/ath79/setup.c:284:20: error: invalid storage class for function 'ath79_setup'
 static  __init int ath79_setup(void)
                    ^
arch/mips/ath79/setup.c:299:1: error: initializer element is not constant
 arch_initcall(ath79_setup);

It turns out to be a simple error of a missed closing brace.

Fixes: f63ba725caa7 ("MIPS: ath79: Disable platform code for OF boards.")
Cc: Antony Pavlov <antonynpavlov@gmail.com>
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

Build log of next-20160330 is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/119417999

 arch/mips/ath79/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 897f49a..e0ff6f3 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -214,6 +214,7 @@ void __init plat_mem_setup(void)
 						 AR71XX_PLL_SIZE);
 		ath79_detect_sys_type();
 		ath79_ddr_ctrl_init();
+	}
 
 	detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
 	/* OF machines should use the reset driver */
-- 
2.1.4
