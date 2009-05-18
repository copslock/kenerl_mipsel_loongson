Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 20:38:18 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:1966 "EHLO MMS3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024326AbZERTiL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 May 2009 20:38:11 +0100
Received: from [10.9.200.133] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 18 May 2009 12:37:49 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.1.358.0; Mon, 18 May 2009 12:39:12 -0700
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 6839F74D03; Mon,
 18 May 2009 12:37:48 -0700 (PDT)
Subject: Re: Bigsur?
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"Imre Kaloz" <kaloz@openwrt.org>
cc:	jfraser@broadcom.com,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <op.ut4264pc2s3iss@richese>
References: <ecbbfeda0905152014t62281c79k2001e428da65a442@mail.gmail.com>
 <1242663215.18301.26.camel@chaos.ne.broadcom.com>
 <op.ut4264pc2s3iss@richese>
Organization: Broadcom
Date:	Mon, 18 May 2009 15:37:47 -0400
Message-ID: <1242675467.18301.48.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8)
X-WSS-ID: 660F668738S23374017-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips



On Mon, 2009-05-18 at 12:02 -0700, Imre Kaloz wrote:
> On 2009.05.18. 18:13:35 Jon Fraser <jfraser@broadcom.com> wrote:
> 
> > I think people that have them, have had them for a while.
> >
> > You can still get, I believe, the bcm91125 and bcm91250.
> > http://www.broadcom.com/products/Data-Telecom-Networks/Communications-Processors/BCM91125E
> > How you actually order one, I don't know.  I assume you have to go to a
> > distributor.
> >
> > When I got a 1480 a year ago, it had to be built and took about 3
> > months. The internal transfer cost was very high.  So I really don't
> > think they are available anymore.  BUT, I don't work for that group.
> >
> > Are people just looking for eval type boards with MIPS cpus?
> >
> > Jon Fraser
> > (Not offical statments for Broadcom)
> 
> <personal rant>
> 
> Some people like me are Linux distro developers -- quite frequently the only way to get our
> hands on boards to be able to support a platform is eBay.
> 
> This creates a funny "disturbance in the force".  At one end we are the ones willing to spend
> not only our free time but personal incomes on supporting some platforms, yet we are the ones
> who have the hardest times making this happen.
> 
> Sticking to your company for example, I was willing to spend the money on a Swarm a few years
> ago. Broadcom ignored my mails, simply as I was an individual who wouldn't order thousands of
> CPUs, "just" that board. So it took me quite some time and luck to hunt down a BCM91125F with
> all it's limits..
> 
> On the other end there are companies who did order Xk CPUs and people who have access to the
> eval boards. Most of these people don't give a damn about anything we do or care for, and are
> happy to finish work and ignore the boards outside work hours -- not that I blame them for
> doing so.
> 
> This is all again the old tale of money and possibilities vs time and willingness.
> 
> </personal rant>
> 
> 
> Imre
> 
Your points are well taken. 

FYI, just so people know, I had no experience with Broadcom prior to the
acquisition of  the start-up company for which I worked. After a couple
of years, they scuttled our group and I transferred to another local
division.  We don't use or have anything to do with the Sibyte
processors.


A few people have been talking about the lack of MIPS based boards and
what can be done about it.  It seems like there are three or more
categories.

1. Generic eval type boards to be used as cross development platforms.
	Probably primarily used for embedded development.

2. System type boards that can self-host.

3. Mission specific eval boards, which tend to be expensive, low volume,
   maybe hard to get boards of little generic interest.  Example:
   bigsur was developed for network processing.


Given that most MIPS processors end up in the embedded market, I assumed
that #1 would be most sought after, but I really know.

What kind of hardware configuration would help people out?


Jon
