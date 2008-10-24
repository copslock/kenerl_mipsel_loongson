Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 08:28:06 +0100 (BST)
Received: from apollo.i-cable.com ([203.83.115.103]:6802 "HELO
	apollo.i-cable.com") by ftp.linux-mips.org with SMTP
	id S22267343AbYJXH2D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 08:28:03 +0100
Received: (qmail 6073 invoked by uid 508); 24 Oct 2008 07:27:55 -0000
Received: from 203.83.114.121 by apollo (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7730.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.160845 secs); 24 Oct 2008 07:27:55 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 24 Oct 2008 07:27:54 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id m9O7RqTU007607;
	Fri, 24 Oct 2008 15:27:54 +0800 (HKT)
Date:	Fri, 24 Oct 2008 15:27:46 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] defined a macro for lemote 2e box IO base
Message-ID: <20081024072745.GA14652@adriano.hkcable.com.hk>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <1224722939-18557-1-git-send-email-r0bertz@gentoo.org> <20081022202812.GB10625@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081022202812.GB10625@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 21:28 Wed 22 Oct     , Ralf Baechle wrote:
> On Thu, Oct 23, 2008 at 12:48:58AM +0000, Zhang Le wrote:
> 
> > +#ifdef CONFIG_64BIT
> > +#define LEMOTE_IO_PORT_BASE 0xffffffffbfd00000
> > +#else
> > +#define LEMOTE_IO_PORT_BASE 0xbfd00000
> > +#endif
> 
> This sort of #ifdefery is one of the reasons why it's better to define
> physical addresses of devices, not virtual addresses in header files.

Thanks for the comment.
I have checked how other platforms handle this problem.
Many have used CKSEG1ADDR.
So I have posted another set of patches here:
http://www.linux-mips.org/archives/linux-mips/2008-10/msg00189.html
http://www.linux-mips.org/archives/linux-mips/2008-10/msg00190.html

Is it OK?

Zhang, Le
