Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2010 18:08:12 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54109 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492991Ab0ASRII (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jan 2010 18:08:08 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0JFhKRa025412;
        Tue, 19 Jan 2010 16:43:21 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0JFhJKQ025411;
        Tue, 19 Jan 2010 16:43:19 +0100
Date:   Tue, 19 Jan 2010 16:43:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Help in enabling HIGHMEM support  / 64 bit support
Message-ID: <20100119154319.GB23161@linux-mips.org>
References: <Pine.LNX.4.64.0912131240100.24267@ask.diku.dk>
 <A7DEA48C84FD0B48AAAE33F328C020140457EE41@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
 <20091214173509.GB15067@linux-mips.org>
 <A7DEA48C84FD0B48AAAE33F328C020140474ADC8@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C020140474ADC8@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12621

On Mon, Jan 18, 2010 at 07:57:06AM -0800, Anoop P.A. wrote:

> I am working on enabling Highmem support and 64 Bit support
> 
> 1. 64 Bit support
> 
> As Ralf suggested I have tried enabling 64 bit support. I have reached
> up to a point where I can boot the kernel with 512MB memory (logs
> attached). How ever if I increase mem above > 512 I am not even getting
> single print from kernel. 

You told the kernel mem=1024M.  That's memory at physical address zero
so overlaps with I/O address ranges.  Boom.  The reason that you for
further with highmem is the same except except that probably by pure luck
the allocation order got things to fail a little later.

To debug this sort of case I suggest you get early printk to work for your
board or maybe you have a working EJTAG probe and debugger.

Btw, what is the point of putting ASCII boot logs into word files inflating
them 10x and getting half the mail filters of this world to throw the
attachments or entire email away?

  Ralf
