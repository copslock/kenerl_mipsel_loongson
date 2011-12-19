Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2011 13:02:07 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:58894 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903613Ab1LSMCD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2011 13:02:03 +0100
Received: by wera10 with SMTP id a10so1619240wer.36
        for <linux-mips@linux-mips.org>; Mon, 19 Dec 2011 04:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ff2yP9SyBgpeFjFkt4azLm3OX/T+dqXtLUjgf7XlCDs=;
        b=RUuZ7qBWyFcOX9Ygqhdg8USmt1n5GGeNYQtEtHoceZ5s6yjaKDwEOvcjqU6IaLrDb0
         GNFPFyyKD6tMe1tXM086Od/q5bHJAZWeieFiqM67QJ9Xkmrninr0J9QSZnst6SkXSR/2
         /xOSh/V8X5iL20PfEy5sV7QoCnQPSVHJ9NdYA=
Received: by 10.216.135.154 with SMTP id u26mr6624203wei.20.1324296118355;
 Mon, 19 Dec 2011 04:01:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.117.2 with HTTP; Mon, 19 Dec 2011 04:01:37 -0800 (PST)
In-Reply-To: <1324292192.32675.6.camel@sauron.fi.intel.com>
References: <1324208821.17534.0.camel@sauron.fi.intel.com> <1324290964-14096-1-git-send-email-jonas.gorski@gmail.com>
 <1324292192.32675.6.camel@sauron.fi.intel.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 19 Dec 2011 13:01:37 +0100
Message-ID: <CAOiHx=kV8ovXQc2TTdxigMuVbSwj3GwsGs8K+vxMd_VepD3hSg@mail.gmail.com>
Subject: Re: [PATCH V2 2/5] MTD: bcm63xxpart: make sure CFE and NVRAM
 partitions are at least 64K
To:     dedekind1@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 32142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14927

On 19 December 2011 11:56, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Mon, 2011-12-19 at 11:36 +0100, Jonas Gorski wrote:
>> The CFE boot loader on BCM63XX platforms assumes itself and the NVRAM
>> partition to be 64 KiB (or erase block sized, if larger).
>> Ensure this assumption is also met when creating the partitions to
>> prevent accidential erasure of CFE or NVRAM.
>>
>> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
>
> If someone creates a partition smaller than 64 KiB, then why it is
> better to silently make it 64 KiB (and thus doing not what the user
> asked to do and possibly confusing him), rather than returning an error
> or just printing a warning?

This adjustment to 64 KiB is only done for the CFE and NVRAM
partitions, not for the rootfs or kernel partitions. The CFE and NVRAM
lengths/offsets are defined in the CFE boot loader at build time and
fixed, so to change them you would need to build and flash your own
CFE (and the sources are not public, so you also need to be a Broadcom
customer). I have yet to see a device where this was done, so this is
currently just a theoretical possibility.

Also you can't create/modify partitions arbitrarily as there is no
partition table, just a fixed image header format (which the CFE
parses on boot). So the only two partitions changeable from the
outside are the kernel and rootfs partitions, which are defined in the
image tag, which always resides at the beginning of the first erase
block after the CFE. Changing the CFE length would result in a changed
offset of the image tag, leading to a "wrong" image tag being read (or
in case after patch 5, a warning that the image tag is likely corrupt,
and no rootfs/kernel partitions created).

Of course everything is done under the assumption the boot loader is
CFE (there are a few devices with RedBoot out there), but the parser
already bails out if no CFE is detected.

Hope that clears things up.

Jonas
