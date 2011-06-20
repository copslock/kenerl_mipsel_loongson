Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 02:41:44 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:56965 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490993Ab1FTAll convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Jun 2011 02:41:41 +0200
Received: by pzk28 with SMTP id 28so3515760pzk.36
        for <linux-mips@linux-mips.org>; Sun, 19 Jun 2011 17:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ch7k9QM8lFKwDV1GRvwcHnAGDoDJWkCezYz67hkAAx0=;
        b=je4aErcuA+24nsBEB9ZM2sDMecvWOHBRn8BF3C1SMVZxkaC1iz3usAKia9vqQ68wvO
         bHBkdwQDtg4p5Q3jx32C0doOhJBRIdJ5nrcrRKAjKKCAf71henHtte/Y5/vrvJWpw1UB
         hBpOIoeNI4JUAT2yBa03avBUOky1zKI8i71qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=COwlWHWliWRqWH1KiBCF0KkAu7rCOz2uvNHiWM8q62w3C9k7fE+4faZQgN0LWx4ztB
         iYC6WdnfjemYJR6VM1eXYQgMRYWxQK45BeGghGaaxHYk3NtKmtxpWp64kmV7Zv4fazIT
         yOQ/ZRVtGWD1KeXamp7jWLdiETTJK3d5ngipo=
MIME-Version: 1.0
Received: by 10.68.58.193 with SMTP id t1mr1896827pbq.43.1308530494336; Sun,
 19 Jun 2011 17:41:34 -0700 (PDT)
Received: by 10.68.40.72 with HTTP; Sun, 19 Jun 2011 17:41:34 -0700 (PDT)
In-Reply-To: <1308520209-668-1-git-send-email-hauke@hauke-m.de>
References: <1308520209-668-1-git-send-email-hauke@hauke-m.de>
Date:   Mon, 20 Jun 2011 02:41:34 +0200
Message-ID: <BANLkTim5R1ukc5OJQRRpF6EsmzeoL=SUoA@mail.gmail.com>
Subject: Re: [RFC v2 00/12] bcma: add support for embedded devices like bcm4716
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15770

Hey Hauke,

2011/6/19 Hauke Mehrtens <hauke@hauke-m.de>:
> This patch series adds support for embedded devices like bcm47xx to
> bcma. Bcma is used on bcm4716 and bcm4718 SoCs. With these patches my
> bcm4716 device boots up till it tries to access the flash, because the
> serial flash chip is unsupported for now, this will be my next task.
> This adds support for MIPS cores, interrupt configuration and the
> serial console.
>
> These patches are based on ssb code, some patches by George Kashperko
> and Bernhard Loos and parts of the source code release by ASUS and
> Netgear for their devices.
>
> This was tested on a Netgear WNDR3400, but did not work fully because
> of serial flash.
>
> This is bases on linux-next next-20110616, to which subsystem
> maintainer should I send these patches later, as it is based on the
> most recent version of bcma and bcm47xx?
> I do not have any normal PCIe based wireless device using this bus, so
> I have not tested it with such a device, it will be nice to hear if it
> is still working on them.
> The parallel flash should work so it could be that it will boot on an
> Asus rt-n16, I have not tested that.

I'm glad you are still working on it!
Unfortunately it's really late right now and I'm leaving tomorrow
(well, today as we passed midnight) for the whole week :( I'm not sure
if I'll get a chance to review this, not to mention testing against
any of my PCIe card.


> An Ethernet driver is not included because the Braodcom source code
> available is not licensed under a GPL compatible license and building a
> new driver on that based is not possible.

I wonder if you could write specs for that core, so I could write
GPL/any driver for it? Is that driver really big?

-- 
Rafał
