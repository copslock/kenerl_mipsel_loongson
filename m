Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 14:18:41 +0100 (CET)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:59397 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011594AbaJ1NSjz8jOI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Oct 2014 14:18:39 +0100
Received: by mail-ie0-f171.google.com with SMTP id x19so603481ier.16
        for <multiple recipients>; Tue, 28 Oct 2014 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=D2m9k0X/0ySeajwig3bjM4z80ng9YhGlJQHBPJXypMY=;
        b=DVspXC1t5eMhDl5qNe+FwU3262vfyMz6HVCIzlYHdQxNwonHEIDfZZdHUQcoNyVjUT
         M0ILSSE4ENcvZDwtIOkD6o1BhdG9DYs6Yman7egMb6+iMWZCdhsVA0myFI2Q2xi5fAL/
         9B3CWEtu5WNZhR6MhTqPgeJHNr+IlQF6UG/abeH/MaDmOzmhz0bCzkT48GypctFRIb61
         SA4rE5dnXXt5R3i/L14XrfkpFedhirC4lNeDH4j/g+oGhjIvaqXQHTC2fW24NO36wXzU
         Qhl+XR2RjpSKjE7S1AlgpLdnPmf/wXxr7g2bRcegXHxafxbr4/9WlwpyKO46goJq/TLS
         35oQ==
MIME-Version: 1.0
X-Received: by 10.107.36.141 with SMTP id k135mr3876921iok.14.1414502313470;
 Tue, 28 Oct 2014 06:18:33 -0700 (PDT)
Received: by 10.107.154.15 with HTTP; Tue, 28 Oct 2014 06:18:33 -0700 (PDT)
In-Reply-To: <20141028131315.GD16320@linux-mips.org>
References: <1414499423-16662-1-git-send-email-zajec5@gmail.com>
        <20141028124804.GC16320@linux-mips.org>
        <CACna6rxSCZJ=oUNXVYEbkSZuiyUyy96amkMKbg7pdEXkVmtkZw@mail.gmail.com>
        <20141028131315.GD16320@linux-mips.org>
Date:   Tue, 28 Oct 2014 14:18:33 +0100
Message-ID: <CACna6rz78HtA6AVxQP0PWiuRSbGZvtNudHz46jLOx860kis2UA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Make bcma init NVRAM instead of bcm47xx
 polling it
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43629
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

On 28 October 2014 14:13, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Oct 28, 2014 at 01:51:06PM +0100, Rafał Miłecki wrote:
>
>> > V3: https://patchwork.linux-mips.org/patch/7612/
>
> This patch in turn depends on
>
> https://patchwork.linux-mips.org/patch/7605/
>
> against which Hauke raised some objections.  Wanna sort those?

7605 is V1 with mistakes pointed by Hauke
7611 is V2 which fixes things pointed by Hauke

Please use
http://patchwork.linux-mips.org/patch/7611/


-- 
Rafał
