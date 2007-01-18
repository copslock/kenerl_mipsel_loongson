Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 21:53:42 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.24]:60344 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S28574937AbXARVxg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2007 21:53:36 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0ILrRFf012409
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 Jan 2007 13:53:28 -0800
Received: from sony (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l0ILrPsv008879;
	Thu, 18 Jan 2007 13:53:26 -0800
Date:	Thu, 18 Jan 2007 13:53:26 -0800
From:	Andrew Morton <akpm@osdl.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	anemo@mba.ocn.ne.jp, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
Message-Id: <20070118135326.c0238873.akpm@osdl.org>
In-Reply-To: <20070118160338.GA6343@linux-mips.org>
References: <20070119.002346.74752797.anemo@mba.ocn.ne.jp>
	<20070118160338.GA6343@linux-mips.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

> On Thu, 18 Jan 2007 16:03:38 +0000 Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Jan 19, 2007 at 12:23:46AM +0900, Atsushi Nemoto wrote:
> 
> > CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
> > might result in allocation failure for the reserving itself on some
> > platforms (for example typical 32bit MIPS).  Make it (and
> > CARDBUS_IO_SIZE too) customizable for such platforms.
> 
> Patch looks technically ok to me, so feel free to add my Acked-by: line.
> 
> The grief I have with this sort of patch is that this kind of detailed
> technical knowledge should not be required by a mortal configuring the
> Linux kernel.
> 

Yes, it does rater suck.  A boot option/module parameter would be better.
