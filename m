Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 07:54:33 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:40462 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20039080AbXBBHy3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 07:54:29 +0000
Received: (qmail 23852 invoked by uid 1000); 2 Feb 2007 08:53:28 +0100
Date:	Fri, 2 Feb 2007 08:53:28 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.20-rc: au1x irqs broken
Message-ID: <20070202075328.GB23737@roarinelk.homelinux.net>
References: <20070202061356.GA23661@roarinelk.homelinux.net> <20070202.161857.55145886.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070202.161857.55145886.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Fri, Feb 02, 2007 at 04:18:57PM +0900, Atsushi Nemoto wrote:
> On Fri, 2 Feb 2007 07:13:56 +0100, Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> > mips-git commit 1603b5aca14f15b34848fb5594d0c7b6333b99144 broke
> > au1x irqs. The kernel boots; however it is not able to
> > mount nfsroot. Reverting the arch/mips/au1000/common/irq.c
> > bits of the above commit fixes it.
> 
> Thank you for report.  But I can not see how that change break au1x.

I'm sorry, it was my fault. For some reason I commented out all the
.ack/.end fields in the irq_chip descriptions to make an earlier
-rc boot. With these fields integrated again it works as
expected (although I'm still unsure why the .ack/.end are required
at all. Shouldn't mask/unmask/mask_ack be enough? [for non-pb1000])

Sorry for the noise!

Thanks,

-- 
 ml.
