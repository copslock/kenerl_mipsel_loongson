Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 17:33:16 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63727 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224939AbTBYRdP>;
	Tue, 25 Feb 2003 17:33:15 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA17753;
	Tue, 25 Feb 2003 09:33:12 -0800
Subject: Re: Kernel Source Tree & Rebuild for Mips
From: Pete Popov <ppopov@mvista.com>
To: Jiahan Chen <jiahanchen@yahoo.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20030225164945.62043.qmail@web40803.mail.yahoo.com>
References: <20030225164945.62043.qmail@web40803.mail.yahoo.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1046194645.2942.2.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Feb 2003 09:37:25 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-02-25 at 08:49, Jiahan Chen wrote:
> --- Pete Popov <ppopov@mvista.com> wrote:
> > On Tue, 2003-02-25 at 00:01, Chris Zimman wrote:
> > > I've seen some strange stuff in the PCI code in 2.4.19-rc1 and 2.4.20
> > > from the CVS tree.
> > > 
> 
> Where and how can I get CVS source tree to build customized 
> Linux kernel for Mips?
> 
> Recently, I downloaded linux-2.4.18.tar.gz, patch-2.4.19.bz2,
> patch-2.4.20.bz2 from www.kernel.org, used cross-compiler 
> mipsel-linux-gcc, mips-linux-ld
> on Redhat 7.3 PC envoronment, and got quite a few errors from 
> compiling and ld. Can you or someone give me help?

The mips linux port is hosted on linux-mips.org. Take a look at the
documentation on www.linux-mips.org and go from there.

Pete
