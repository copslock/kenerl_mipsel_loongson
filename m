Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2009 02:23:41 +0100 (BST)
Received: from e34.co.us.ibm.com ([32.97.110.152]:50237 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023550AbZEPBXf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2009 02:23:35 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4G1Ki8Y016498;
	Fri, 15 May 2009 19:20:44 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n4G1NPQf214836;
	Fri, 15 May 2009 19:23:25 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n4G1NOp9006048;
	Fri, 15 May 2009 19:23:25 -0600
Received: from [9.76.205.89] (sig-9-76-205-89.mts.ibm.com [9.76.205.89])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id n4G1NNrh005999;
	Fri, 15 May 2009 19:23:24 -0600
Subject: Re: [PATCH 23/30] loongson: CS5536 MFGPT as system clock source
 support
From:	John Stultz <johnstul@us.ibm.com>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <1242436541.10164.194.camel@falcon>
References: <1242426182.10164.168.camel@falcon>
	 <1f1b08da0905151739v6bc2e5f6t57cb8e06cdda2673@mail.gmail.com>
	 <1242436541.10164.194.camel@falcon>
Content-Type: text/plain
Date:	Fri, 15 May 2009 18:23:24 -0700
Message-Id: <1242437004.29511.202.camel@jstultz-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <johnstul@us.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johnstul@us.ibm.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-05-16 at 09:15 +0800, Wu Zhangjin wrote:
> On Fri, 2009-05-15 at 17:39 -0700, john stultz wrote:
> > On Fri, May 15, 2009 at 3:23 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> > > +static struct clocksource clocksource_mfgpt = {
> > > +    .name = "mfgpt",
> > > +    .rating = 1200,
> > 
> > Minor nit. Please read the comment over the struct clocksource
> > definition in include/linux/clocksource.h for a guide to setting the
> > rating value for your clocksource.
> > 
> 
> as the comment describes, just like the 8253 Timer, the precision of
> cs5536 mfgpt Timer is not good, the rating of it should be in the range
> of 100-199? Functional for real use, but not desired?

That would seem reasonable to me, as it insures that should better
clocksources become available on the hardware, it will pick the better
hardware.

But I'll leave the final call to you.

I just wanted to make sure we're all using the same scale, and 1200 was
off the charts ;)

thanks
-john
