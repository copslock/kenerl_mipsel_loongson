Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 19:10:08 +0100 (BST)
Received: from pyxis.i-cable.com ([203.83.115.105]:58356 "HELO
	pyxis.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20024683AbZCaSKD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 19:10:03 +0100
Received: (qmail 25706 invoked by uid 104); 31 Mar 2009 18:09:55 -0000
Received: from 203.83.114.122 by pyxis (envelope-from <robert.zhangle@gmail.com>, uid 101) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7733.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.213007 secs); 31 Mar 2009 18:09:55 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 31 Mar 2009 18:09:54 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n2VI9n2P028801;
	Wed, 1 Apr 2009 02:09:53 +0800 (CST)
Date:	Wed, 1 Apr 2009 02:09:37 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	=?utf-8?B?5p6X5bu65a6J?= <colin@realtek.com.tw>,
	linux-mips@linux-mips.org
Subject: Re: The impact to change page size to 16k for cache alias
Message-ID: <20090331180936.GC4918@adriano.hkcable.com.hk>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	=?utf-8?B?5p6X5bu65a6J?= <colin@realtek.com.tw>,
	linux-mips@linux-mips.org
References: <9BDA961341E843F29C1C1ECDB54FD0CF@realtek.com.tw> <20090330082414.GA4797@adriano.hkcable.com.hk> <20090331081113.GA17934@linux-mips.org> <20090331165412.GA4918@adriano.hkcable.com.hk> <20090331171225.GC24154@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090331171225.GC24154@linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 19:12 Tue 31 Mar     , Ralf Baechle wrote:
> On Wed, Apr 01, 2009 at 12:54:12AM +0800, Zhang Le wrote:
> 
> > > > Linux on Loongson 2E and 2F uses 16k page size to avoid cache alias problem, too.
> > > > However, I haven't encountered any problem on Linux kernel itself due to 16k page
> > > > size.
> > > > 
> > > > Anyway, I am not 100% familiar with Loongson patches, so I am not sure whether
> > > > the page size problem is already been taken care of in the patch. If you are
> > > > interested to find out yourself, you can get the whole source here:
> > > > http://repo.or.cz/w/linux-2.6/linux-loongson.git
> > > 
> > > I've got a report that Fulong is currently only working with 16k pages.  So
> > > 4k is no longer the bullet proof choice for all cases :)
> > 
> > Yes, at least from what I can tell.
> > I have tried 4k before, because I heard someone told me the aliasing problem
> > already can be taken care by software, namely Linux. But as it turned out, 16k
> > is still necessary for the Loongson boxes to function properly.
> 
> Linux knows how to handle aliasing caches - the vast majority of MIPS
> systems have aliasing caches and are running at 4k page size.  So the
> issue is Loongson-specific.  This might be due to processor detection
> not detecting the cache size, cache line size, number of ways correctly
> or because loongson's caches has some unusual cache properties which the
> Linux kernel is not designed to handle yet.
> 
> Btw, I just noticed that there is no
> arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h which is going
> to impact code size and performance.

Thanks for the reminder. I didn't know it before. I am gonna take a look.

Zhang, Le
http://zhangle.is-a-geek.org
