Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2002 20:11:05 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:48374 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122121AbSJaTLE>;
	Thu, 31 Oct 2002 20:11:04 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g9VJAt414462;
	Thu, 31 Oct 2002 11:10:55 -0800
Date: Thu, 31 Oct 2002 11:10:55 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] halloween candy for make mips/mips64
Message-ID: <20021031111055.C6408@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


For lazy fingers, this patch saves quite some typing when
you work on mips64.  It detects which arch you are working with
from .config if it is present.  Otherwise, it defaults to
mips.

Like this treat?

Jun


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

diff -Nru Makefile.orig Makefile
--- Makefile.orig	Wed Sep 11 05:44:23 2002
+++ Makefile	Thu Oct 31 11:02:47 2002
@@ -5,7 +5,7 @@
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
-ARCH = mips
+ARCH = $(shell echo mips`grep '^CONFIG_MIPS64=y$$' .config | sed -e 's/..*/64/'`)
 KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//g")
 
 CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \

--gBBFr7Ir9EOA20Yy--
