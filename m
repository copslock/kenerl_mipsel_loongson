Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2009 18:35:14 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56267 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1494332AbZLNRfL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Dec 2009 18:35:11 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBEHZAcb019542;
        Mon, 14 Dec 2009 17:35:10 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBEHZ9Pj019540;
        Mon, 14 Dec 2009 17:35:09 GMT
Date:   Mon, 14 Dec 2009 17:35:09 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Help in enabling HIGHMEM support
Message-ID: <20091214173509.GB15067@linux-mips.org>
References: <Pine.LNX.4.64.0912131240100.24267@ask.diku.dk>
 <A7DEA48C84FD0B48AAAE33F328C020140457EE41@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C020140457EE41@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 14, 2009 at 05:34:13AM -0800, Anoop P.A. wrote:

> We have a requirement to use a bigger RAM (1 GB / 2GB) with a RM9000
> based SOC. I thought of going with HIGHMEM path rather than enabling
> 64bit support thinking it will be easier.

This sounds like sawing off 32 legs just to be able to make use of a
free [1] wheelchair.

> I have tried enabling HIGMEM in kernel. Board boots fine with a 512 MB
> RAM plugged in. But if I connect a 1 GB RAM kernel will not boot. I am
> not even getting single print from kernel. I am using linux-2.6.18
> kernel.
> 
> It will be great if get any pointers suggestions in debugging this?

With this amount of RAM, use a 64-bit kernel if you can.  You'll be
happy not to know about all the headaches you will never encounter.

  Ralf

[1] Conditions apply.
