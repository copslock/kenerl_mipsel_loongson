Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 19:34:27 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42584 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816069AbaE2ReZf1YnV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 19:34:25 +0200
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DBAC020A77
        for <linux-mips@linux-mips.org>; Thu, 29 May 2014 13:34:23 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 29 May 2014 13:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=1lzYGPQKOM2A0aT9BdyUXgXj89Y=; b=nybTjT4CAZ+KiKoU6ONfMBPaY0r6
        K0tFPQE7SvNP2LdbAaux7zrk5YxvRGSzylKrwstP3lgKrlNpOj648DM3dg77RFcv
        7GZ544C+OCwuYllNfgeIghTgij0l0AJQJr1do8jE6yYG8bkjt/cZcmHbCArAWz0o
        MhD+d0yRw4oj+a0=
X-Sasl-enc: SnBhvfISFKHTFUGDmXLWuqihUWRO8ch1Svwlq/yu2r7h 1401384863
Received: from localhost (unknown [76.28.255.20])
        by mail.messagingengine.com (Postfix) with ESMTPA id 85BEEC00003;
        Thu, 29 May 2014 13:34:23 -0400 (EDT)
Date:   Thu, 29 May 2014 10:37:59 -0700
From:   Greg KH <greg@kroah.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb host/MIPS: Remove hard-coded OCTEON platform
 information.
Message-ID: <20140529173759.GA7889@kroah.com>
References: <1401358203-60225-4-git-send-email-alex.smith@imgtec.com>
 <Pine.LNX.4.44L0.1405291100320.1285-100000@iolanthe.rowland.org>
 <CAGVrzcZuo2MvMv20W4zJQxkK3JBxD8L_tfkZoP=s175__kDQ3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVrzcZuo2MvMv20W4zJQxkK3JBxD8L_tfkZoP=s175__kDQ3Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, May 29, 2014 at 09:55:08AM -0700, Florian Fainelli wrote:
> 2014-05-29 8:03 GMT-07:00 Alan Stern <stern@rowland.harvard.edu>:
> > On Thu, 29 May 2014, Alex Smith wrote:
> >
> >> From: David Daney <david.daney@cavium.com>
> >>
> >> The device tree will *always* have correct ehci/ohci clock
> >> configuration, so use it.  This allows us to remove a big chunk of
> >> platform configuration code from octeon-platform.c.
> >
> > Instead of doing this, how about moving the octeon2_usb_clocks_start()
> > and _stop() routines into octeon-platform.c, and then using the
> > ehci-platform and ohci-platform drivers instead of special-purpose
> > ehci-octeon and ohci-octeon drivers?
> 
> How about they get their changes in now, and eventually they cleanup
> the octeon driver in the future?

Nope, sorry, we don't do that for kernel development, you know that.

> My personal experience with that sort of request, is that I had to
> come up with 50+ patches to clean up the Kconfig mess that USB drivers
> had back then and I still have not re-submitted the bcm63xx USB
> patchset.

Well, that's not our fault you haven't resent them :)

> It is fair to pinpoint what *should* be improved and what the next
> steps could look like, it is not fair to ask people submitting changes
> to come up with a much bigger task before their patches can be merged.

Of course it is, that's how we do Linux development, again, you know
this.

greg k-h
