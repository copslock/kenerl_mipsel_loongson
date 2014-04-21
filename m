Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2014 06:03:30 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:43250 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822265AbaDUED2OV4oU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Apr 2014 06:03:28 +0200
Received: by mail-pd0-f181.google.com with SMTP id p10so3238647pdj.40
        for <linux-mips@linux-mips.org>; Sun, 20 Apr 2014 21:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=lh4Ms5K5sJyWLsp2J3basM1s3SeVe1wX20uXL33zfaE=;
        b=UXlkCgnOBJs2nqrjc4mXus51L3XUpry8xgEWPnji7eqk27A6kufjMAkuX+LSW4ICva
         U4wYEPhDWnZb6o3BhXfTj0T1ggB/nokF6KBnIzzs0FHsOUAKSH2t88cCj5qlZknZLD/R
         jD5+TGTX3Va6jhuWwYe4RMSFjMBbz6b+GzBRGXMfNX2mO5ldu2TiE7CvsukgmKMD6G2f
         61QxL/7C357MFDrOQwg30LzGq02J7n+sKlb4sPeaC9DZEH29JUUbAqj+uSk45KAu7J5j
         sm8jXoKnduX6j/7s1iCAQukgqv6GBSzDUD7BXvojPlHe22jgHJIsDTK22SXeT8N92b3H
         4Nng==
X-Gm-Message-State: ALoCoQncJD1V0DnMF+TTuM8selCSUxPCUYIhwcrNxURgr9lZblY0GvxFzLAaucN4BVPqdgbPfGfi
X-Received: by 10.66.139.38 with SMTP id qv6mr848689pab.123.1398053001600;
        Sun, 20 Apr 2014 21:03:21 -0700 (PDT)
Received: from localhost ([111.93.218.67])
        by mx.google.com with ESMTPSA id vx10sm179748945pac.17.2014.04.20.21.03.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 20 Apr 2014 21:03:21 -0700 (PDT)
Date:   Mon, 21 Apr 2014 09:33:16 +0530
From:   Prem Karat <pkarat@mvista.com>
To:     linux-mips@linux-mips.org
Cc:     sergei.shtylyov@cogentembedded.com, ddaney.cavm@gmail.com
Subject: [PATCH v2 1/1] MIPS-Enable-VDSO-randomization.patch
Message-ID: <20140421040316.GB2489@064904.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pkarat@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pkarat@mvista.com
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

Based on commit 1091458d09e1a (mmap randomization)

For 32-bit address spaces randomize within a
16MB space, for 64-bit within a 256MB space.

Test Results:
------------
Without Patch (VDSO is not randomized)
---------------------------------------
root@Maleo:~# ./aslr vdso
FAIL: ASLR not functional (vdso always at 0x7fff7000)

root@Maleo:~# ./aslr rekey vdso
pre_val==cur_val
value=0x7fff7000

With patch:(VDSO is randmoized and doesn't interfere with stack)
----------------------------------------------------------------
root@cavium-octeon2:~# ./aslr rekey vdso
pre_val!=cur_val
previous_value=0x7f830ea2
current_value=0x776e2000
root@cavium-octeon2:~# ./aslr rekey vdso
pre_val!=cur_val
previous_value=0x7fb0cea2
current_value=0x77209000
root@cavium-octeon2:~# ./aslr rekey vdso
pre_val!=cur_val
previous_value=0x7f985ea2
current_value=0x7770c000
root@cavium-octeon2:~# ./aslr rekey vdso
pre_val!=cur_val
previous_value=0x7fbc6ea2
current_value=0x7fe25000

Maps file output:
-------------------------
root@cavium-octeon2:~# ./aslr rekey maps
78584000-785a5000 rwxp 00000000 00:00 0                                  [heap]
7f9d0000-7f9f1000 rw-p 00000000 00:00 0                                  [stack]
7ffa5000-7ffa6000 r-xp 00000000 00:00 0                                  [vdso]

root@cavium-octeon2:~# ./aslr rekey maps
77de0000-77e01000 rwxp 00000000 00:00 0                                  [heap]
7f91b000-7f93c000 rw-p 00000000 00:00 0                                  [stack]
7ff99000-7ff9a000 r-xp 00000000 00:00 0                                  [vdso]

root@cavium-octeon2:~# ./aslr rekey maps
77d7f000-77da0000 rwxp 00000000 00:00 0                                  [heap]
7fc2a000-7fc4b000 rw-p 00000000 00:00 0                                  [stack]
7fe09000-7fe0a000 r-xp 00000000 00:00 0                                  [vdso]

root@cavium-octeon2:~# ./aslr rekey maps
7794c000-7794d000 r-xp 00000000 00:00 0                                  [vdso]
77e4b000-77e6c000 rwxp 00000000 00:00 0                                  [heap]
7f6e7000-7f708000 rw-p 00000000 00:00 0                                  [stack]
root@cavium-octeon2:~#

Signed-off-by: Prem Karat <pkarat@mvista.com>
---
 arch/mips/kernel/vdso.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 0f1af58..ed2a278 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -16,9 +16,11 @@
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
 #include <linux/unistd.h>
+#include <linux/random.h>
 
 #include <asm/vdso.h>
 #include <asm/uasm.h>
+#include <asm/processor.h>
 
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
@@ -67,7 +69,18 @@ subsys_initcall(init_vdso);
 
 static unsigned long vdso_addr(unsigned long start)
 {
-	return STACK_TOP;
+	unsigned long offset = 0UL;
+
+	if (current->flags & PF_RANDOMIZE) {
+		offset = get_random_int();
+		offset <<= PAGE_SHIFT;
+		if (TASK_IS_32BIT_ADDR)
+			offset &= 0xfffffful;
+		else
+			offset &= 0xffffffful;
+	}
+
+	return STACK_TOP + offset;
 }
 
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
-- 
1.7.9.5
