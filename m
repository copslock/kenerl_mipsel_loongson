Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 05:25:28 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45734 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492143Ab0KIEYP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Nov 2010 05:24:15 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oA8MwbfE007436;
        Mon, 8 Nov 2010 22:58:37 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oA8MwawG007434;
        Mon, 8 Nov 2010 22:58:36 GMT
Date:   Mon, 8 Nov 2010 22:58:35 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Robert Millan <rmh@gnu.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] removed ad-hoc cmdline default
Message-ID: <20101108225835.GA7167@linux-mips.org>
References: <1289133509.1547.1@thorin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1289133509.1547.1@thorin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 07, 2010 at 01:38:29PM +0100, Robert Millan wrote:

> Loongson builds have an ad-hoc cmdline default of "console=ttyS0,115200 
> root=/dev/hda1". These settings come from vendor (I remember builds 
> from Lemote branch requiring a "console=tty" override in order to get a 
> working console).
> 
> At least on my Yeeloong, they're particularly useless: there's no 
> (external) serial port, and the IDE drive is now recognised as /dev/
> sda.
> 
> I recommend removing them. They make sense from a distributor/vendor 
> POV but otherwise are just a nuissance.

Makes sense to me but I'm not an authoritative expert for all Loongson
platforms so I'm going to wait for comments for a few days before I'm
going to apply this.

Generally forcing options like this is just a bad idea.

  Ralf
