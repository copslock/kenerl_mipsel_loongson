Received:  by oss.sgi.com id <S305159AbQBPSUm>;
	Wed, 16 Feb 2000 10:20:42 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:13165 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBPSU1>;
	Wed, 16 Feb 2000 10:20:27 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA19750; Wed, 16 Feb 2000 10:15:56 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA99594
	for linux-list;
	Wed, 16 Feb 2000 10:03:07 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA76628
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 16 Feb 2000 10:03:00 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA06661
	for <linux@cthulhu.engr.sgi.com>; Wed, 16 Feb 2000 10:03:03 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port216.duesseldorf.ivm.de [195.247.65.216])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id TAA24531;
	Wed, 16 Feb 2000 19:02:37 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000216190319.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.3.p0.Linux:000216190255:1753=_"
In-Reply-To: <38A91E19.CE7A9890@niisi.msk.ru>
Date:   Wed, 16 Feb 2000 19:03:19 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Subject: RE: -fno-strict-aliasing problem in the latest 2.3
Cc:     linux-mips@fnet.fr, SGI Linux <linux@cthulhu.engr.sgi.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

This message is in MIME format
--_=XFMail.1.3.p0.Linux:000216190255:1753=_
Content-Type: text/plain; charset=us-ascii

Hi,

On 15-Feb-00 Gleb O. Raiko wrote:
> There is a problem with the way main Makefile determines whether the
> compiler suports -fno-strict-aliasing. Namely, Makefile blindly gets $CC
> and tries to feed this option to it. Unfortunately, we set CC to proper
> mips[el]-linux-gcc later in arch/mips/Makefile, so the main Makefile
> just checks against native gcc. On RH6.1 with latest cross tool rpms
> installed, I get cc1: Invalid option `-fno-strict-aliasing' during
> comppilation, obviously.

I am not exactly shure if it has ill side effects or if this may not be wanted
for some reason, but the attached patch fixes that for me.

OK to commit?
---
Regards,
Harald

--_=XFMail.1.3.p0.Linux:000216190255:1753=_
Content-Disposition: attachment; filename="Makefile-patch"
Content-Transfer-Encoding: 7bit
Content-Description: Makefile-patch
Content-Type: text/plain; charset=us-ascii; name=Makefile-patch; SizeOnDisk=835

--- /nfs/cvs/linux-2.3/linux/Makefile	Wed Feb 16 18:40:57 2000
+++ Makefile	Wed Feb 16 18:53:13 2000
@@ -96,9 +96,6 @@
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
 AFLAGS := $(CPPFLAGS)
 
-# use '-fno-strict-aliasing', but only if the compiler can take it
-CFLAGS += $(shell if $(CC) -fno-strict-aliasing -S -o /dev/null -xc /dev/null >
/dev/null 2>&1; then echo "-fno-strict-aliasing"; fi)
-
 #
 # if you want the RAM disk device, define this to be the
 # size in blocks.
@@ -252,6 +249,9 @@
 endif
 
 include arch/$(ARCH)/Makefile
+
+# use '-fno-strict-aliasing', but only if the compiler can take it
+CFLAGS += $(shell if $(CC) -fno-strict-aliasing -S -o /dev/null -xc /dev/null >
/dev/null 2>&1; then echo "-fno-strict-aliasing"; fi)
 
 .S.s:
 	$(CC) -D__ASSEMBLY__ $(AFLAGS) -traditional -E -o $*.s $<

--_=XFMail.1.3.p0.Linux:000216190255:1753=_--
End of MIME message
