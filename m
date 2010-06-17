Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 13:06:23 +0200 (CEST)
Received: from ossa.mas.viperplatform.net.au ([202.147.75.25]:59786 "EHLO
        ossa.mas.viperplatform.net.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491876Ab0FQLGT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 13:06:19 +0200
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim 4.43)
        id 1OPCv9-0004or-Ik
        for linux-mips@linux-mips.org; Thu, 17 Jun 2010 21:06:09 +1000
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
        by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
        id 1OPCv9-0004of-Gw
        for linux-mips@linux-mips.org; Thu, 17 Jun 2010 21:06:07 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim 4.43)
        id 1OPCv8-00089d-3U
        for linux-mips@linux-mips.org; Thu, 17 Jun 2010 21:06:07 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
        by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
        id 1OPCv8-00089a-2K
        for linux-mips@linux-mips.org; Thu, 17 Jun 2010 21:06:06 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
        by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
        id 1OPCv7-0007p2-Or
        for linux-mips@linux-mips.org; Thu, 17 Jun 2010 21:06:06 +1000
Received: (qmail 32611 invoked by uid 1000); 17 Jun 2010 11:06:05 -0000
Date:   Thu, 17 Jun 2010 21:06:05 +1000
From:   Stuart Longland <redhatter@gentoo.org>
To:     Wu <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v4 00/16] Cleanup Lemote FuLoong2e Support
Message-ID: <20100617110605.GA32400@www.longlandclan.yi.org>
References: <cover.1246546684.git.wuzhangjin@gmail.com>
 <20100617104735.GC24561@www.longlandclan.yi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100617104735.GC24561@www.longlandclan.yi.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Clarity-Outbound-SpamScanned: YES
X-archive-position: 27151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11943

Dropping Cc's to reduce undue noise, I've made enough already. ;-)

On Thu, Jun 17, 2010 at 08:47:35PM +1000, Stuart Longland wrote:
> Hi,
> On Thu, Jul 02, 2009 at 11:15:52PM +0800, Wu wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> >
> > This patch series is the -v4 version of the loongson-PATCH-v3 series, but it
> > only include the cleanup for fuloong2e support and necessary preparation for
> > future fuloong-2f and yeeloong-2f support.
> >
> > The git branch of this patch series is:
> >
> > 	git://dev.lemote.com/rt4ls.git linux-loongson/dev/fuloong2e
>
> I can't seem to find a linux-loongson/dev/fuloong2e branch... did I miss
> the boat?  I'm looking to update the kernels on the two Fulongs 2Es
> here... as I'm having grief compiling Python 2.6 -- hard locks always at
> the same point, and I have a feeling it's the
> kernel+kernel-build-toolchain combo that's possibly to blame.

Okay, disregard the above... I should learn to check mail timestamps
before I hit the reply-all button.  That said... I'd be curious to know
what the present status is.  Been out of the loop for a while, and only
just starting to get back in again.
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
