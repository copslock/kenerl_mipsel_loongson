Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 09:22:12 +0200 (CEST)
Received: from wf-out-1314.google.com ([209.85.200.169]:60296 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492012AbZGAHWG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2009 09:22:06 +0200
Received: by wf-out-1314.google.com with SMTP id 28so254891wfa.21
        for <multiple recipients>; Wed, 01 Jul 2009 00:16:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=qSqIM2hwuk5fLj9hd+QBdr7RkwXiBkKCVx9g1CYIBvw=;
        b=Fe71wJQ4uGbw9Qf9/cfpYajParx03KoDVPkXKoFAgpP1ucq0S6apPKsv1bjMKJGZx6
         iHoIo2iGslRcVYYMRAkbpXO+qUGtaumXEU0Isye0bptYHd755Ih2i771TkOEd9I4pwh9
         81RpzsLKCB/hS06wTwyhi+ojsOnNF+V506wGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=q07QBAgJISnamOT8oyqk8lzBKNC6TnHfybjHEsWcfAWTgTRl3CqKN18rcVyiEJi9iY
         tToM/N1Jam0EpPLD7/TpLtk03sF2lVk9IUAgs4ohBq2tnD6uUhX51jplDDF8/wxGSVK6
         a+WOLr8K2rbcFdw60O7gCQuFjrEOfo0+mcbfU=
Received: by 10.142.226.1 with SMTP id y1mr470718wfg.294.1246432600263;
        Wed, 01 Jul 2009 00:16:40 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 30sm3145928wfd.23.2009.07.01.00.16.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 00:16:39 -0700 (PDT)
Subject: Re: [BUG] MIPS: Hibernation in the latest linux-mips:master branch
 not work
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org
Cc:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20090630144540.GA18212@linux-mips.org>
References: <1246372868.19049.17.camel@falcon>
	 <20090630144540.GA18212@linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Wed, 01 Jul 2009 15:16:10 +0800
Message-Id: <1246432570.9660.22.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-06-30 at 15:45 +0100, Ralf Baechle wrote:
> On Tue, Jun 30, 2009 at 10:41:08PM +0800, Wu Zhangjin wrote:
> 
> > I just updated my git repository to the master branch of the latest
> > linux-mips git repository, and tested the STD/Hibernation support on
> > fuloong2e and yeeloong2f, it failed:
> > 
> > when using the no_console_suspend kernel command line to debug, it
> > stopped on:
> > 
> > PM: Shringking memory... done (1000 pages freed)
> > PM: Freed 160000 kbytes in 1.68 seconds (95.23 MB/s)
> > PM: Creating hibernation image:
> > PM: Need to copy 5053 pages
> > PM: Hibernation image created (4195 pages copied)
> > 
> > and then, the number indicator light of keyboard works well, but can not
> > type anything. 
> > 
> > anybody have tested it on another platform? does it work?
> 
> At the time of the merge I tested it on Malta and found it to be working.
> 

Just traced it, the executing path is something like this:

	hibernate(kernel/power/hibernate.c)
	--> hibernation_snapshot
	--> dpm_resume_end
	--> dpm_resume
        --> device_resume
	--> dev->bus->resume(generic_ide_resume), dev_name(dev) = 0.0
	--> blk_execute_rq
        {
		DECLARE_COMPLETION_ONSTACK(wait);
		...
		wait_for_completion(&wait);	// stop here
		...
	}

I guess there is a possible bug in the latest ide patches, I'm trying to
find which one is 'bad'.

the ide driver i used is VIA82CXXX chipset support.

Regards,
Wu Zhangjin
