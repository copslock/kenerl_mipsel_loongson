Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 23:47:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57170 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994863AbdIAVrqoCL2o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2017 23:47:46 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2F40CBD15E639;
        Fri,  1 Sep 2017 22:47:35 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 1 Sep 2017 22:47:39
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Fix cmpxchg on 32b signed ints for 64b kernel with !kernel_uses_llsc
Date:   Fri, 1 Sep 2017 14:46:50 -0700
Message-ID: <20170901214650.15389-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Commit 8263db4d7768 ("MIPS: cmpxchg: Implement __cmpxchg() as a
function") refactored our implementation of __cmpxchg() to be a function
rather than a macro, with the aim of making it easier to read & modify.
Unfortunately the commit breaks use of cmpxchg() for signed 32 bit
values when we have a 64 bit kernel with kernel_uses_llsc == false,
because:

 - In cmpxchg_local() we cast the old value to the type the pointer
   points to, and then to an unsigned long. If the pointer points to a
   signed type smaller than 64 bits then the old value will be sign
   extended to 64 bits. That is, bits beyond the size of the pointed to
   type will be set to 1 if the old value is negative. In the case of a
   signed 32 bit integer with a negative value, bits 63:32 will all be
   set.

 - In __cmpxchg_asm() we load the value from memory, ie. dereference the
   pointer, and store the value as an unsigned integer (__ret) whose
   size matches the pointer. For a 32 bit cmpxchg() this means we store
   the value in a u32, because the pointer provided to __cmpxchg_asm()
   by __cmpxchg() is of type volatile u32 *.

 - __cmpxchg_asm() then checks whether the value in memory (__ret)
   matches the provided old value, by comparing the two values. This
   results in the u32 being promoted to a 64 bit unsigned long to match
   the old argument - however because both types are unsigned the value
   is zero extended, which does not match the sign extension performed
   on the old value in cmpxchg_local() earlier.

This mismatch means that unfortunate cmpxchg() calls can incorrectly
fail for 64 bit kernels with kernel_uses_llsc == false. This is the case
on at least non-SMP Cavium Octeon kernels, which hardcode
kernel_uses_llsc in their cpu-feature-overrides.h header. Using a
v4.13-rc7 kernel configured using cavium_octeon_defconfig with SMP
manually disabled, this presents itself as oddity when we reach
userland - for example:

  can't run '/bin/mount': Text file busy
  can't run '/bin/mkdir': Text file busy
  can't run '/bin/mkdir': Text file busy
  can't run '/bin/mount': Text file busy
  can't run '/bin/hostname': Text file busy
  can't run '/etc/init.d/rcS': Text file busy
  can't run '/sbin/getty': Text file busy
  can't run '/sbin/getty': Text file busy

It appears that some part of the init process, which is in this case
buildroot's busybox init, is running successfully. It never manages to
reach the login prompt though, and complains about /sbin/getty being
busy repeatedly and indefinitely.

Fix this by casting the old value provided to __cmpxchg_asm() to an
appropriately sized unsigned integer, such that we consistently
zero-extend avoiding the mismatch. The __cmpxchg_small() case for 8 & 16
bit values is unaffected because __cmpxchg_small() already masks
provided values appropriately.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 8263db4d7768 ("MIPS: cmpxchg: Implement __cmpxchg() as a function")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cmpxchg.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 903f3bf48419..7e25c5cc353a 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -155,14 +155,16 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 		return __cmpxchg_small(ptr, old, new, size);
 
 	case 4:
-		return __cmpxchg_asm("ll", "sc", (volatile u32 *)ptr, old, new);
+		return __cmpxchg_asm("ll", "sc", (volatile u32 *)ptr,
+				     (u32)old, new);
 
 	case 8:
 		/* lld/scd are only available for MIPS64 */
 		if (!IS_ENABLED(CONFIG_64BIT))
 			return __cmpxchg_called_with_bad_pointer();
 
-		return __cmpxchg_asm("lld", "scd", (volatile u64 *)ptr, old, new);
+		return __cmpxchg_asm("lld", "scd", (volatile u64 *)ptr,
+				     (u64)old, new);
 
 	default:
 		return __cmpxchg_called_with_bad_pointer();
-- 
2.14.1
