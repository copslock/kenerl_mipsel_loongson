Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 11:16:36 +0100 (CET)
Received: from mail-ew0-f212.google.com ([209.85.219.212]:60441 "EHLO
        mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492418AbZLBKQc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2009 11:16:32 +0100
Received: by ewy4 with SMTP id 4so40969ewy.27
        for <multiple recipients>; Wed, 02 Dec 2009 02:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=GDhhUFKbqkFHMdOOjUO9tS7mpIKErGDBxzCpKvRAKRQ=;
        b=noC7DjrnAD1A5byE7JmuM8RGzoGGSd6sqrBDivV4n0R1Zn4r9N/8rLWwR+5Q9akYT5
         vACnE0USrq6hEzVnMeTFaFMrHGkFErJmTjguczUQpmmKih1pBk+C4V0jFTrDpP+kcc1p
         PJcj/mMENh7Hlky0dBmaKiDby35wMWUziT7+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=JlMAJAxgeK4NZ5cC+kbaJsk+I5zSlcaB/q5Hnin8OHM529P2Ll1RHbqx2WblQIPi3i
         JWP3keSYc/1EHI19R4+N5+sKlix+7De7opMei6d0c3jyv32QPwjIBwRwlBBGBCnCJVMk
         C0BOPJE9ydfd6bthAbz5nM3eIzdcGW6BGlO88=
Received: by 10.213.107.16 with SMTP id z16mr7484580ebo.47.1259748987090;
        Wed, 02 Dec 2009 02:16:27 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 13sm639574ewy.1.2009.12.02.02.16.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 02:16:26 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Hector Martin <hector@marcansoft.com>
Subject: Re: BCM63xx merge progress
Date:   Wed, 2 Dec 2009 11:16:01 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-15-server; KDE/4.3.2; x86_64; ; )
Cc:     mbizon@freebox.fr, linux-mips@linux-mips.org, ralf@linux-mips.org
References: <4B15974E.1060505@marcansoft.com> <1259719052.2452.26.camel@kero> <4B15D4E7.6060707@marcansoft.com>
In-Reply-To: <4B15D4E7.6060707@marcansoft.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200912021116.01290.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

On Wednesday 02 December 2009 03:45:59 Hector Martin wrote:
> Maxime Bizon wrote:
> > On Wed, 2009-12-02 at 01:25 +0100, Hector Martin wrote:
> >> Well, there's a commit (4059ddb4) that claims to "Add USB OHCI support",
> >> yet it only adds a #include to ohci-hcd.c and a few .h bits. The actual
> >> ohci-bcm63xx.c is missing, which means the OHCI driver probably won't
> >> even compile. It's also missing the relevant platform device stuff in
> >
> > I cannot find this commit in linus' tree nor linux-mips master, where
> > does it come from ?
> 
> Okay, nevermind, that was a screwup by me. At some point one of my
> OpenWRT patch test commits made its way onto the wrong local branch, and
> I didn't notice where it lived. Oops. (This commit was meant to be
> incomplete, it comes straight from the OpenWRT patch). I think I found
> the mips-bcm63xx (proper) patch, tried to search for it on my local
> repo, and this thing popped up and I didn't look at it closely enough.
> This is what I get for trying to work at 4am.
> 
> I take back the 'broken' then, we're just left with 'incomplete'. Makes
> quite a bit more sense now, sorry for the confusion.
> 
> > The remaining two patches that were not merged in 2.6.32 are on top of
> > this tree: http://www.linux-mips.org/git?p=linux-bcm63xx.git
> >
> > They should apply with little difficulty on current upstream kernel and
> > besides the *_be stuffs that need to be cleaned up, they were ACKed by
> > the usb maintainer.
> 
> Cool, I'll see about applying them and working off of that. Thanks for
> the confirmation.
> 
> FWIW, I'm trying to reverse engineer Broadcom's DSL driver, which I hope
> will be useful so we can finally have a properly working OpenWRT
> firmware for DSL routers based on this firmware.

Good luck :)
-- 
WBR, Florian
