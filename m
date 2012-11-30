Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2012 20:27:29 +0100 (CET)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:32771 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826533Ab2K3T12VGlSc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Nov 2012 20:27:28 +0100
Received: by mail-wi0-f173.google.com with SMTP id hn17so6333115wib.6
        for <multiple recipients>; Fri, 30 Nov 2012 11:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KYdOTip/GZMSy0qKTfVpq6wDpPY//6bZEGZztGJDZvE=;
        b=nnG7KC7hUB+t106PmA1A4O9T5UY4DeFUoJvB+mVUeq458KUOXs3d/iIzksh6nd3rNe
         EinCFPt7p6h1mJv7yidqIB+79XElgfGv8nfIvxk5RGNUTGcvYwoyLrmA2/qyjvXL4qb6
         G74f+rtPOtAu5uotzFTBnkI1096FK6Q2DB3BGueQA8OW/RN/ltxP1PdP57iVQC8qTy6n
         H1BFWAM5wj0MG3rxSyIVP4+o/VFS7WfOJIdI8lhHts3u/t5d73mGdr0u37dTrkSjabCY
         nqYpwjK09tkkJnxYwL9eYL4nt39uAaAm5Bz7zQT6jwqTQSXhTma8JT5foYwwo2Fy5yIK
         WejQ==
MIME-Version: 1.0
Received: by 10.216.143.71 with SMTP id k49mr875452wej.7.1354303642858; Fri,
 30 Nov 2012 11:27:22 -0800 (PST)
Received: by 10.216.21.8 with HTTP; Fri, 30 Nov 2012 11:27:22 -0800 (PST)
In-Reply-To: <50B8B4AB.4060102@hauke-m.de>
References: <1353453874-523-1-git-send-email-hauke@hauke-m.de>
        <CACna6rzGE=CaD_9yAaTDkR6CuUy1HqRq1-v+fAd-Zg-uMmH2bQ@mail.gmail.com>
        <50B8B4AB.4060102@hauke-m.de>
Date:   Fri, 30 Nov 2012 20:27:22 +0100
Message-ID: <CACna6ryzM-32BmF0BipEg+q8hr9kAjPP=_vzCvgssgnVe_muHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] bcma/ssb/BCM47XX: add GPIO driver to ssb/bcma
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, florian@openwrt.org, m@bues.ch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35163
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2012/11/30 Hauke Mehrtens <hauke@hauke-m.de>:
> On 11/30/2012 02:11 PM, Rafał Miłecki wrote:
>> 2012/11/21 Hauke Mehrtens <hauke@hauke-m.de>:
>>> This is a complete rewrote of the original patch "MIPS: BCM47xx: use
>>> gpiolib"
>>> Instead of providing the GPIO driver in the arch code it is now moved
>>> into ssb and bcma and could also be used by other systems. The GPIO
>>> functions in drivers/ssb/embedded.c are still used by arch/mips/bcm47xx
>>> /wgt634u.c, but I am planing to write some code for baord detection and
>>> a driver for LED and the buttons, after that wgt634u.c could be removed.
>>>
>>> This is based on mips/master tree.
>>
>> Is this patches supposed to appear in
>> http://git.kernel.org/?p=linux/kernel/git/ralf/linux.git;a=summary
>> ? Just so I can know where to look for it.
>>
> Hi Rafał,
>
> It is in a mips tree at [0] and it is also in linux-next.
>
> Hauke
>
> [0]: http://git.linux-mips.org/?p=ralf/upstream-sfr.git;a=summary

Thanks for pointing as well as for your work!

-- 
Rafał
