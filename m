Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 14:37:27 +0100 (BST)
Received: from pD9562698.dip.t-dialin.net ([IPv6:::ffff:217.86.38.152]:48728
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225005AbUJENhW>; Tue, 5 Oct 2004 14:37:22 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i95Datpl018160;
	Tue, 5 Oct 2004 15:36:55 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i95Daq9Y018159;
	Tue, 5 Oct 2004 15:36:52 +0200
Date: Tue, 5 Oct 2004 15:36:52 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@lists.osdl.org, greg@kroah.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] pci-hplj.c: replace pci_find_device with pci_get_device
Message-ID: <20041005133652.GA17520@linux-mips.org>
References: <281940000.1096925207@w-hlinder.beaverton.ibm.com> <20041004214107.GA2160@linux-mips.org> <1096981395.30942.859.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096981395.30942.859.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 05, 2004 at 02:03:16PM +0100, David Woodhouse wrote:

> On Mon, 2004-10-04 at 23:41 +0200, Ralf Baechle wrote:
> > Except that piece of code isn't for an RM[23]00 but a HP Laserjet (yes,
> > that paper eating thing ;-) and hasn't seen any update or feedback from
> > the original submitters since the original submission, so the entire HPLJ
> > code is a candidate for removal ...
> 
> Any idea precisely what model, and how to get it installed? 
> eBay calls... :)

They only ever published the initial code drop.  No code maintenance since
or any kind of documentation ...  However one of the group of code submitters
back then was claiming to run Gnome with remote X display - probably because
at least back then there was no support for the printing hw and anyway,
the refresh rate of a printer is somewhat limited ;-)

As I recall the code was originally submitted by roger_twede@hp.com.

  Ralf
