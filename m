Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 19:18:11 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:40448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491882Ab1HLRSH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Aug 2011 19:18:07 +0200
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id 410AE8C061;
        Fri, 12 Aug 2011 19:18:07 +0200 (CEST)
Date:   Fri, 12 Aug 2011 09:33:25 -0700
From:   Greg KH <gregkh@suse.de>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/8] MIPS: Alchemy: abstract USB block control register
 access
Message-ID: <20110812163325.GA13018@suse.de>
References: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
 <1313141985-5830-2-git-send-email-manuel.lauss@googlemail.com>
 <20110812160454.GA11898@suse.de>
 <CAOLZvyFNoxjkU9bcdRtQA9Ey2wnsEN0MbRL3vmNeYhJZHMWoVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLZvyFNoxjkU9bcdRtQA9Ey2wnsEN0MbRL3vmNeYhJZHMWoVQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9571

On Fri, Aug 12, 2011 at 06:20:48PM +0200, Manuel Lauss wrote:
> On Fri, Aug 12, 2011 at 6:04 PM, Greg KH <gregkh@suse.de> wrote:
> > On Fri, Aug 12, 2011 at 11:39:38AM +0200, Manuel Lauss wrote:
> >> Alchemy chips have one or more registers which control access
> >> to the usb blocks as well as PHY configuration.  I don't want
> >> the OHCI/EHCI glues to know about the different registers and bits;
> >> new arch code hides the gory details of USB configuration from them.
> >>
> >> Cc: linux-usb@vger.kernel.org
> >> Cc: Greg Kroah-Hartman <gregkh@suse.de>  (USB glue parts)
> >> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> >> ---
> >> CC'ed Greg for an Ack on the USB glue parts.  I'd like this to go through the
> >>  MIPS tree since other changes in it depend on it.
> >
> > Fine with me on the USB portions, you are just deleting code, which I
> > like :)
> 
> Thanks!
> 
> 
> > But should the "common" USB code really live under arch/mips/alchemy/ ?
> > The goal is to move driver code out of arch/ and into drivers/.  Why are
> > you moving stuff backwards here?
> 
> This is just chip-dependent code for usb block and phy management, which
> varies wich chip subtype, the OHCI and EHCI controllers are identical on all
> of them.  At the time moving the chip-depedent code to the other chip-dependent
> code seemed like a good idea...

But that's what drivers/* is, chip-dependent code.  Please move it there
instead.

Has the MIPS developers learned nothing from the recent ARM mess? :)

greg k-h
