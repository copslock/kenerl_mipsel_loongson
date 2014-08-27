Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 20:43:48 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:64210 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007092AbaH0SnrHdMHk convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Aug 2014 20:43:47 +0200
Received: by mail-ig0-f170.google.com with SMTP id h3so7738790igd.5
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=BGETvWlbP2hJbp+8TUrCyQHPOdVQZaHy5xbE/6Geq44=;
        b=zOJjTjvLgr0DLziL14WW0acOzcICttF9QKIqkI92mkeZEgzGMszXapW0A1nWLgUJ0x
         YWMtyFpoc6Xk8vSJ5XaIbWJ/G49/zTbOVJ4JjY14EDnnPaRe75/Z63ZpZoMBMZZU4M9O
         0MVJpGhuwLwpLLcJB5AK/Eq+mZ5vfBS+ghmujOThKFn/6Ss8eKuX0Pt+vNZl3uTqHbIB
         RpKx+8RktoWQT25uMRnS9X+9AH3Bn++28cRbCa59+YEmlx9BVfLkElGNpojxFHMIgoPq
         u6ZJpDrPUmagZvw6o9hranHKQbnXAsHpATnFC1Ck/IkelvxLay7xa9WkslaM/hfvOjwA
         uiSQ==
MIME-Version: 1.0
X-Received: by 10.42.107.145 with SMTP id d17mr15738853icp.61.1409165020774;
 Wed, 27 Aug 2014 11:43:40 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Wed, 27 Aug 2014 11:43:40 -0700 (PDT)
In-Reply-To: <53FE217B.7000401@gmail.com>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
        <1408915485-8078-4-git-send-email-hauke@hauke-m.de>
        <CACna6rwJBDpg9VS4h5hfP4wtGRVwAdRUq5mELeA0OFWWzH9jsA@mail.gmail.com>
        <53FE217B.7000401@gmail.com>
Date:   Wed, 27 Aug 2014 20:43:40 +0200
Message-ID: <CACna6ryXtFwJxBhEoJe+2mZWut24egtgXzzybxQ=rtPn9+X+2g@mail.gmail.com>
Subject: Re: [RFC 2/7] bcm47xx-nvram: add new broadcom nvram driver with dt support
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, devicetree@vger.kernel.org,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 27 August 2014 20:20, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 08/26/2014 10:54 PM, Rafał Miłecki wrote:
>> Could we avoid that? Type of flash can easily be checked in the code.
>> All we need to do is to read BCMA_IOST register of BCMA_CORE_NS_ROM
>> core.
>
> So there is a boot status register you can read to tell what type of
> flash you booted from, but does that also give you the resource ranges
> for these type of flashes? Presumably they will be mapped into different
> addresses (at least bcm63xx is like that), that information needs to be
> listed somewhere.

Take a look at find_nvram in nvram_rw.c. It scans the whole region
which is up to 0x02000000 (SI_FLASH2_SZ) size.

In case of NAND limit is slightly different (nfl_boot_size function):
1) On ARM it's 0x800000 or 0x2600000
2) On MIPS it's 0x200000

-- 
Rafał
