Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2012 09:20:51 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:39656 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903554Ab2E3HUm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 May 2012 09:20:42 +0200
Received: by dadm1 with SMTP id m1so6997159dad.36
        for <linux-mips@linux-mips.org>; Wed, 30 May 2012 00:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=L4bUx4b9gQzlmCTOoq5Ipxbm9Jma7DIPr53VetemN5Q=;
        b=I/28iX/vS07YIs9sMOVyrk+GVq86k0gv74AdVkI8hMXOtpkPaidhufgXYfTJ8iqQG4
         9sxu+p+QIo8lvt1nRWcQKQvqO+XcO1fDGIbacMTHbNcu5GhV5XFR/L65Ckb1itH3y7zR
         5VPaRsGUM0VWr4jmZ/5F44dTB3BJiT2qulGfOmkO67NBMiKQqQ4Qdb4USqud7QC6/NPK
         +zu5AlID6M5pjwbV7s09grWBMVeU41AAmoR9JfFOT9V+dRv9HGdHlihmvq9+s0IvqYKK
         3rhv6LquoULvO19uJCG8DNDVq62KJHVcg8s0MfHu+Jcv/uWaibHnFmKLPGK5WN90GNh3
         ijLw==
Received: by 10.68.132.34 with SMTP id or2mr47368912pbb.118.1338362435544;
        Wed, 30 May 2012 00:20:35 -0700 (PDT)
Received: from localhost ([118.143.64.134])
        by mx.google.com with ESMTPS id ua6sm22279326pbc.20.2012.05.30.00.20.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 May 2012 00:20:35 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 247CF3E065C; Wed, 30 May 2012 15:20:32 +0800 (HKT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V5 16/17] SPI: MIPS: lantiq: add FALCON spi driver
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        spi-devel-general@lists.sourceforge.net,
        Thomas Langer <thomas.langer@lantiq.com>
In-Reply-To: <4FC0DEEC.8050204@openwrt.org>
References: <1337521579-1597-1-git-send-email-blogic@openwrt.org> <20120525233845.BD93C3E0BD2@localhost> <4FC0DEEC.8050204@openwrt.org>
Date:   Wed, 30 May 2012 15:20:32 +0800
Message-Id: <20120530072032.247CF3E065C@localhost>
X-Gm-Message-State: ALoCoQmx3FhN3Kfnzkwz/Tm1XmNWcIg8OWbANOTazKrqFHXfTU/CiLZC5TEuLx9GmuZLtTA4lNVF
X-archive-position: 33477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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

On Sat, 26 May 2012 15:47:24 +0200, John Crispin <blogic@openwrt.org> wrote:
> 
> > What exactly does this mean?  How does it not support any other type
> > of SPI peripheral?  SPI is a really simple protocol, so what is it
> > about this hardware that prevents it being used with other SPI
> > hardware?
> >
> > I see a big state machine that appears to interpret the messages and
> > pretend to be an SPI slave instead of telling linux about the real
> > device.  /me wonders if it should this instead be a block device
> > driver?
> >
> 
> Thomas will need to comment on this part
> 
> >> +static int falcon_sflash_prepare_xfer(struct spi_master *master)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +static int falcon_sflash_unprepare_xfer(struct spi_master *master)
> >> +{
> >> +	return 0;
> >> +}
> > Don't use empty hooks.  Just leave them uninitialized.  The core will
> > do the right thing.
> >
> 
> I was under the impression that the need for these 2 callbacks was
> removed in 3.5. As this patch flows via MIPS there would be a merge
> order problem making the kernel non bisectable
> 
> I am a bit confused. You keep ack'ing this driver and then commenting on
> it a few weeks later.... obsoleting the ACK ...

Hahah.  I receive a *lot* of email.  I can't remember what I reviewed
yesterday, let alone last week.  If I ack something, then add my ack
when you repost.  Otherwise I don't have any clues as to what I've
said in the past.

Also, I reserve the right to review all new versions of patches; that
doesn't invalidate the ack, but Ralf can decide whether to pick it up
and ask for follow-up changes, or to ask for another respin.

g.
