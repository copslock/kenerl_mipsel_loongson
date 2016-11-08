Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2016 22:43:53 +0100 (CET)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32893 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbcKHVnqcli0H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2016 22:43:46 +0100
Received: by mail-wm0-f66.google.com with SMTP id u144so25350643wmu.0;
        Tue, 08 Nov 2016 13:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zpXQ3aICVTb7CrhelmW28W+fOQ2BgOLrBKUtDKifXRY=;
        b=CQf9QasTcvYtWFo4qkd5biO3fUmevu8sVBIP4RbLv/fRs4mIh+CNzcEc79REjjpawb
         XVKTIWfwRStRBWIV9qkxmHYZBXskf6u0jdorCEIwxMbUHyIMHxjVVnfGoY2/lAqiSji6
         elsDBHp3cIcN86OQN0lz0XSzuD3I6eDMM7KQbKaisBjpFHPzNCHU1VFgTssn8OAVe6Oz
         ZEFOdqZ02y7A6qSBBWPWhgrFAmuMyajE05nIOjwTzF7wrL5qeCMa/E9SBbsSUwYEmjT/
         2n+kH9Xj74TdNVkdUTTlloE1KPqPqZ/Iih62277K1uEW/kwxUVoptXv/kMZjQT32SL7S
         I/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zpXQ3aICVTb7CrhelmW28W+fOQ2BgOLrBKUtDKifXRY=;
        b=SNyP8GNl8BWW0jocq+VRL8vLoi+Si8Rx9eBgMIwfw+0jyQMZbjxrx//OT6pILx5N+S
         BA3HBPRO6pV4D3hB+U/zgt8s4cXbBmuKzPYY0SKf15ZdPgltscDoWto/jNg4+7dPcnCS
         j7w010eYjfP0Q74eqXL7OJOqpAUpr+BxcJknF6rYYmikXQ0s0XKugSu/mfrtPtC795V9
         Bx04sryLOV5EpgAYOLVTNOXTOI2pY5gxENCLgpMxBHuPIcSqIn4EfzRCdHty2Eo74bhs
         YtAZ8IYq+5K6OOFzxXtR+7+KL8aozD/g/89mFwJHcLzYPxEuRQs3r4cofHkN86BAeynI
         Y3eg==
X-Gm-Message-State: ABUngveJ/QQE8K7sHhzC/vKcpdDN9F4H0QEVJmGP2BzCPjgtYlyBwNSFCGwdFrrxDLqlMA==
X-Received: by 10.28.230.197 with SMTP id e66mr446630wmi.12.1478641421130;
        Tue, 08 Nov 2016 13:43:41 -0800 (PST)
Received: from sudip-laptop.Home ([94.4.164.233])
        by smtp.gmail.com with ESMTPSA id g17sm39314782wjs.38.2016.11.08.13.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Nov 2016 13:43:40 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] MIPS: fix duplicate define
Date:   Tue,  8 Nov 2016 21:43:35 +0000
Message-Id: <1478641415-6986-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55729
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

The mips build of ip27_defconfig is failing with the error:
In file included from ../arch/mips/include/asm/mach-ip27/spaces.h:29:0,
                 from ../arch/mips/include/asm/page.h:12,
                 from ../arch/mips/vdso/vdso.h:26,
                 from ../arch/mips/vdso/gettimeofday.c:11:
../arch/mips/include/asm/mach-generic/spaces.h:28:0:
	error: "CAC_BASE" redefined [-Werror]
 #define CAC_BASE  _AC(0x80000000, UL)
 
In file included from ../arch/mips/include/asm/page.h:12:0,
                 from ../arch/mips/vdso/vdso.h:26,
                 from ../arch/mips/vdso/gettimeofday.c:11:
../arch/mips/include/asm/mach-ip27/spaces.h:22:0:
	note: this is the location of the previous definition
 #define CAC_BASE  0xa800000000000000

Add a condition to check if CAC_BASE is already defined, and define it
only if it is not yet defined.

Fixes: 3ffc17d8768b ("MIPS: Adjust MIPS64 CAC_BASE to reflect Config.K0")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

Build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/174134289

 arch/mips/include/asm/mach-generic/spaces.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index 952b0fd..61b75da 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -23,10 +23,12 @@
 
 #ifdef CONFIG_32BIT
 #ifdef CONFIG_KVM_GUEST
+#ifndef CAC_BASE
 #define CAC_BASE		_AC(0x40000000, UL)
 #else
 #define CAC_BASE		_AC(0x80000000, UL)
 #endif
+#endif
 #ifndef IO_BASE
 #define IO_BASE			_AC(0xa0000000, UL)
 #endif
-- 
1.9.1
