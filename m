Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G846l17434
	for linux-mips-outgoing; Thu, 16 Aug 2001 01:04:06 -0700
Received: from web13402.mail.yahoo.com (web13402.mail.yahoo.com [216.136.175.60])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G844j17428
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 01:04:04 -0700
Message-ID: <20010816080404.58868.qmail@web13402.mail.yahoo.com>
Received: from [194.201.166.113] by web13402.mail.yahoo.com; Thu, 16 Aug 2001 09:04:04 BST
Date: Thu, 16 Aug 2001 09:04:04 +0100 (BST)
From: =?iso-8859-1?q?Zoon?= <zoon974@yahoo.com>
Subject: Soft-Float emulation with gcc - pr3900
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1010814193527.5426C-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello, 

Although this message is more about gcc, I post here,
since I got no answer from gcc mailing lists.

I use egcs-2.91.66(Algorithmics tools) configured as a
cross-compiler on a i386 host. I got the binary
version, so didn't configured it myself.

I'm working with a PR3900 type MIPS core. Those core
don't have a Floating Point Unit, nor floating point
registers.
When using -msoft-float, I am supposed to use the
libgcc soft floating point emulation. However, I
cannot prevent gcc from using fp registers.
When looking at gcc specs:

$ mips-linux-gcc -dumpspecs | grep r3900
..
%{m3900:-mips1 -mcpu=r3900 -mfp32 -mgp32}...

The option -mfp32 is defined as the default, which
means gcc assume 32 bit fp registers are available.

I am aware of two soft-float emulation libraries:
Gofast and libgcc. However I can't figure out how
emulation can be achieved if gcc keeps using fp
registers. 

I must miss something about it, could someone help me
with this matter ?

Many thanks,
Alain

____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
