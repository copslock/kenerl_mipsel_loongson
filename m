Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6DBBXRw026926
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 13 Jul 2002 04:11:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6DBBX8p026925
	for linux-mips-outgoing; Sat, 13 Jul 2002 04:11:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6DBBQRw026914
	for <linux-mips@oss.sgi.com>; Sat, 13 Jul 2002 04:11:26 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6DBG1Xb018992
	for <linux-mips@oss.sgi.com>; Sat, 13 Jul 2002 04:16:01 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA24873
	for <linux-mips@oss.sgi.com>; Sat, 13 Jul 2002 04:15:59 -0700 (PDT)
Message-ID: <023e01c22a5e$c013f120$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@oss.sgi.com>
Subject: Gcc v2.96 versus Trolltech QtEmbedded Window System
Date: Sat, 13 Jul 2002 13:15:54 +0200
Organization: MIPS Technologies, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am trying to build the GPL version of the Trolltech
QT embedded windowing system on my Malta, using
what I believe to be H.J. Lu's most recent tool chain:

[root@localhost release-emb-generic]# g++ -v
Reading specs from /usr/lib/gcc-lib/mipsel-redhat-linux-gnu/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110.1)

The QT build process is a little unusual - the configure
script causes a fairly huge (640KB) C++ source file
to be generated, which is then thrown at the compiler.
I would expect that to take a while, but after about 
20 hours with zero output passed to the assembler
stage (it runs with -pipe) and the gradual accretion
of about 90MB of virtual memory (on my poor 32MB
system) I concluded that it was probably trapped in
an infinite loop.  As I have seen this sort of thing occur
in the past in optimizer stages, I hacked the makefile
to replace -O2 with -O0.  It hasn't run for 20 hours
at -O0 yet, but after a couple of hours the memory 
allocation dynamic looks to be the same, only faster
(72MB after only a couple of hours), so I'm not
optimistic.

My questions to the assembled panel of experts are:

Are there known problems with gcc 2.96.110.1 in
this regard?

Is there a native toolchain that would be more 
likely to be able to handle the build of QT?
I'm considering trying the 2.95 set on Maciej's
site out of desperation.

Has anyone succeeded in building QT Embedded
for mips(el) Linux, either native or using cross-tools?

            Regards,

            Kevin K.
