Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jun 2010 12:53:45 +0200 (CEST)
Received: from ossa.mas.viperplatform.net.au ([202.147.75.25]:37071 "EHLO
        ossa.mas.viperplatform.net.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491867Ab0FRKxm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jun 2010 12:53:42 +0200
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim 4.43)
        id 1OPZCT-0002FM-3X
        for linux-mips@linux-mips.org; Fri, 18 Jun 2010 20:53:31 +1000
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
        by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
        id 1OPZCT-0002FE-1j
        for linux-mips@linux-mips.org; Fri, 18 Jun 2010 20:53:29 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim 4.43)
        id 1OPZCM-0007At-MA
        for linux-mips@linux-mips.org; Fri, 18 Jun 2010 20:53:29 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
        by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
        id 1OPZCM-0007Aq-LE
        for linux-mips@linux-mips.org; Fri, 18 Jun 2010 20:53:22 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
        by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
        id 1OPZCK-00014H-TX
        for linux-mips@linux-mips.org; Fri, 18 Jun 2010 20:53:22 +1000
Received: (qmail 1338 invoked by uid 1000); 18 Jun 2010 10:53:20 -0000
Date:   Fri, 18 Jun 2010 20:53:20 +1000
From:   Stuart Longland <redhatter@gentoo.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org, Hua Yan <yanh@lemote.com>,
        zhangfx <zhangfx@lemote.com>, loongson-dev@googlegroups.com
Subject: Re: [PATCH v4 00/16] Cleanup Lemote FuLoong2e Support
Message-ID: <20100618105320.GA30868@www.longlandclan.yi.org>
References: <cover.1246546684.git.wuzhangjin@gmail.com>
 <20100617104735.GC24561@www.longlandclan.yi.org>
 <20100617110605.GA32400@www.longlandclan.yi.org>
 <AANLkTikaIbsfqoJR6OfOMbhyEWiFil_A22pAs1J_TRIS@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikaIbsfqoJR6OfOMbhyEWiFil_A22pAs1J_TRIS@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Clarity-Outbound-SpamScanned: YES
X-archive-position: 27170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12783

Hi,

On Thu, Jun 17, 2010 at 08:12:01PM +0800, wu zhangjin wrote:
> Hi,
> 
> The Email you replied is too old, the basic 2F support have been
> merged into the mainline 2.6.33 and the related workaround of the 2F's
> bug have been pushed into mainline 2.6.34.
> 
> The latest Loongson support have been moved to
> http://dev.lemote.com/code/linux-loongson-community.

Yeah, I did notice the email I was replying to was a year old ...
*after* I hit the send button.  I'll blame it on a long day at work and
leave it at that. ;-)

The link there is good to know, and I'll check it out.

> Back to your problem with FuLoong 2E, before, nobody have reported the
> hard-lock of It, If you want to check whether 2E has a hardware bug, I
> think you can try to check the NOP issue at first for 2F has such an
> issue.
> 
> To check the issue, you can download the fix-nop.c from the
> attachments of http://dev.lemote.com/code/linux-loongson-community and
> use it to replace the original NOPS of the ld and as by something
> else:
> 
> $ make fix-nop
> $ fix-nop $(which as)
> $ fix-nop $(which ld)
> 
> Then recompile python 2.6 with the new tools, if you have used the
> other tools, please use fix-nop on them too.

That fix-nop might be the ticket to solving this issue, we shall see.
It's been an issue for a while with various packages... if I try to
compile some package, most of the time it's okay, but every so often
I'll hit one which will hang the computer.

Compiling qucs on the Yeeloong under its stock Debian OS was one I found
that did it.  Python 2.6.5 on my newly cross-compiled chroot is doing
the same on this Fulong 2E.  One can never know if a package is going to
cause problems, but when it does, it's 100% repeatable; the computer
always fails compiling exactly the same file.

Something that repeatable does not sound like faulty RAM which is the
usual culprit for such problems. ;-)
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
