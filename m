Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 11:14:59 +0100 (CET)
Received: from mail-ew0-f212.google.com ([209.85.219.212]:43417 "EHLO
        mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492414AbZLBKOz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2009 11:14:55 +0100
Received: by ewy4 with SMTP id 4so39385ewy.27
        for <multiple recipients>; Wed, 02 Dec 2009 02:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=gKG1ke0R22escYcGihul1c51Gg5SMIDL/g7XLYErLuk=;
        b=ApkLef2XNL6zM5PvF4kezq/b/vOSiQ1BZ3vxYu6BUEMz5u9KsJzQbAoLRYMpxG5C12
         vz6oluJxNMeBhpqvjktTpFUwefg0701QxiwSrZQuMrYD1a93Auv5OlpLhLdvVtAwsHWf
         Mqcge7NxYy0I24j89cVKdEXUfW6EgDuFKR3EM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=TCTs+bKvmZGLtnBvJZF5yW2r3XdNjhNpawpJp4PWX77jFHsIYE+YLh1pCrUvc/Vvz/
         LrflDCZH4Ho3tRoOL3/om+rRx6GlBOSU+x6qnvgf/y7n+ZJjHpWd3Iddfhe9lR/s4HfV
         Gso7A6kUpi2e5eVtOIzorgL7BPjZLn05JrZuY=
Received: by 10.213.102.138 with SMTP id g10mr4287683ebo.19.1259748887726;
        Wed, 02 Dec 2009 02:14:47 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 13sm639809ewy.5.2009.12.02.02.14.46
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 02:14:46 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Hector Martin <hector@marcansoft.com>
Subject: Re: BCM63xx merge progress
Date:   Wed, 2 Dec 2009 11:14:21 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-15-server; KDE/4.3.2; x86_64; ; )
Cc:     mbizon@freebox.fr, linux-mips@linux-mips.org, ralf@linux-mips.org
References: <4B15974E.1060505@marcansoft.com> <1259709927.2926.608.camel@sakura.staff.proxad.net> <4B15B40D.70006@marcansoft.com>
In-Reply-To: <4B15B40D.70006@marcansoft.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200912021114.22028.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

On Wednesday 02 December 2009 01:25:49 Hector Martin wrote:
> Maxime Bizon wrote:
> > Which part is broken/missing on your side ?
> 
> Well, there's a commit (4059ddb4) that claims to "Add USB OHCI support",
> yet it only adds a #include to ohci-hcd.c and a few .h bits. The actual
> ohci-bcm63xx.c is missing, which means the OHCI driver probably won't
> even compile. It's also missing the relevant platform device stuff in
> arch/. This concerned me somewhat, it looked like something weird had
> happened and the merge was incomplete.
> 
> Florian Fainelli wrote:
> > Everything that Maxime sent is, or will be merged either in 2.6.32 or
> > in 2.6.33, that includes:
> > - arch/mips/bcm63xx (will be in 2.6.32)
> > - USB driver bits (2.6.33)
> > - Ethernet MAC driver bits (2.6.32)
> > - Ethernet PHY driver bits (2.6.32)
> > - UART driver (2.6.32)
> > - PCMCIA support (2.6.32)
> 
> I can see the 2.6.32 stuff already. Regarding USB, is there a repo with
> the commit that will be in .33? Otherwise I'll just have to merge it
> locally and work from there for the moment. What's up with the weirdo
> commit mentioned above?
> 
> > We maintain a couple of different patches for OpenWrt, specifically
> > the mtd partition parser since we provide images, so the box should
> > boot from Flash. That driver is not in a mergable state at the moment.
> > There is also a embryon of a SPI driver and a watchdog driver, which I
> > will probably submit once cleaned up.
> 
> Another tidbit I saw in the OpenWRT set is the reset button GPIO
> support. I want to have that (eventually) too.

The gpio-buttons driver that we use in OpenWrt to do that is not that perfect 
and handling reset and other buttons is a distribution side problem since not 
evryone wants to map a button to a functionnality.

> 
> Basically, my dilemma is simply that I want to work off of mainline
> (especially since stuff has been partially merged already and changes
> have been made), yet I need the missing patches in order to make this
> work completely. So eventually I need a tree that contains everything I
> need, whether a few individual commits are not really ready for mainline
> or not. In doing this, I obviously want to keep in sync with any work
> that has been done already as much as possible. So please do tell if
> there's a specific place I should be looking at for mainline-compatible
> versions of these patches, or anything closer to what will eventually be
> merged. As I said, I don't mind doing the merges myself, but then it
> might make rebasing onto mainline harder if your official patches are
> merged in a substantially different way once they do make it to
> mainline. And if I do end up merging stuff, I might as well send it to
> you to save you some time.

2.6.33-rc will have the remaining bits, so if you should start working with 
something, better wait a for couple of days. Depending on what you are 
planning to work on, you really do not need to have everything merged.
-- 
WBR, Florian
