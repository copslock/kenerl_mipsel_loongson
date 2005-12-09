Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2005 18:25:03 +0000 (GMT)
Received: from mail.alphastar.de ([194.59.236.179]:38927 "EHLO
	mail.alphastar.de") by ftp.linux-mips.org with ESMTP
	id S3458520AbVLISYn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Dec 2005 18:24:43 +0000
Received: from Snailmail (217.249.204.171)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Fri, 9 Dec 2005 19:21:37 +0100
Received: from Opal.Peter (Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id jB9IMPbf002565;
	Fri, 9 Dec 2005 19:22:26 +0100
Received: from Opal.Peter (localhost [127.0.0.1])
	by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Sendmail/Linux 2.4.24-1-386) with ESMTP id jB9IMHp2001605;
	Fri, 9 Dec 2005 19:22:17 +0100
Received: from localhost (pf@localhost)
	by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Debian-1) with ESMTP id jB9IMGH4001601;
	Fri, 9 Dec 2005 19:22:16 +0100
Date:	Fri, 9 Dec 2005 18:22:14 +0100 (CET)
From:	peter fuerst <pf@net.alphadv.de>
To:	linux-mips@linux-mips.org
cc:	Stuart Longland <redhatter@gentoo.org>
Subject: Re: SGI IP28 Kernels... anyone had any luck lately?
In-Reply-To: <4399972C.5060604@gentoo.org>
Message-ID: <Pine.LNX.4.21.0512091803080.1379-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
ReSent-Date: Fri, 9 Dec 2005 19:21:52 +0100 (CET)
ReSent-From: peter fuerst <pf@net.alphadv.de>
ReSent-To: Stuart Longland <redhatter@gentoo.org>,
	   linux-mips@linux-mips.org
ReSent-Subject:	Re: SGI IP28 Kernels... anyone had any luck lately?
ReSent-Message-ID: <Pine.LNX.4.21.0512091921520.1600@Opal.Peter>
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Hi all,

sorry, obviously forgot to "tar" with the "-h" option.  The kernel patch-set
is now repackaged with README and .config (same location).  I wonder, why no
one noticed their missing since Oct 17...
For exactness' sake: the patches are based on linux-2.6.14-rc2-mipscvs-20050925
Maybe .config will enable compiling, the error-messages seem to point
to a misconfiguration, since the compiler didn't touch any of the patched
files yet.

There's still a problem with the Xserver: often, when starting up the Xserver
first after a cold boot, it likes to hang (in a loop, waiting for "dmabusy"
to settle down, either in the kernel-driver or the Xserver itself, when
re-mmapping the dma-buffer). Usually, after a reset the Xserver works okay.
I couldn't find a solution for this yet, but otherwise (;-) i easily (can) use
the machine for regular work (no more hangs after the Xserver started up once).

kind regards

pf



On Sat, 10 Dec 2005, Stuart Longland wrote:

> Date: Sat, 10 Dec 2005 00:39:40 +1000
> From: Stuart Longland <redhatter@gentoo.org>
> Reply-To: linux-mips-bounce@linux-mips.org
> To: linux-mips@linux-mips.org
> Subject: SGI IP28 Kernels... anyone had any luck lately?
> 
> Hi all,
> 	I'm not sure what's causing this error, could very well be PEBKAC, but
> anyways.
> 
> 	I've been striking issues getting kernels for my IP28 to compile.  So
> far, I've tried both the 2.6.14 and 2.6.14-rc2 tags, the IP28 patches[1]
> apply successfully, but the subsequent compile fails with these
> messages: http://pastebin.com/455158
> 
> 	Incidentally, the tarball you download containing the patches,
> apparently has a README and .config file included.  Well, there's
> symlinks to the files, but it seems the actual files themselves got
> missed in the archive.  I used the /proc/config.gz from my currently
> running kernel (2.6.12-rc2, also works with 2.6.13.4).
> 
> 	I was hoping to try out Impact support, in console and X, as well as
> HAL2 support (which was b0rked last time I tried it).
> 
> 	Has anyone had any luck, and if so, any ideas what I'm doing wrong?
> Regards,
> -- 
> Stuart Longland (aka Redhatter)              .'''.
> Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
> . . . . . . . . . . . . . . . . . . . . . .   .'.'
> http://dev.gentoo.org/~redhatter             :.'
> 
> 1. http://home.alphastar.de/fuerst/download.html
> 
