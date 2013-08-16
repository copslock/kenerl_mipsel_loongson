Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Aug 2013 00:40:26 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:49193 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865383Ab3HPWkBIM7yq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Aug 2013 00:40:01 +0200
Received: by mail-pa0-f47.google.com with SMTP id kl13so2365763pab.20
        for <linux-mips@linux-mips.org>; Fri, 16 Aug 2013 15:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ITVxDzuKRy1xjT6wDMOuowMgCh3zyLKyt2E+hbY7xuI=;
        b=eNT/jSubNsTcZzsadSws78s2avPvhZ5GgGDwsfXetsiwhEqmnMuFLYhsfkZzzrlwQD
         aK6zb+2lwpfWkws1yWYOu21CSkfnvTHdTZeUrlNEOwQs0QGur3ySux4x2ldidocjBulw
         zw9p3RyC2mvjrq69v1j71l2xBEWYiY6x9H0OLaTva+w6PVIJI5zxAjCcbCiUDxZKAsZg
         ZshVpMBTD6eunYrtuEU7MMZR3vxdL42TbTr1E9IVCLviGVY6/4LjyU/gU/Ky3LiS6re9
         8jDi+g2T861wQRsA2eOspaVNKnpU7ocJxzDc+V1fyxClo6CfutD0aZW2cuBMHdyOLQ4z
         n8rg==
X-Received: by 10.68.34.165 with SMTP id a5mr21515pbj.156.1376692794032;
        Fri, 16 Aug 2013 15:39:54 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id y6sm4316658pbl.23.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 15:39:53 -0700 (PDT)
Date:   Fri, 16 Aug 2013 15:39:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [ 00/17] 3.4.58-stable review
Message-ID: <20130816223950.GA9152@roeck-us.net>
References: <20130813201936.GA18358@roeck-us.net>
 <20130815063158.GB25754@kroah.com>
 <520C86BD.2020903@roeck-us.net>
 <CAMuHMdU+EOC_etihOzUC6N0cqc2qHaGm3_L+gyTRxESCGhOzEg@mail.gmail.com>
 <520DB045.7000309@roeck-us.net>
 <20130816051041.GA23784@kroah.com>
 <520DE21D.8000905@roeck-us.net>
 <20130816124140.GD24550@kroah.com>
 <20130816202702.GD4568@roeck-us.net>
 <CAMuHMdW6Ji7ibMeQj5FBQsJS3B-WWx=Lbhmjx4CCFEGg_uobHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW6Ji7ibMeQj5FBQsJS3B-WWx=Lbhmjx4CCFEGg_uobHQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Fri, Aug 16, 2013 at 11:55:02PM +0200, Geert Uytterhoeven wrote:
> On Fri, Aug 16, 2013 at 10:27 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > Still failing:
> >         sparc64:allmodconfig
> > /opt/buildbot/slave/stable-queue-3_4/build/usr/include/linux/types.h:27:1: error: unknown type name ‘__u16’
> 
> According to my log collection, this same error message was fixed in v3.3-rc2,
> but I couldn't easily find a matching commit.
> But this is v3.4-stable, which is after v3.3-rc2, so it got reintroduced?
> 
It was fixed recently with

commit cbf1ef6b3345d2cc7e62407eec6a6f72a8b1346f
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Sun Mar 31 07:01:47 2013 +0000

    sparc: use asm-generic version of types.h

and

commit a2d34dd41212032c03e77bc30c2023725def841a
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Sat Mar 30 11:44:22 2013 +0000

    sparc: use generic headers

I tried to apply those patches, but it failed miserably due to the
userspace/kernel header separation. Given that, I figured that
it would be too invasive to fix, at least for me.

> >         xtensa:defconfig
> > dev.c:(.text.unlikely+0x3): dangerous relocation: l32r: literal placed after use: .literal.unlikely
> 
> Fixed in v3.7-rc1:
> 
> commit f6a03a12ecdbe0dd80a55f6df3b7206c5a403a49
> Author: Max Filippov <jcmvbkbc@gmail.com>
> Date:   Mon Sep 17 05:44:31 2012 +0400
> 
>     xtensa: fix linker script transformation for .text.unlikely
> 
Yes, that fixes this problem, except now we get another known error:

kernel/built-in.o:(.text+0x8c8): undefined reference to `_sdata'

which you had fixed with

commit 5e7b6ed8e9bf3c8e3bb579fd0aec64f6526f8c81
Author: Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed Jun 20 12:52:58 2012 -0700

    xtensa: replace xtensa-specific _f{data,text} by _s{data,text}

After applying both patches to the 3.4-stable queue, xtensa:defconfig builds
successfully.

Thanks,
Guenter
