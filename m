Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 15:32:50 +0100 (CET)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:58242 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903696Ab1LQOcq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Dec 2011 15:32:46 +0100
Received: by vcbf11 with SMTP id f11so3069333vcb.36
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 06:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Uyz5Z5u9EuyE3ZKkh505d5dTN2RzRZ2dtaXo57Arnhc=;
        b=skjtPkKcJu0eouwHZW+zJQUJaIp3B9XxrdIFR0ePYsn9/zGhVRoxqNn+L9g5gDWuZ5
         EpXdrFFb8e1p59hZgz57m1GBsyZG8fjmibYkDXV7ksrkc2GARLTg4EU8o/O2+xLgPiVN
         XFWXIkro+D8B274lHeHmjcfzIlNmz2Hmd6tVk=
Received: by 10.220.214.73 with SMTP id gz9mr6220391vcb.5.1324132360229; Sat,
 17 Dec 2011 06:32:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.52.182.98 with HTTP; Sat, 17 Dec 2011 06:32:19 -0800 (PST)
In-Reply-To: <CAOiHx=km1TEy0r1zpk+iSiqHMfqR2qPmtJQA5RsuGKG09e60tQ@mail.gmail.com>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
 <1324126698-9919-3-git-send-email-jonas.gorski@gmail.com> <CAJpamw5qTXwMC_HQXN+ehjxDDQ6GXT_-Kcfu8E7P5F2CnLqsZA@mail.gmail.com>
 <CAOiHx=km1TEy0r1zpk+iSiqHMfqR2qPmtJQA5RsuGKG09e60tQ@mail.gmail.com>
From:   Guillaume LECERF <glecerf@gmail.com>
Date:   Sat, 17 Dec 2011 15:32:19 +0100
X-Google-Sender-Auth: WuNWVBkiH0lLrKBry4PK3OlA6bk
Message-ID: <CAJpamw6JpENR4Us5c=-49MbL-2j1Aq1LnP5khbBkptDAXPvzJA@mail.gmail.com>
Subject: Re: [PATCH 2/5] MTD: bcm63xxpart: make sure CFE and NVRAM partitions
 are at least 64K
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glecerf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14113

2011/12/17 Jonas Gorski <jonas.gorski@gmail.com>:
> The intention is to align the spareaddr to the next eraseblock (cfelen
> can be bigger than the erasesize). Maybe writing it as
>
>        spareaddr = roundup(cfelen + totallen, master->erasesize);
>
> would be cleaner.


Humm, you're right, forget my comment.
BTW I don't mind what syntax you chose.

Good job ;)


-- 
Guillaume LECERF
OpenBricks developer - www.openbricks.org
