Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2012 07:30:52 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34494 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902233Ab2HTFar (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2012 07:30:47 +0200
Received: by pbbrq8 with SMTP id rq8so6897320pbb.36
        for <linux-mips@linux-mips.org>; Sun, 19 Aug 2012 22:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=Ha92kSvHEexEPbmX93eTS7pBmGFNoxE+nbCLuj0TUjc=;
        b=MhLKfAmu6GXHRxe7zOMhN9D15Mmbx8aCOcZuRtFWcBYvQzQNM9w0t0hPgLZm+DwJUn
         eoKH7REHoQF3ltLn0yGgNhlXSEjtttuQIQIwWPlKCTK/nvYzi7/AHKY7LixtsOXrTDU5
         Q4thAEXohXxN68+iIT3rrxWIF1vXE/RmYVxAe1myeZrke6nZA+AMcwUYh2fx6NtvK1Pv
         CINMpK94Z0luzVHeVG2A2mnfLqScipsynAhOjWdh7XOa6mTalInZhN133WuComv8gkMp
         CGRozDdTvAcdZZuC0ln71X1kyOy5FQNH0KBxSwbgaFxk3j+A8F3R8to8XsBDtxwNa22B
         +zpw==
Received: by 10.68.130.67 with SMTP id oc3mr31379180pbb.18.1345440640673;
        Sun, 19 Aug 2012 22:30:40 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id ns9sm3961751pbb.13.2012.08.19.22.30.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Aug 2012 22:30:39 -0700 (PDT)
Date:   Sun, 19 Aug 2012 22:30:36 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120820053036.GA23166@kroah.com>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
 <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
 <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
 <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQm3i6m4X8E3Ia0avUYYoIoNxJ2hjfSkbET3inrwqgK36gyeRHkS7c0JTPPYtmgGSGLDzrxe
X-archive-position: 34283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Aug 17, 2012 at 11:32:47PM +0200, Thierry Reding wrote:
> On Fri, Aug 17, 2012 at 03:25:22PM -0600, Bjorn Helgaas wrote:
> > On Fri, Aug 17, 2012 at 3:07 PM, Thierry Reding
> > <thierry.reding@avionic-design.de> wrote:
> > > On Fri, Aug 17, 2012 at 10:48:39PM +0200, Thierry Reding wrote:
> > >> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
> > > [...]
> > >> > Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
> > >> > affect you?  I think we would still have to change some __inits to
> > >> > __devinit, including pcibios_update_irq(), but it might be more
> > >> > manageable.
> > >>
> > >> You said that depending on HOTPLUG wouldn't be enough because it would
> > >> exclude reenumeration at runtime if HOTPLUG wasn't defined. Also it is
> > >> theoretically possible to build a kernel without HOTPLUG but have the
> > >> enumeration start after init because of deferred probing. Those cases
> > >> won't work if we keep __init or __devinit respectively, right?
> > >
> > > Another possibility would be to make PCI select HOTPLUG or depend on it.
> > > That way it would be made sure that __devinit wouldn't cause all the
> > > functions to be discarded after init.
> > 
> > There's been some discussion recently about whether CONFIG_HOTPLUG is
> > worth keeping any more, but nothing's been resolved yet.  If we did
> > decide to remove CONFIG_HOTPLUG, or require it for PCI, I would rather
> > just remove all the __devinit annotations because they'd be
> > superfluous.
> 
> I've missed that discussion. Can you point me to it?

It's pretty much just me saying the whole thing is a mess, causes
problems, and really doesn't solve any memory usage issues.  Ideally we
should just:
	- remove CONFIG_HOTPLUG and assume it is enabled
	- because of that, we can delete the large majority of the
	  __dev* markings

The memory savings these days are so tiny, if at all, and everyone,
including me, gets it wrong all the time.

As we pretty much allow anything to be disabled/enabled at any point in
time after boot, we are all running systems that rely on CONFIG_HOTPLUG
anyway.  To find a static system that doesn't need it is quite rare from
what I have found.

greg k-h
