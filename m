Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jul 2004 04:22:22 +0100 (BST)
Received: from PPP-219-65-135-21.bng.vsnl.net.in ([IPv6:::ffff:219.65.135.21]:12812
	"EHLO mac.com") by linux-mips.org with ESMTP id <S8224914AbUGGDWR>;
	Wed, 7 Jul 2004 04:22:17 +0100
Received: from eng32 [192.168.48.96] by mac.com [192.168.48.242]
	with SMTP (MDaemon.v3.0.0.R)
	for <linux-mips@linux-mips.org>; Wed, 07 Jul 2004 08:51:43 +0530
Message-ID: <000d01c463d1$994e59a0$6030a8c0@eng32>
From: "hemanth" <macindiard@vsnl.net>
To: <linux-mips@linux-mips.org>
Subject: querries on cross compiler
Date: Wed, 7 Jul 2004 08:52:14 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
X-Return-Path: hemanth@mac.com
X-MDRcpt-To: linux-mips@linux-mips.org
X-MDRemoteIP: 192.168.48.96
Return-Path: <macindiard@vsnl.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macindiard@vsnl.net
Precedence: bulk
X-list: linux-mips


Hi,

Iam trying to build a cross compiler for MIPS processor on
"i686-pc-linux-gcc" host. Iam getting some errors during the installation of
BINUTILS(binutils-2.9.1) i.e, after configure, when I type "make" Iam
getting errors. Can u please suggest how to remove these errors.

These are the errors,
root@localhost binutils-2.9.1]# make

make[1]: Entering directory `/root/cross_compiler/binutils-2.9.1/libiberty'

if [ -n "" ] && [ ! -d pic ]; then \

mkdir pic; \

else true; fi

touch stamp-picdir

echo "# !Automatically generated from ./functions.def"\

"- DO NOT EDIT!" >needed2.awk

grep '^DEFVAR(' < ./functions.def \

| sed -e '/DEFVAR/s|DEFVAR.\([^,]*\).*|/\1/ { printf "#ifndef
NEED_\1\\n#define NEED_\1\\n#endif\\n" }|' \

>>needed2.awk

grep '^DEFFUNC(' < ./functions.def \

| sed -e '/DEFFUNC/s|DEFFUNC.\([^,]*\).*|/\1/ { printf "#ifndef
NEED_\1\\n#define NEED_\1\\n#endif\\n" }|' \

>>needed2.awk

gcc -c -g -O2 -I. -I./../include ./dummy.c 2>/dev/null

make[1]: *** [dummy.o] Error 1

make[1]: Leaving directory `/root/cross_compiler/binutils-2.9.1/libiberty'

make: *** [all-libiberty] Error 2

regards,
Hemanth
MACIL
Electronics city
Bangalore
