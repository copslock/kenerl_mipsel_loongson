Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 14:28:08 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:59729 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903686Ab1LQN2E convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Dec 2011 14:28:04 +0100
Received: by wgbds11 with SMTP id ds11so6664531wgb.24
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 05:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hmKLZn0eq0In1d4XbqEe1muq6l/oGC5i2dQcjUBA/sg=;
        b=uBhMo1OGmDh/lIKTTMasPpEIiZbkc0g4vJ/Oc/8eonW/ODMxGzOP4gDrPVDLm5tTLp
         la1wNIlQPug7fg/6TG05uGMmaf0aN3RktOK9W3Y0Wt+uMIi1s7H1MTcdumETyM+qEFd3
         9RfS28OFn8t4NvUh7Zrqu+A6MUBarfpbUVLAo=
Received: by 10.227.206.6 with SMTP id fs6mr8085055wbb.20.1324128479547; Sat,
 17 Dec 2011 05:27:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.89.71 with HTTP; Sat, 17 Dec 2011 05:27:38 -0800 (PST)
In-Reply-To: <CAJpamw5qTXwMC_HQXN+ehjxDDQ6GXT_-Kcfu8E7P5F2CnLqsZA@mail.gmail.com>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
 <1324126698-9919-3-git-send-email-jonas.gorski@gmail.com> <CAJpamw5qTXwMC_HQXN+ehjxDDQ6GXT_-Kcfu8E7P5F2CnLqsZA@mail.gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sat, 17 Dec 2011 14:27:38 +0100
Message-ID: <CAOiHx=km1TEy0r1zpk+iSiqHMfqR2qPmtJQA5RsuGKG09e60tQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] MTD: bcm63xxpart: make sure CFE and NVRAM partitions
 are at least 64K
To:     Guillaume LECERF <glecerf@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14097

Hi Guillaume,

On 17 December 2011 14:13, Guillaume LECERF <glecerf@gmail.com> wrote:
> Hi Jonas,
>
> 2011/12/17 Jonas Gorski <jonas.gorski@gmail.com>:
>> -       spareaddr = roundup(totallen, master->erasesize) + master->erasesize;
>> -       sparelen = master->size - spareaddr - master->erasesize;
>> +       spareaddr = roundup(totallen, master->erasesize) + cfelen;
>
> spareaddr = roundup(totallen, cfelen) + cfelen ?

The intention is to align the spareaddr to the next eraseblock (cfelen
can be bigger than the erasesize). Maybe writing it as

       spareaddr = roundup(cfelen + totallen, master->erasesize);

would be cleaner.


Jonas
