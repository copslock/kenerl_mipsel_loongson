Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jan 2017 05:09:32 +0100 (CET)
Received: from resqmta-ch2-12v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:44]:36128
        "EHLO resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbdA2EJZGbTqs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jan 2017 05:09:25 +0100
Received: from resomta-ch2-12v.sys.comcast.net ([69.252.207.108])
        by resqmta-ch2-12v.sys.comcast.net with SMTP
        id XgnlcFXFBlNFyXgnrcpmRx; Sun, 29 Jan 2017 04:09:23 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-12v.sys.comcast.net with SMTP
        id Xgnqc9t8NWEg6XgnqcnU1f; Sun, 29 Jan 2017 04:09:23 +0000
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH v2] MIPS: Add ifdefs to IP22/IP32's Platform files
Message-ID: <8cfaf24d-d54a-61a8-8853-c92e642d4f94@gentoo.org>
Date:   Sat, 28 Jan 2017 23:08:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAs11nh0YRUujserOkEa/9Qx1OJwhKE/l/3rYsB44ujdCYOwBI7L2hL/xkE0nGQgXIWBsnW64X8VZ9ddoXOYLOvwjUlZ4tiIxoDPBZ5vdBvDXp/aT93j
 bVhOS3KM2qYyY1EZkgDdi+9a9R8/rrkq32FLF5P1qStKaCMxVeOv+ztMcC9JCFu1rv0fDuLIKqf1DrZHnmcFz14bAy+aGory+i1sT6lAyAdFbtl0z3cow63q
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56536
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
other MIPS platforms.  The IP27 Platform file wraps its directives in
an ifdef block, but the IP22 and IP32 Platform files do not.  This can
lead to the possibility of directives for IP22 or IP32 getting mixed
into the builds of other MIPS platforms.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
Changes in v2: Re-write the patch description and re-diff the patch
against the correct local branch in git.

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
index 0fea556f3641..9097238fc0fc 100644
--- a/arch/mips/sgi-ip32/Platform
+++ b/arch/mips/sgi-ip32/Platform
@@ -6,6 +6,8 @@
 # a multiple of the kernel stack size or the handling of the current variable
 # will break.
 #
+ifdef CONFIG_SGI_IP32
 platform-$(CONFIG_SGI_IP32)	+= sgi-ip32/
 cflags-$(CONFIG_SGI_IP32)	+= -I$(srctree)/arch/mips/include/asm/mach-ip32
 load-$(CONFIG_SGI_IP32)		+= 0xffffffff80004000
+endif
