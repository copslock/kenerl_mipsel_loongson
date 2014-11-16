Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:22:19 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43499 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013768AbaKPATlGhbBM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:41 +0100
Received: by mail-pa0-f45.google.com with SMTP id lf10so19839395pab.4
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cHj+D0skfj5niDUOXIPAtKr2STdkwljzvnDBR/QebSc=;
        b=txP9PNOfJzFwlWGjYxKbmNZRKl0AW1aLA7O1XOB/WkTW11orY4g5kU3PUOO7dx1dYf
         unBs9dFYnMloF/oEp18nhUtG14mU9GMsyL5WLJguoUShGvTOPSSDl9GC9/acr80mg1yL
         uCcXsVTVEwFZsyPQVT/YEQX78fh6Cq957GVtWsGxe3SPyag+Fre9uBGW/zeqEkHurprB
         Sycnq+htH8vp/Uyl0anIDyCjTmAdIWlx7nPji7w7Z0eJ1tLhbUDO5zfkIlxJb7rvym50
         MycM5ahM6hgakiQyOpL8XLQERYklnMuMijSeZeZ7gYcc08JfS030+iD8GGZKGBu2Psh6
         Y4uA==
X-Received: by 10.66.146.71 with SMTP id ta7mr20084933pab.16.1416097175497;
        Sat, 15 Nov 2014 16:19:35 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:34 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 10/22] MIPS: BMIPS: Allow BMIPS3300 to utilize SMP ebase relocation code
Date:   Sat, 15 Nov 2014 16:17:34 -0800
Message-Id: <1416097066-20452-11-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

From: Jon Fraser <jfraser@broadcom.com>

BMIPS3300 processors do not have the hardware to support SMP, but with a
small tweak, the SMP ebase relocation code allows BMIPS3300-based
platforms to reuse the S2/S3 power management code from BMIPS4380-based
chips.  Normally this is as simple as adding one line to prom_init():

    board_ebase_setup = &bmips_ebase_setup;

Signed-off-by: Jon Fraser <jfraser@broadcom.com>
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/smp-bmips.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 8383fa4..887c3ea 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -541,6 +541,7 @@ void bmips_ebase_setup(void)
 			&bmips_smp_int_vec, 0x80);
 		__sync();
 		return;
+	case CPU_BMIPS3300:
 	case CPU_BMIPS4380:
 		/*
 		 * 0x8000_0000: reset/NMI (initially in kseg1)
-- 
2.1.1
