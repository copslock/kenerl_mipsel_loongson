Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 21:17:02 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:33693
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993859AbdFFTQzuBxSB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 21:16:55 +0200
Received: by mail-wr0-x244.google.com with SMTP id v104so11080806wrb.0;
        Tue, 06 Jun 2017 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BOdbLAaHQd905LzxsIGKQGvDYafjcNFRLzVNylaqtQk=;
        b=Ib2XXIdNE8lXRmQCFj94gio03kaztfrld7GOff66rehy9/3Un6OtO1Rw3V56sGmDM6
         +JroPQL9ryC7Qx0GIbtECOAqkg7XBKcLNuj2CZ8OPW720JLKQm/S9y5u/I7GF1VW/JZ0
         uQ5jJMZY0jRMpT/TxWLPfzH6mvX439KgpvjuneH05PDFcRdjp7RKOMDsXRTNyp0JcuPx
         aByaBdiLfuEUTmaJ0UpyCVW1BWhyIOBuDTMzLFWbv33o96CzhpJfAZWCL7DK7hxioR2S
         NiMigPPH8ffnmRagV6umwI2sFXeumQmX8Rex4Eae47S+R4xN2r24YMGBcdLb3/q0b1Jg
         XsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BOdbLAaHQd905LzxsIGKQGvDYafjcNFRLzVNylaqtQk=;
        b=e5Ri6M3dSZmGCtdBU0m48kDrvGhuf9lfccAQQ806OC5VwEG/I79nkGbHIpLq2MIoid
         xcwduH2/nJ38LOi7EucIZ/igQc/F4UG+c2u6uGghVkSus2nTVcnBZNM1f5tsamK8hJlk
         kx/jRJ5KBU7fzgCJUgJUb8NUwo/tpwZTBLUf2sHaykU1WFrm684rdSByoYqFQV8ZwQmT
         Qdsu0TSqhRIXYhF0LyKjLjA1Q/kNJ8ua6nI1NdLcH5cNrnBWlebEclobuPmt5oxmnT+Q
         ZRShm+hjumG1XnmLR/ppOiI1E1d7TTXtzhtjmaGmXHC9tdMRsmy0d529EDOiItS0gxIl
         IrLw==
X-Gm-Message-State: AODbwcCJWTi8K/D3ODZZBe8+Aa1DhIBz82pXdESx7ziW5N+Oh+g6Hn2V
        fyPgVONFEPB9iaCh
X-Received: by 10.223.166.13 with SMTP id k13mr21468926wrc.197.1496776610143;
        Tue, 06 Jun 2017 12:16:50 -0700 (PDT)
Received: from localhost.localdomain (host196-45-dynamic.24-79-r.retail.telecomitalia.it. [79.24.45.196])
        by smtp.gmail.com with ESMTPSA id e73sm14687609wmd.1.2017.06.06.12.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 12:16:49 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        linux-kernel@vger.kernel.org, Jonas Gorski <jogo@openwrt.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH] MIPS: fix boot with DT passed via UHI
Date:   Tue,  6 Jun 2017 21:16:36 +0200
Message-Id: <1496776596-5045-1-git-send-email-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <andrea.merello@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.merello@gmail.com
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

commit 15f37e158892 ("MIPS: store the appended dtb address in a variable")
seems to have introduced code that relies on delay slots after branch,
however it seems that, since no directive ".set noreorder" is present, the
AS already fills delay slots with NOPs.

This caused failure in assigning proper DT blob address to fw_passed_dtb
variable, causing failure when booting passing DT via UHI; this has been
seen on a Lantiq VR9 SoC (Fritzbox 3370) and u-boot as bootloader.

[    0.000000] Linux version 4.12.0-fritz+ (andrea@horizon) (gcc version 4.9.0 (GCC) ) #29 SMP Tue Jun 6 20:49:59 CEST 2017
[    0.000000] SoC: xRX200 rev 1.2
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 00696000 @ 00002000 (usable)
[    0.000000]  memory: 00038000 @ 00698000 (usable after init)
[    0.000000] Wasting 64 bytes for tracking 2 unused pages
[    0.000000] Kernel panic - not syncing: No memory area to place a bootmap bitmap
[    0.000000] Rebooting in 1 seconds..
[    0.000000] Reboot failed -- System halted

This patch moves the instruction meant to be placed in the delay slot
before the preceding BEQ instruction, while the delay slot will be
filled with a NOP by the AS.

After this patch the kernel fetches the DR correctly

[    0.000000] Linux version 4.12.0-fritz+ (andrea@horizon) (gcc version 4.9.0 (GCC) ) #30 SMP
Tue Jun 6 20:52:40 CEST 2017
[    0.000000] SoC: xRX200 rev 1.2
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)
[    0.000000] MIPS: machine is FRITZ3370 - Fritz!Box WLAN 3370
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 08000000 @ 00000000 (usable)
[    0.000000] Detected 1 available secondary CPU(s)
[    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
[    0.000000] percpu: Embedded 15 pages/cpu @8110c000 s30176 r8192 d23072 u61440
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: rootwait root=/dev/sda1 console=ttyLTQ0
...

Cc: linux-kernel@vger.kernel.org
Cc: Jonas Gorski <jogo@openwrt.org>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index cf05220..d1bb506 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -106,8 +106,8 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	beq		t0, t1, dtb_found
 #endif
 	li		t1, -2
-	beq		a0, t1, dtb_found
 	move		t2, a1
+	beq		a0, t1, dtb_found
 
 	li		t2, 0
 dtb_found:
-- 
2.7.4
