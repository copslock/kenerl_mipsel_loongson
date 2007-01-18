Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 16:20:16 +0000 (GMT)
Received: from nic.NetDirect.CA ([216.16.235.2]:37610 "EHLO
	rubicon.netdirect.ca") by ftp.linux-mips.org with ESMTP
	id S28573851AbXARQUL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Jan 2007 16:20:11 +0000
X-Originating-Ip: 74.109.98.130
Received: from CPE00045a9c397f-CM001225dbafb6.cpe.net.cable.rogers.com (CPE00045a9c397f-CM001225dbafb6.cpe.net.cable.rogers.com [74.109.98.130])
	(authenticated bits=0)
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id l0IGJU91021620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Jan 2007 11:19:38 -0500
Date:	Thu, 18 Jan 2007 11:14:12 -0500 (EST)
From:	"Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, akpm@osdl.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
In-Reply-To: <20070118160338.GA6343@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0701181112410.21156@CPE00045a9c397f-CM001225dbafb6>
References: <20070119.002346.74752797.anemo@mba.ocn.ne.jp>
 <20070118160338.GA6343@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck:	not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Return-Path: <rpjday@mindspring.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@mindspring.com
Precedence: bulk
X-list: linux-mips

On Thu, 18 Jan 2007, Ralf Baechle wrote:

> On Fri, Jan 19, 2007 at 12:23:46AM +0900, Atsushi Nemoto wrote:
>
> > CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
> > might result in allocation failure for the reserving itself on some
> > platforms (for example typical 32bit MIPS).  Make it (and
> > CARDBUS_IO_SIZE too) customizable for such platforms.
>
> Patch looks technically ok to me, so feel free to add my Acked-by:
> line.
>
> The grief I have with this sort of patch is that this kind of
> detailed technical knowledge should not be required by a mortal
> configuring the Linux kernel.

that's why help info for options like that should always have a "If
you're unsure about what to say here ..." paragraph.

i'm big on stuff like that.  :-)

rday
