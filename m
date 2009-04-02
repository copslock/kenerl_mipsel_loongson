Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 13:16:24 +0100 (BST)
Received: from pyxis.i-cable.com ([203.83.115.105]:16256 "HELO
	pyxis.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20031367AbZDBMQS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Apr 2009 13:16:18 +0100
Received: (qmail 8582 invoked by uid 104); 2 Apr 2009 12:16:10 -0000
Received: from 203.83.114.122 by pyxis (envelope-from <robert.zhangle@gmail.com>, uid 101) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7733.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.176931 secs); 02 Apr 2009 12:16:10 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 2 Apr 2009 12:16:09 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n32CG8nl002973;
	Thu, 2 Apr 2009 20:16:09 +0800 (CST)
Date:	Thu, 2 Apr 2009 20:15:56 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] added Loongson cpu-feature-overrides.h
Message-ID: <20090402121556.GA6629@adriano.hkcable.com.hk>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <1238658105-23260-1-git-send-email-r0bertz@gentoo.org> <20090402111607.GB1678@linux-mips.org> <20090402112739.GD28319@adriano.hkcable.com.hk> <20090402114746.GC1678@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090402114746.GC1678@linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 13:47 Thu 02 Apr     , Ralf Baechle wrote:
> On Thu, Apr 02, 2009 at 07:27:39PM +0800, Zhang Le wrote:
> 
> > > > I have taken Wu Zhangjin's and Philippe Vachon's version as references, did a
> > > > little modification and tested on 16K page size kernel. It works well.
> > > > 
> > > > Unfornately although it already has defined cpu_has_dc_aliases as 1, 4k page
> > > > size still not working. More work needed here.
> > > 
> > > Adding this file is only a matter of kernel optimization.  You may have
> > > saved as much as several hundred kb!  But it won't get a kernel
> > > that wasn't working before to work.  If anything the opposite ...
> > 
> > I see. Thanks.
> > BTW, I have just made another little change:
> > 
> > #define cpu_has_dc_aliases      (PAGE_SIZE < 0x4000)
> > 
> > Since waysize is 16k.
> > 
> > Anyway, it is good to include this file now, or postpone it a little later?
> > If yes, then I will send a new version soon.
> 
> Correct - but this alone doesn't get all 4k or 64k pages to work so how
> about we deal with this one later?

OK, then, ;)

Zhang, Le
