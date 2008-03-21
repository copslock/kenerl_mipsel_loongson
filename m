Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 23:54:48 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:18715 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S28578898AbYCUXyq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Mar 2008 23:54:46 +0000
Received: from SNaIlmail.Peter (85.233.32.210.static.cablesurf.de [85.233.32.210])
	by mail1.pearl-online.net (Postfix) with ESMTP id 29058CA17;
	Sat, 22 Mar 2008 00:54:41 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id m2L3KMfM001807;
	Fri, 21 Mar 2008 04:20:22 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id m2LNj3FS000629;
	Sat, 22 Mar 2008 00:45:03 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id m2LNj3rB000626;
	Sat, 22 Mar 2008 00:45:03 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Sat, 22 Mar 2008 00:45:03 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] WD33C93: let platform stub override no_sync/fast/dma_mode
In-Reply-To: <20080321230424.GA31455@alpha.franken.de>
Message-ID: <Pine.LNX.4.58.0803220038510.622@Indigo2.Peter>
References: <20080321212543.6F769C2DF8@solo.franken.de>
 <Pine.LNX.4.58.0803212302190.564@Indigo2.Peter> <20080321230424.GA31455@alpha.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



On Sat, 22 Mar 2008, Thomas Bogendoerfer wrote:

> Date: Sat, 22 Mar 2008 00:04:24 +0100
> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> To: peter fuerst <post@pfrst.de>
> Cc: linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
>      ralf@linux-mips.org, James.Bottomley@HansenPartnership.com
> Subject: Re: [PATCH] WD33C93: let platform stub override
>     no_sync/fast/dma_mode
>
> On Fri, Mar 21, 2008 at 11:20:07PM +0100, peter fuerst wrote:
> > ...
>
> this hack is IMHO no longer needed. If the user wants to override no_sync
> via kernel command line, it works as before. If the user doesn't no_sync
> will be 0 (now set in sgiwd93.c before calling wd33c93_init()) and the
> driver will try to do sync transfers for all devices. It works like before.

It works cleaner than before :-)

> Or did I miss something ?

No. As already said, just forget it, i missed to look at the whole patch in time.

>
> Thomas
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessary a
> good idea.                                                [ RFC1925, 2.3 ]
>
>
