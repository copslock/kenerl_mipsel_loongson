Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2003 08:02:16 +0000 (GMT)
Received: from [IPv6:::ffff:211.16.123.115] ([IPv6:::ffff:211.16.123.115]:61682
	"EHLO stardust") by linux-mips.org with ESMTP id <S8225193AbTCLICQ>;
	Wed, 12 Mar 2003 08:02:16 +0000
Received: from stardust ([127.0.0.1])
	by stardust with smtp (Exim 3.36 #1 (Debian))
	id 18t1BG-0001nE-00; Wed, 12 Mar 2003 17:01:42 +0900
Date: Wed, 12 Mar 2003 17:01:41 +0900
From: KUNITAKE Koichi <kunitake@linux-ipv6.org>
To: usagi-users@linux-ipv6.org
Cc: linux-mips@linux-mips.org
Subject: Re: (usagi-users 02263) Usagi kernel for MIPS target
In-Reply-To: <20030312070817.21025.qmail@webmail29.rediffmail.com>
References: <20030312070817.21025.qmail@webmail29.rediffmail.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E18t1BG-0001nE-00@stardust>
Return-Path: <kunitake@linux-ipv6.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kunitake@linux-ipv6.org
Precedence: bulk
X-list: linux-mips

  Hello,

On 12 Mar 2003 07:08:17 -0000
"Santosh " <ipv6_san@rediffmail.com> wrote:

>Can someone tell me what changes i have to make to compile the 
>sources successfully for MIPS target ???

  I have never compiled USAGI for MIPS target, but I think you
should edit linux24/Makefile as following.


--- Makefile.orig       2003-03-12 16:55:06.000000000 +0900
+++ Makefile    2003-03-12 16:55:32.000000000 +0900
@@ -5,7 +5,8 @@
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
-ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
+#ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
+ARCH := mips
 KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//g")
 
 CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
@@ -19,7 +20,7 @@
 HOSTCC         = gcc
 HOSTCFLAGS     = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
 
-CROSS_COMPILE  =
+CROSS_COMPILE  = mips-linux-
 
 #
 # Include the make variables (CC, etc...)


  Did this fail?

Best regards,
