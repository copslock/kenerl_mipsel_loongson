Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2009 11:26:53 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59812 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493000AbZIWJ0r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Sep 2009 11:26:47 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8N9S2Px006518;
	Wed, 23 Sep 2009 10:28:02 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8N9S00X006517;
	Wed, 23 Sep 2009 10:28:00 +0100
Date:	Wed, 23 Sep 2009 10:28:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg KH <gregkh@suse.de>
Cc:	Maxime Bizon <mbizon@freebox.fr>, linux-serial@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: BCM63xx: Add serial driver for bcm63xx
	integrated UART.
Message-ID: <20090923092800.GE5457@linux-mips.org>
References: <1253271898.1627.272.camel@sakura.staff.proxad.net> <20090918145715.GB8884@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090918145715.GB8884@suse.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 18, 2009 at 07:57:15AM -0700, Greg KH wrote:

> > This is a serial driver for the bcm63xx mips SOCs, it was already posted
> > twice:
> > 
> > one year ago: http://marc.info/?l=linux-serial&m=122438266322439&w=2
> > three months ago: http://lkml.org/lkml/2009/7/1/370
> > 
> > but got no review or ack.
> > 
> > 
> > Linus merged the SOC support patch from Ralf tree yesterday, but without
> > serial support.
> > 
> > Could you please have a look at it ? Is it ok if it goes upstream
> > through Ralf tree ?
> 
> I have no objection for this to go through Ralf's tree.  Or if he needs
> it to go through mine, just let me know.
> 
> > Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Thanks, merged.  Will go to Linus asap.

  Ralf
