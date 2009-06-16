Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jun 2009 18:32:03 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:56761 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492158AbZFPQb4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jun 2009 18:31:56 +0200
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 88235890B6;
	Tue, 16 Jun 2009 18:30:48 +0200 (CEST)
Date:	Tue, 16 Jun 2009 09:25:50 -0700
From:	Greg KH <gregkh@suse.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 54/64] mips: remove driver_data direct access of struct
	device
Message-ID: <20090616162550.GG26879@suse.de>
References: <20090616051351.GA23627@kroah.com> <1245131213-24168-54-git-send-email-gregkh@suse.de> <20090616093134.GA28585@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090616093134.GA28585@linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Tue, Jun 16, 2009 at 10:31:34AM +0100, Ralf Baechle wrote:
> On Mon, Jun 15, 2009 at 10:46:43PM -0700, Greg Kroah-Hartman wrote:
> 
> > In the near future, the driver core is going to not allow direct access
> > to the driver_data pointer in struct device.  Instead, the functions
> > dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
> > have been around since the beginning, so are backwards compatible with
> > all older kernel versions.
> > 
> > Cc: linux-mips@linux-mips.org
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Thanks, applied.

Heh, I sent this a while ago to you :)

This was the "here's what just got sent to Linus" series of patches.

thanks,

greg k-h
