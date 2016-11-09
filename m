Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 21:45:11 +0100 (CET)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34724 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992999AbcKIUpFVhtL7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 21:45:05 +0100
Received: by mail-wm0-f67.google.com with SMTP id g23so358158wme.1;
        Wed, 09 Nov 2016 12:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4P/tdhfvTOliA7hJrYyxU9MPh/E5gR0JbbUsfFzCn/g=;
        b=H7scj/cW+pdVPi2bG2AQekTLCjv7vzicETazUrgKh9rK134D1YqGgVxx0q7ToVBCTs
         Lhu0Vo1Yp2SqXom6BXNNr3TG3lJuafCzjvnBqZl4ikB3GdlLSyr5v9n4ImLMGGkUgqxy
         +XMHk/LxhsmIELccqR2wz38tb/hGJ05kcFHYlCaSpIC0sGLgV9arKmYSlQHAqB8YYvh6
         4+PS1DvQwqJFKxGmuvEoutIOsyKMjkv3NBUppY0NfhmI8cVtDcROhq4GX86xaNVJvNew
         ICSFCPW/AtZXpWrFQCV+bswkBlO8L8lufEXV+TU+pWUd784uXCfQoBWvt3vPupwGKmhj
         6VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4P/tdhfvTOliA7hJrYyxU9MPh/E5gR0JbbUsfFzCn/g=;
        b=bElv6OtF/wow7Uc6gQ7HmIcTPWuSf8Y93sh4K/bshArWPmAeu94rRL3crMDEIh1I1t
         PK7LVb96xtIvUC7PW1zb50kmOjQjOXV1FMbSBk7LZQyr0CqnblO97ZuQUOVqwtc+szcP
         M6vQMG++s4/h/NRGo0F1ul2Bf7qJyOTab0OjOnRuy2q3RDH4OpEKPYgCSGoAqGUgTEcG
         Bqjq0C3cBQEsHHQR+F97eXai9RUIJC6NGSCUCMMnsqW8Dg46nlfiYycQzT/vOpehEhFu
         iKgJi7N2bT7bnIBXJUKTluuNHxI4BsMpLYZ7Boju0N/Eczj3PNz9oCxXaCeuv4pMpEza
         Bx3g==
X-Gm-Message-State: ABUngvdtgXUenaWbxhVzvW1RtzQMwXKZZasC9kXGE+/lht7gEWHyGiSXJtGtBW/zuuFZOw==
X-Received: by 10.194.122.65 with SMTP id lq1mr1378199wjb.12.1478724299947;
        Wed, 09 Nov 2016 12:44:59 -0800 (PST)
Received: from sudip-laptop.Home ([94.4.164.233])
        by smtp.gmail.com with ESMTPSA id w7sm8960833wmd.24.2016.11.09.12.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Nov 2016 12:44:59 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        james.hogan@imgtec.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] MIPS: fix duplicate define
Date:   Wed,  9 Nov 2016 20:44:54 +0000
Message-Id: <1478724294-15736-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55754
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

v2: corrected a silly mistake of overlooking #else

Build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/174134289

 arch/mips/include/asm/mach-generic/spaces.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index 952b0fd..3d6d3b0 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -22,11 +22,13 @@
 #endif
 
 #ifdef CONFIG_32BIT
+#ifndef CAC_BASE
 #ifdef CONFIG_KVM_GUEST
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
