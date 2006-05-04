Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 20:35:48 +0100 (BST)
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:22919 "EHLO
	mail8.fw-sd.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133786AbWEDTfd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 20:35:33 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id k44JZQ4n000702
	for <linux-mips@linux-mips.org>; Thu, 4 May 2006 19:35:26 GMT
Received: from [43.134.85.135] ([43.134.85.135])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k44JZP7a021702
	for <linux-mips@linux-mips.org>; Thu, 4 May 2006 19:35:26 GMT
Message-ID: <445A577D.7090507@am.sony.com>
Date:	Thu, 04 May 2006 12:35:25 -0700
From:	Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment
 var
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <tim.bird@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tim.bird@am.sony.com
Precedence: bulk
X-list: linux-mips

The following patch allows to build using CROSS_COMPILE from the environment.
I have an automated system which works like this, but it chokes on MIPS when
I use it with (albeit non-standard-named) cross-compiler tools.  An easy
workaround I'm using is to put CROSS_COMPILE on the make command line, but it would
be nice to use the definition already in the environment when I work
manually in the system.

For past discussion of this see:
http://www.linux-mips.org/archives/linux-mips/2003-02/msg00196.html

I'm not sure why the change didn't make it in back in 2003, but
if the complaint was about the use of "?=", that seems to be in use
other places, and fairly standard now.

For example, from the top level kernel Makefile:
ARCH            ?= $(SUBARCH)
CROSS_COMPILE   ?=

Signed-off-by: Tim Bird <tim.bird@am.sony.com>

---
--- alp-linux.orig/arch/mips/Makefile	2006-05-04 12:22:17.000000000 -0700
+++ alp-linux/arch/mips/Makefile	2006-05-04 12:10:22.000000000 -0700
@@ -49,7 +49,7 @@ UTS_MACHINE		:= mips64
 endif

 ifdef CONFIG_CROSSCOMPILE
-CROSS_COMPILE		= $(tool-prefix)
+CROSS_COMPILE		?= $(tool-prefix)
 endif

 CHECKFLAGS-y				+= -D__linux__ -D__mips__ \
