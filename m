Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Feb 2015 05:00:37 +0100 (CET)
Received: from mail-qg0-f49.google.com ([209.85.192.49]:51062 "EHLO
        mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006154AbbBUEAfmE8QJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Feb 2015 05:00:35 +0100
Received: by mail-qg0-f49.google.com with SMTP id q107so17278159qgd.8
        for <linux-mips@linux-mips.org>; Fri, 20 Feb 2015 20:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sTTNC7wFIOQ3X3r3q+3ay+Id81hZiai1ZJJhFvJQRKc=;
        b=iXsYNYzhRYghEE2C/6dm29xsB9t/ZyelKyuDKxUMAAPMR6Ix/Ly5Vawuhg9gtmGrRj
         ajy9NsFZMhhrqnItHHyMfotmF1wGENZWKE9B9/f3Yyuhzkrb3O18PQVE9BiYWW30e01J
         Lvs0//kg/SYX5BtrbzPGObhWGW1yfHwAwl2kKPK+jw1wV6G9sVjYoc82mtMLQuJG98ao
         D1Uip6qrLYCj4XnyF+C4DOull6UAJMBYY/MT0eoNhxDvWu/Kw1LGEZD4HIZm+RtlueJe
         5U5jGspeNuq2HLvG10MnBh2rhHMh0lg610MldHOO+nb78vFPujAYT/Ug9sRMVzna253R
         DopA==
X-Received: by 10.140.239.136 with SMTP id k130mr2328876qhc.2.1424491229982;
 Fri, 20 Feb 2015 20:00:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.168.4 with HTTP; Fri, 20 Feb 2015 20:00:09 -0800 (PST)
In-Reply-To: <alpine.LFD.2.11.1502200445290.26212@localhost>
References: <alpine.LFD.2.11.1502200445290.26212@localhost>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 20 Feb 2015 20:00:09 -0800
Message-ID: <CAEdQ38HVxBug9ukgE1oXLo_e+8FDB_yuY0vn1d84puoThhdYCA@mail.gmail.com>
Subject: Re: what is the purpose of the following LE->BE patch to arch/mips/include/asm/io.h?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Fri, Feb 20, 2015 at 1:53 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   was recently handed a MIPS-based dev board (can't name the vendor,
> NDA) that *typically* runs in LE mode but, because of a proprietary
> binary that must be run on the board and was compiled as BE, has to be
> run in BE mode.
>
>   the vendor supplied a yoctoproject layer that seems to work fine
> but, in changing the DEFAULTTUNE to big-endian, the following patch
> had to be applied to the 3.14 kernel tree to the file
> arch/mips/include/asm/io.h in order to get output from the console
> port as the system was booting:
>
> 326c326,333
> <               *__mem = __val;                                         \
> ---
>>       {                                                                               \
>>               if (sizeof(type) == sizeof(u32))                \
>>               {                                                                       \
>>                       *__mem = __cpu_to_le32(__val);  \

They're byte swapping a value if they're in big endian mode.

>>               }                                                                       \
>>               else                                                            \
>>                       *__mem = __val;                                         \

And they don't seem to really understand the __cpu_to_le32 macro...
