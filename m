Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 09:33:43 +0100 (BST)
Received: from smtp-out.comcast.net ([IPv6:::ffff:24.153.64.115]:9310 "EHLO
	smtp-out.comcast.net") by linux-mips.org with ESMTP
	id <S8225202AbTDOIdm>; Tue, 15 Apr 2003 09:33:42 +0100
Received: from gentoo.org
 (pcp02545003pcs.waldrf01.md.comcast.net [68.48.92.102])
 by mtaout09.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0HDD00E9HMFK8E@mtaout09.icomcast.net> for
 linux-mips@linux-mips.org; Tue, 15 Apr 2003 04:33:20 -0400 (EDT)
Date: Tue, 15 Apr 2003 04:35:23 -0400
From: Kumba <kumba@gentoo.org>
Subject: Re: Oddities with CVS Kernels, Memory on Indigo2
In-reply-to: <20030414140717.GA805@simek>
To: linux-mips@linux-mips.org
Reply-to: kumba@gentoo.org
Message-id: <3E9BC44B.8080708@gentoo.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3)
 Gecko/20030312
References: <3E98F206.5050206@gentoo.org> <20030414140717.GA805@simek>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


	A question with the CVS Kernel.  Are there any known issues as to the 
specific toolchain used to build it?  Currently I'm using GCC 3.2.2 + 
Glibc 2.3.2 + Binutils 2.13.90.0.16.  I tried a CVS updateshortly after 
testing this kernel, and it still doesn't boot, so either my timing is 
really bad, or I'm using a toolchain with known issues.  I have noticed 
the toolchain does not support -mcpu in .18 of binutils, and I 
originally thought this was only going to be a GCC change in 3.3, but my 
guess if it's the same in .18/.20, and as such I'll need to use the 
instructions posted about a month about to use -mabi/-march?

--Kumba


Ladislav Michl wrote:
> On Sun, Apr 13, 2003 at 01:13:42AM -0400, Kumba wrote:
> 
> I'd say you've tried cvs kernel at the times when support for R4400
> caches was broken. I put kernel I'm currently running at
> http://www.linux-mips.org/~ladis/vmlinux.gz (gunzip it :)), as you can
> see from dmesg at the end of this mail CPU used in your machine is the
> same. If kernel I provided doesn't boot for you I'd like to ask you for
> help with debugging (kernel was build from cvs updated at 8:30 CEST)
