Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 11:24:12 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:34838 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133438AbWBWLYE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 11:24:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1NBVFsv004486;
	Thu, 23 Feb 2006 11:31:15 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1NBVFfH004485;
	Thu, 23 Feb 2006 11:31:15 GMT
Date:	Thu, 23 Feb 2006 11:31:15 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stuart Anderson <anderson@netsweng.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [RFC] SMP initialization order fixes.
Message-ID: <20060223113115.GA3728@linux-mips.org>
References: <20060222190940.GA29967@linux-mips.org> <Pine.LNX.4.64.0602221636300.5110@trantor.stuart.netsweng.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602221636300.5110@trantor.stuart.netsweng.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 22, 2006 at 04:41:43PM -0500, Stuart Anderson wrote:
> Date:	Wed, 22 Feb 2006 16:41:43 -0500 (EST)
> From:	Stuart Anderson <anderson@netsweng.com>
> To:	linux-mips@linux-mips.org
> Subject: Re: [RFC] SMP initialization order fixes.
> Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
> 
> On Wed, 22 Feb 2006, Ralf Baechle wrote:
> 
> >This one should hopefully fix the SMP problems of the resent times.  It
> >works on Malta with 34K, it seems to work on IP27 (the kernel is
> >presumably failing due to other issues), so now I'd ask especially
> >RM9000 & BCM1250 users for testing.  This really needs to be fixed for
> >2.6.16.
> 
> I'm not sure if this is the specific fix or not, but I can report that git
> as of today (approx 2pm est) is working better than is has since 2.6.14 for
> me on a bcm1480. I had tried git a couple of weeks ago, and it still hung
> when I stressed it.

Seems unrelated then.  This fix should make the difference between working
perfectly or not at all.  There have been numerous other fixes since 2.6.14
so hard to say what made the difference.

  Ralf
