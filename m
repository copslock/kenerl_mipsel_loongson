Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2009 16:57:42 +0200 (CEST)
Received: from cantor.suse.de ([195.135.220.2]:58985 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493166AbZIRO5g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Sep 2009 16:57:36 +0200
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id F1CB48E8CC;
	Fri, 18 Sep 2009 16:57:35 +0200 (CEST)
Date:	Fri, 18 Sep 2009 07:57:15 -0700
From:	Greg KH <gregkh@suse.de>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM63xx: Add serial driver for bcm63xx
	integrated UART.
Message-ID: <20090918145715.GB8884@suse.de>
References: <1253271898.1627.272.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1253271898.1627.272.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Fri, Sep 18, 2009 at 01:04:58PM +0200, Maxime Bizon wrote:
> 
> Hi Greg,
> 
> This is a serial driver for the bcm63xx mips SOCs, it was already posted
> twice:
> 
> one year ago: http://marc.info/?l=linux-serial&m=122438266322439&w=2
> three months ago: http://lkml.org/lkml/2009/7/1/370
> 
> but got no review or ack.
> 
> 
> Linus merged the SOC support patch from Ralf tree yesterday, but without
> serial support.
> 
> Could you please have a look at it ? Is it ok if it goes upstream
> through Ralf tree ?

I have no objection for this to go through Ralf's tree.  Or if he needs
it to go through mine, just let me know.

> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>


thanks,

greg k-h
