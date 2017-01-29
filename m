Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jan 2017 04:39:35 +0100 (CET)
Received: from resqmta-ch2-05v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:37]:56015
        "EHLO resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990514AbdA2Dj2VRWis (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jan 2017 04:39:28 +0100
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-05v.sys.comcast.net with SMTP
        id XgKscKnX4GIG7XgKsc1wui; Sun, 29 Jan 2017 03:39:26 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-19v.sys.comcast.net with SMTP
        id XgKrcAX1oEOzuXgKrcHJQ4; Sun, 29 Jan 2017 03:39:26 +0000
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH] MIPS: Add ifdefs to IP22/IP32's Platform files
Message-ID: <b290b37d-b136-0766-44ce-a094b336779a@gentoo.org>
Date:   Sat, 28 Jan 2017 22:38:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMDp7AlHFwEa8rjEmDg0K1Vn/rZadmLV9cD+mEyGR8UNiKEJdZ7muGDSvROWs7HgpMED13Cs/uEnK3XbJif63J87d+TeVOulLyQqgW0f13iL5b2yqpdv
 waakgMqwRsvYcgBOC2tCukx0rCfJsW35BddsP8qddZ4wdm3VkGjtx0EAVy5nRV6Ls2AE1M14cs3+K4WkW/aJGR5LT1S9kH184fYsWMWLvWEzTrLOfAT+h6bY
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Prevent IP22/IP32's Platform directives from mixing into builds of
other MIPS platforms.  During a recent IP27 build, erroneous R10K
cache barrier instructions were being emitted before every load or
store instruction.  This was caused by IP27 accidentally picking up
the -mr10k-cache-barrier option from arch/mips/sgi-ip32/Platform.

By wrapping the directives in both IP22 and IP32's Platform file
inside an 'ifdef' block, as is already done in IP27's Platform file,
this prevents the R10K cache barriers from being emitted on platforms
where they are not needed.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/sgi-ip22/Platform |    8 +++++---
 arch/mips/sgi-ip32/Platform |    2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

linux-mips-4.10-add-platform-ifdefs.patch
diff --git a/arch/mips/sgi-ip22/Platform b/arch/mips/sgi-ip22/Platform
index b7a4b7e04c38..5fa3c7a107bd 100644
--- a/arch/mips/sgi-ip22/Platform
+++ b/arch/mips/sgi-ip22/Platform
@@ -7,7 +7,8 @@
 # current variable will break so for 64-bit kernels we have to raise the start
 # address by 8kb.
 #
-platform-$(CONFIG_SGI_IP22)		+= sgi-ip22/
+ifdef CONFIG_SGI_IP22
+platform-$(CONFIG_SGI_IP22)	+= sgi-ip22/
 cflags-$(CONFIG_SGI_IP22)	+= -I$(srctree)/arch/mips/include/asm/mach-ip22
 ifdef CONFIG_32BIT
 load-$(CONFIG_SGI_IP22)		+= 0xffffffff88002000
@@ -15,6 +16,7 @@ endif
 ifdef CONFIG_64BIT
 load-$(CONFIG_SGI_IP22)		+= 0xffffffff88004000
 endif
+endif
 
 #
 # SGI IP28 (Indigo2 R10k)
@@ -28,7 +30,7 @@ ifdef CONFIG_SGI_IP28
   ifeq ($(call cc-option-yn,-mr10k-cache-barrier=store), n)
       $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
   endif
-endif
-platform-$(CONFIG_SGI_IP28)		+= sgi-ip22/
+platform-$(CONFIG_SGI_IP28)	+= sgi-ip22/
 cflags-$(CONFIG_SGI_IP28)	+= -mr10k-cache-barrier=store -I$(srctree)/arch/mips/include/asm/mach-ip28
 load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000
+endif
diff --git a/arch/mips/sgi-ip32/Platform b/arch/mips/sgi-ip32/Platform
index 589930560088..7db2c1f05d89 100644
--- a/arch/mips/sgi-ip32/Platform
+++ b/arch/mips/sgi-ip32/Platform
@@ -6,8 +6,10 @@
 # a multiple of the kernel stack size or the handling of the current variable
 # will break.
 #
+ifdef CONFIG_SGI_IP32
 platform-$(CONFIG_SGI_IP32)	+= sgi-ip32/
 cflags-$(CONFIG_SGI_IP32)	+= -I$(srctree)/arch/mips/include/asm/mach-ip32
 cflags-$(CONFIG_CPU_R10000)		+= -mr10k-cache-barrier=load-store
 cflags-$(CONFIG_CPU_R12K_R14K_R16K)	+= -mno-fix-r10000 -mr10k-cache-barrier=load-store
 load-$(CONFIG_SGI_IP32)		+= 0xffffffff80004000
+endif
