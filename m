Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 14:46:27 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36349 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493190AbZKWNqU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 14:46:20 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nANDkZOW031114;
	Mon, 23 Nov 2009 13:46:35 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nANDkYof031112;
	Mon, 23 Nov 2009 13:46:34 GMT
Date:	Mon, 23 Nov 2009 13:46:33 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	dmitri.vorobiev@movial.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Move several variables from .bss to .init.data
Message-ID: <20091123134633.GB28687@linux-mips.org>
References: <1258977217-25461-1-git-send-email-dmitri.vorobiev@movial.com> <20091123.222609.74748367.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091123.222609.74748367.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 23, 2009 at 10:26:09PM +0900, Atsushi Nemoto wrote:

> On Mon, 23 Nov 2009 13:53:37 +0200, Dmitri Vorobiev <dmitri.vorobiev@movial.com> wrote:
> > Several static uninitialized variables are used in the scope of
> > __init functions but are themselves not marked as __initdata.
> > This patch is to put those variables to where they belong and
> > to reduce the memory footprint a little bit.
> > 
> > Also, a couple of lines with spaces instead of tabs were fixed.
> > 
> > Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
> > ---
> >  arch/mips/ar7/platform.c        |    2 +-
> >  arch/mips/sgi-ip22/ip22-eisa.c  |    4 ++--
> >  arch/mips/sgi-ip22/ip22-setup.c |    2 +-
> >  arch/mips/sgi-ip32/ip32-setup.c |    2 +-
> >  arch/mips/sni/setup.c           |    2 +-
> >  arch/mips/txx9/generic/setup.c  |    2 +-
> >  arch/mips/txx9/rbtx4939/setup.c |    4 ++--
> >  7 files changed, 9 insertions(+), 9 deletions(-)
> 
> NAK, at least for txx9 parts.  The struct mtd_partition arrays will be
> referenced by mtd map drivers via platform_data.

I'll drop the txx9 parts then.

> And for console option strings parts, I doubt these can be marked as
> __initdata.  Theoretically, the console driver might be a module,

No; if the driver is a module we don't offer console functionality.  Typical
example:

config SERIAL_8250
        tristate "8250/16550 and compatible serial support"
        select SERIAL_CORE
[...]
config SERIAL_8250_CONSOLE
        bool "Console on 8250/16550 and compatible serial port"
        depends on SERIAL_8250=y
        select SERIAL_CORE_CONSOLE

I think we consistently do this for all console drivers.

  Ralf
