Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jul 2004 17:15:05 +0100 (BST)
Received: from host73.ipowerweb.com ([IPv6:::ffff:12.129.211.254]:33119 "EHLO
	host73.ipowerweb.com") by linux-mips.org with ESMTP
	id <S8224943AbUGVQPA> convert rfc822-to-8bit; Thu, 22 Jul 2004 17:15:00 +0100
Received: from c-67-170-233-233.client.comcast.net ([67.170.233.233] helo=ratwin1)
	by host73.ipowerweb.com with asmtp (Exim 3.36 #1)
	id 1BngDT-0001tJ-00; Thu, 22 Jul 2004 09:14:43 -0700
Reply-To: <ratin@koperasw.com>
From: "Ratin Kumar" <ratin@koperasw.com>
To: "'Ralf Ackermann'" <rac@KOM.tu-darmstadt.de>,
	<linux-mips@linux-mips.org>
Subject: RE: (cross)compiling for the Meshcube  (fwd)
Date: Thu, 22 Jul 2004 09:14:37 -0700
Organization: Kopera Software Inc.
Message-ID: <000201c47007$0010cec0$6401a8c0@ratwin1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
In-Reply-To: <Pine.LNX.4.58.0407221756020.4845@shofar.kom.e-technik.tu-darmstadt.de>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host73.ipowerweb.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - koperasw.com
Return-Path: <ratin@koperasw.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ratin@koperasw.com
Precedence: bulk
X-list: linux-mips

You don't mention installing libc for the platform. You will need libraries
for the MIPS(el) target to be present in the cross-compile path.
Try ftp://ftp.linux-mips.org/pub/linux/mips/glibc/mipsel-linux/

On doing Native build, if your platform supports tftp loading of boot kernel
(or if it has a boot kernel which you can pass parameter to), load the
kernel with nfsroot="IP-Address-of-server:/path" ip=ip-address-of-target

This requires an NFS image to be kept somewhere reachable by your target.
There is a tarball of RH7.1(mipsel) NFS dump at MIPS ftp for which worked
for my MALTA.

I did (sometime) ago produce NFS image of RH7.3 for my MALTA board. I can
upload it if you can tell me a location where to put it.

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ralf Ackermann
Sent: Thursday, July 22, 2004 8:56 AM
To: linux-mips@linux-mips.org
Cc: Ralf Ackermann
Subject: Q: (cross)compiling for the Meshcube (fwd)


Hello,

I'm trying to (cross)compile some more modules/applications for the 
meshcube - but failed so far.

I installed (on an i386 system):
	binutils-mipsel-linux-2.13.2.1-3.i386.rpm
	gcc-mipsel-linux-2.95.4-1.i386.rpm
(from ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/)

Making a hello world program fails with:
	mipsel-linux-gcc hello.c -o hello
	/usr/mipsel-linux/bin/ld: cannot open crt1.o: No such file or
directory
	collect2: ld returned 1 exit status

My questions:
 - Are there any specific hints for the cross-compile environment
	(or: "What are you using ... and would therefore suggest ?)
 - Is there any chance to use a native gcc on the cube itself?
	(could this e.g. been done by chrooting into a (which?)
	existing MIPS Linux distribution that is mounted via NFS)

Any hints are highly appreciated (I have worked with crosscompile/native 
environments for ARM so far, but these are my first experiences in the 
MIPS world).

regards
 Ralf
 
---------------------------------------------------------------
Dr. Ralf Ackermann            _         rac@KOM.tu-darmstadt.de
Multimedia Communications |/ | | |\/|           Merckstrasse 25
                          |\ |_| |  |  64283 Darmstadt, Germany
Tel.: (+49) 6151 16-6138                Fax: (+49) 6151 16-6152
---------------------------------------------------------------
             http://www.kom.tu-darmstadt.de/~rac
---------------------------------------------------------------
