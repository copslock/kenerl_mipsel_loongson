Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 16:52:57 +0100 (BST)
Received: from smtp-out.comcast.net ([IPv6:::ffff:24.153.64.116]:54915 "EHLO
	smtp-out.comcast.net") by linux-mips.org with ESMTP
	id <S8225202AbTDNPw4>; Mon, 14 Apr 2003 16:52:56 +0100
Received: from gentoo.org
 (pcp02545003pcs.waldrf01.md.comcast.net [68.48.92.102])
 by mtaout08.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0HDC00751C2BFU@mtaout08.icomcast.net> for
 linux-mips@linux-mips.org; Mon, 14 Apr 2003 11:51:47 -0400 (EDT)
Date: Mon, 14 Apr 2003 11:53:47 -0400
From: Kumba <kumba@gentoo.org>
Subject: Re: Oddities with CVS Kernels, Memory on Indigo2
In-reply-to: <20030414140717.GA805@simek>
To: linux-mips@linux-mips.org
Reply-to: kumba@gentoo.org
Message-id: <3E9AD98B.90808@gentoo.org>
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
X-archive-position: 2023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ladislav Michl wrote:
> I'd say you've tried cvs kernel at the times when support for R4400
> caches was broken. I put kernel I'm currently running at
> http://www.linux-mips.org/~ladis/vmlinux.gz (gunzip it :)), as you can
> see from dmesg at the end of this mail CPU used in your machine is the
> same. If kernel I provided doesn't boot for you I'd like to ask you for
> help with debugging (kernel was build from cvs updated at 8:30 CEST)
> 

Wow, this booted.  Several people I talked to thought it was originally 
a serial console issue.  Judging by the several times I've chosen to 
build a kernel, it seems R4400 cache gets broken quite often.  I'll run 
a cvs sync now and try to build my own kernel, since this appears to be 
built from recent code.  Your kernel lacked a few things gentoo requires 
to boot, but it at least proves I'm not going insane over here.



> This is known bug, but unfortunately I have not enough RAM to meet it...

A known bug?  Interesting.  I mentioned it many moons ago in #mipslinux, 
and Ralf seemed curious about it, but he said he looked in the kernel 
where the memory was detected and said he didn't see anything wrong 
there.  Anything I can do to help look into this bug and possibly fix?


>>parport0: PC-style at 0x278 [PCSPP,TRISTATE,EPP]
> 
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> it can't work ;)

It worked fine for me with printing :)

[root@angband root]# echo "Hello World" > /dev/lp0
[root@angband root]# echo "Wow, It works" > /dev/lp0
[root@angband root]# echo "Totally Cool" > /dev/lp0

^---  All printed out on paper, although scratchy.  I need new ink 
cartridges.  Canon BJC-620

Mind you, that's an ISA Parallel Port card I dropped in.  I noticed the 
SGI's parallel port never worked, so I dug up a spare and tried it.


--Kumba
