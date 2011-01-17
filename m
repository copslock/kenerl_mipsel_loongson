Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 12:21:24 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:41424 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493386Ab1AQLVV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 12:21:21 +0100
Received: by ywf7 with SMTP id 7so1689953ywf.36
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 03:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=HgpSN0t5kkoM/oz6u8+N5IKm8bBqArAM+J1mBnlc9eM=;
        b=cALwYJbya0m2vnfO7+JPvuKI2lj57zSDeVu0zMauY15lYigbL9d4HzkK6Xhti2f//d
         3CxXPsYLbgQJc+T1kkH+AlhY4LqaM7t2oORyKKfNPUuygaLVgdSaL/Uuemuf2xiVy4la
         79RW7dWTpVTAV5bmrqacnwWpZOujNcG4cZtrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=j6azJG0Bdnf6X9A7J3DXGSn2CsMOGv+zCwhBUnuC9t6HfUZhqwWq4AXfOupxdPO9Hf
         Ef4pvUoLQIJDDw3vzNERV+mwUHq2VfwhcyIhOJ3kelpy1g5fmwpKq9V5a0eLzDxCzWvH
         zI9AxRUeYJuxBO70cF2cybQWIMI2jeu+n7b9g=
Received: by 10.236.105.180 with SMTP id k40mr7698697yhg.93.1295263275973;
        Mon, 17 Jan 2011 03:21:15 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 50sm2597724yhl.29.2011.01.17.03.21.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 17 Jan 2011 03:21:14 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Michael =?utf-8?q?B=C3=BCsch?= <mb@bu3sch.de>
Subject: Re: Merging SSB and HND/AI support
Date:   Mon, 17 Jan 2011 12:20:52 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.35-24-server; KDE/4.5.1; x86_64; ; )
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
References: <AANLkTi=GDcy50zsC6=Dgv1-Ty3cYK2qpx9o=q3JdXuCh@mail.gmail.com> <1295261783.24530.3.camel@maggie>
In-Reply-To: <1295261783.24530.3.camel@maggie>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201101171220.52292.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

On Monday 17 January 2011 11:56:23 Michael Büsch wrote:
> On Mon, 2011-01-17 at 11:46 +0100, Jonas Gorski wrote:
> > Hello,
> > 
> > I am currently looking into adding support for the newer Broadcom
> > BCM47xx/53xx SoCs. They require having HND/AI support, which probably
> > means merging the current SSB code and the HND/AI code from the
> > brcm80211 driver. Is anyone already working on this?
> > 
> > As far as I can see, there are two possibilities:
> > 
> > a) Merge the HND/AI code into the current SSB code, or
> > 
> > b) add the missing code for SoCs to brcm80211 and replace the SSB code
> > with it.
> 
> Why can't we keep those two platforms separated?

That is also what I am wondering about. Considering that previous BCM47xx 
platforms use a MIPS4k core and newer one use MIPS74k or later, you would not 
be able to build a single kernel for both which takes advantages of compile-
time optimizations targetting MIPS74k. If this ist not a big concern, then 
let's target a single kernel.

> Is there really a lot of shared code between SSB and HND/AI?
> 
> It's true that there's currently a lot of device functionality built
> into ssb. Like pci bridge, mips core, extif, etc...
> If you take all that code out, you're probably not left with anything.
> 
> So why do we need to replace or merge SSB in the first place? Can't
> it co-exist with HND/AI?
