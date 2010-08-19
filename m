Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Aug 2010 19:43:59 +0200 (CEST)
Received: from kroah.org ([198.145.64.141]:54713 "EHLO coco.kroah.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491070Ab0HSRny (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Aug 2010 19:43:54 +0200
Received: from localhost (c-24-16-163-131.hsd1.wa.comcast.net [24.16.163.131])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by coco.kroah.org (Postfix) with ESMTPSA id BF916489B2;
        Thu, 19 Aug 2010 10:43:45 -0700 (PDT)
Date:   Thu, 19 Aug 2010 10:43:41 -0700
From:   Greg KH <greg@kroah.com>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 1/2][USB] USB/PowerTV: Add support for PowerTV USB
 interface
Message-ID: <20100819174341.GA13561@kroah.com>
References: <20100803014054.GA31524@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100803014054.GA31524@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips

On Mon, Aug 02, 2010 at 06:40:54PM -0700, David VomLehn wrote:
> Add support for the Cisco PowerTV USB interface.
> 
> This is a very simple set of glue functions, apparently derived some time
> ago from the au1xxx driver by Matt Porter.
> 
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>

Do you want me to take this through the USB tree?  It's that useful
without the 2/2 patch, right?

If so, Ralf, feel free to add this to your tree with an:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to the patch.

If not, I'll be glad to take it in mine, just let me know.

thanks,

greg k-h
