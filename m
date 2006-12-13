Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2006 02:23:37 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:20443 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20039672AbWLMCXa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Dec 2006 02:23:30 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id kBD2NL5N009351;
	Tue, 12 Dec 2006 18:23:22 -0800 (PST)
Received: from ism-mail01.corp.ad.wrs.com ([128.224.200.18]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 Dec 2006 18:23:21 -0800
Received: from 147.11.233.37 ([147.11.233.37]) by ism-mail01.corp.ad.wrs.com ([128.224.200.18]) via Exchange Front-End Server webmail-na.wrs.com ([147.11.57.147]) with Microsoft Exchange Server HTTP-DAV ;
 Wed, 13 Dec 2006 02:23:17 +0000
Received: from mark.zhan by webmail-na.wrs.com; 12 Dec 2006 21:23:17 -0500
Subject: Re: Re:hwo to improve a video decoder program's timeslice
From:	"Mark.Zhan" <rongkai.zhan@windriver.com>
To:	Philippe De Swert <philippedeswert@scarlet.be>
Cc:	"zzh.hust" <zzh.hust@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <JA4FU5$15B25B9E0AEC49C3D47C4ABD5469CF70@scarlet.be>
References: <JA4FU5$15B25B9E0AEC49C3D47C4ABD5469CF70@scarlet.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 12 Dec 2006 21:23:17 -0500
Message-Id: <1165976597.5831.13.camel@localhost.wrs.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-OriginalArrivalTime: 13 Dec 2006 02:23:21.0391 (UTC) FILETIME=[A8AADBF0:01C71E5D]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

On Mon, 2006-12-11 at 19:10 +0100, Philippe De Swert wrote:
> Hi,
> 
> >  i have a video decoder program run as aplication
> > and i now have change the HZ from 1000 to 100, set the decoder program
> > priority as 99.
> 
> Seems you are mixing things here... The HZ change will just change the
> interval of the timer tick. For some more explanations about this, look here :
> http://kerneltrap.org/node/464

The decrement of the timer tick number definitely can increase the
execution time of application. And Disable kernel preemption also has
the same impact.

> 
> > if i want to the video decoder program to get more time to run, is
> > there any other way to improve it ?
> 
> Maybe using nice? Try "man nice" in a terminal on your Linux box to get more
> explanations about this.
> 
> Cheers,
> 
> Philippe---
> Scarlet ONE -  Combine ADSL with unlimited fixed phone and save 400 euros
> http://www.scarlet.be
> 
> 
-- 
Best Regards
Mark.Zhan
Wind River Beijing Engineer Team
