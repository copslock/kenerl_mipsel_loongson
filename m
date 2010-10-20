Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2010 21:05:47 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49525 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491139Ab0JTTFo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Oct 2010 21:05:44 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9KJ5avt002557;
        Wed, 20 Oct 2010 20:05:36 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9KJ5ZMg002555;
        Wed, 20 Oct 2010 20:05:35 +0100
Date:   Wed, 20 Oct 2010 20:05:34 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Implement __read_mostly
Message-ID: <20101020190534.GB32087@linux-mips.org>
References: <1287085009-16445-1-git-send-email-ddaney@caviumnetworks.com>
 <AANLkTikdRQSsLxPFtY+cav24wEkSVEQ9vCtrMEvvM3CV@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTikdRQSsLxPFtY+cav24wEkSVEQ9vCtrMEvvM3CV@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 16, 2010 at 10:04:59AM +0200, Geert Uytterhoeven wrote:

> > -const unsigned long mips_io_port_base __read_mostly = -1;
> > +const unsigned long mips_io_port_base = -1;
> >  EXPORT_SYMBOL(mips_io_port_base);
> 
> Ugh. So as soon as someone implements MMU protection for the read-only data
> section, it'll break silently?

That's not the only failure mode.  A const might be replicated by a compiler
for example into multiple small data sections or by loading the rodata
into multiple NUMA nodes.  The later hits IP27 but that one got potencially
many PCI busses anyway, so mips_io_port_base was always problematic.  From
the time I put this optimization hack in it was clear that I was gaming
GCC and sooner or later it was going to blow up.  It's held for like a
decade so I got my money's worth :)

  Ralf
