Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jul 2010 13:27:14 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:34505 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492179Ab0GTL1K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jul 2010 13:27:10 +0200
Received: by eyd10 with SMTP id 10so1442364eyd.36
        for <linux-mips@linux-mips.org>; Tue, 20 Jul 2010 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=aHSVOHcdCgxsrqC1/pdLuQlnoiBFuVs7qJffncwFHBc=;
        b=w0QPn6vWU33JVGtmJy1BAcue5vpzBe8eACSXnfNxDBcUDxlMapDio7m3FZRhsNs8dg
         l/+zpSzmnycvYSZvo3boQdFBfSo4+a7S/h4bouLYWaJChjLQbS7ZVw90vq10vX0CRCQj
         fKRRQB2GteLBgKTVVGU0rzyOIu3fiOP8ORBbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=fHeq+fgyzSaQKNm2rReJxs5nWnFrVr3gGwLPlrcyjaO7KGCHKBpWefVom6h1ld05tG
         HsEFKm1QTHT+jJ7XbSHjXMtFskrxVnXTFTphvxiF/GNAKWe1JB9z1mwbHiG6Ee/S1YGb
         nz2Xqdygrfd0AbS6nSIVTZmjdsGHd5aoR1GA4=
Received: by 10.216.177.140 with SMTP id d12mr5232013wem.37.1279625229695;
        Tue, 20 Jul 2010 04:27:09 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id u32sm2789205weq.11.2010.07.20.04.27.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 04:27:08 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH v2] au1000_eth: get ethernet address from platform_data
Date:   Tue, 20 Jul 2010 13:24:20 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.32.15+drm33.5; KDE/4.4.2; x86_64; ; )
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        "Linux-MIPS" <linux-mips@linux-mips.org>,
        Wolfgang Grandegger <wg@denx.de>
References: <1279544125-28104-1-git-send-email-manuel.lauss@googlemail.com> <4C45762E.70909@grandegger.com>
In-Reply-To: <4C45762E.70909@grandegger.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201007201324.20400.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Wolfgang, Manuel,

On Tuesday 20 July 2010 12:10:54 Wolfgang Grandegger wrote:
> Hi Manuel,
> 
> On 07/19/2010 02:55 PM, Manuel Lauss wrote:
> > Modify au1000_eth to receive an ethernet address from platform data,
> > or choose a random one.
> > 
> > The default address is usually provided by the firmware; modify
> > platform device registration to use it if the board code has not
> > already overridden it.
> > 
> > Cc: Wolfgang Grandegger <wg@denx.de>
> > Cc: Florian Fainelli <florian@openwrt.org>
> > Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> > ---
> > v2: diffed against linus-git, on top of Wolfgang's patch
> > 
> >     "mips/alchemy: define eth platform devices in the correct order"
> >     This one should actually apply cleanly.
> > 
> > IMHO a device driver should not call firmware-specific functions
> > (be it MIPS-style prom_get_*(), OF properties or whatever) to
> > get missing information.  Instead this should be done by the
> > platform code which sets up the device.  This patch does just that.
> > 
> > Compile-tested only.  Florian, Wolfgang: could you please give this
> > a try on your boards?  If it works and you agree to it, I'll
> > resubmit it also to linux-netdev.  Thank you! (I don't have
> > accessible au1000-eth hardware).
> 
> I gave the patch a try. The kernel builds and runs fine. The eth's are
> realized in the correct order and do work properly. Feel free to add my
> "Tested-by: Wolfgang Grandegger <wg@denx.de>".

I will not be able to test it soon, so go ahead for merging it. Thanks!
--
Florian
