Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 22:46:07 +0200 (CEST)
Received: from mail-lj1-x241.google.com ([IPv6:2a00:1450:4864:20::241]:45148
        "EHLO mail-lj1-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993316AbeGIUp4c0SEO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jul 2018 22:45:56 +0200
Received: by mail-lj1-x241.google.com with SMTP id q5-v6so15080627ljh.12;
        Mon, 09 Jul 2018 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qvZx+E7FUOHlPfEwlmNOPCLe43tN3FmGw+aWfCesvPE=;
        b=aXLVDgMMa2BaOhDVIIDf1n7Q02eHJryy8hjw+gHI46nL3PcGkF5za9OMiz0HOBsqiG
         SJHKeAGj3Vc8TmAdzTgfkkpJ95ZPrIQDxnkVwfoYL6F3RL3kUyjQVak6XsCXgaSnnncb
         dYSfzjikgo01wW7tsJ9YXmdy/kZRz9Z86fiJ4hZJn2jSFPBe63FyKOOVjuECgxNlQGuT
         mReP2o4KYHPzgLzRd0UML5/0vx6ccE9ZZauX01DfTb3ZDVawCy8aSX7eiVORf4kxQtCd
         RuyauW+++R4/ec8ymqL6HdUQdKO6UcGefNruGYkIp4twVZmYOu4CtybNWmkgpg40TDjn
         zo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qvZx+E7FUOHlPfEwlmNOPCLe43tN3FmGw+aWfCesvPE=;
        b=glhD7MFif9EIZrPv6BJHrpjlzbggTUxvFcNZLVhcQyF80WiBE13pRGVDCtgdRulBJb
         4WbJkzaH0feoFCuRj6u45V0E9oYLsHI2yICtK4QppZpN/khwl1odzX7M/KBQz77Lukw0
         IRiRHSNkEDAqvC4IPiu8WI3exOiF3No1C0y9hnvTUYOtBZGdA+DX6ZhJaAuN1rd7Dv81
         ZdbJi2Sc04wfei7cCX2xoud7MMWJVdxHHKzTv3fuQq+XaW6Nzu9LcTmz1YBYwE6OUgaI
         H/7cZEPNS5bXFFv5aOzm5QDrQScFi/RRP9HXmiOFRAELvec8rqZRddllttZL1KM0EvOc
         RcCQ==
X-Gm-Message-State: APt69E1NrHqcK+x4nOWdH/nk6oTUo2Wz7U3fGTJXtYSxUzyGsYgW1tSK
        hceVx8rdfjYtohrH+GvhrOzptDvMNxcAgzHj64k=
X-Google-Smtp-Source: AAOMgpfQK3uH5cDQ//P+3XK3Sn2Y/0aeD+ZTbavG6fZfTafJK4Suu+kUj7qQPIds5bah5QW4zMtlTHSMC2bozCWzXMk=
X-Received: by 2002:a2e:5bc8:: with SMTP id m69-v6mr14177769lje.115.1531169150952;
 Mon, 09 Jul 2018 13:45:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 13:45:50 -0700 (PDT)
In-Reply-To: <20180709200945.30116-1-boris.brezillon@bootlin.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Jul 2018 22:45:50 +0200
X-Google-Sender-Auth: 1SjUtYo1_D_k5fCAAe2D43WiqMc
Message-ID: <CAK8P3a2zUvr958ZDV9DeGd7y28TFi4A1eYG79rb8cZaPLvN0ng@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] mtd: rawnand: Improve compile-test coverage
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Mon, Jul 9, 2018 at 10:09 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Hello,
>
> This is an attempt at adding "depends || COMPILE_TEST" to all NAND
> drivers that have no compile-time dependencies on arch
> features/headers.
>
> This will hopefully help us (NAND/MTD maintainers) in detecting build
> issues earlier. Unfortunately we still have a few drivers that can't
> easily be modified to be arch independent.
>
> I tried to put all patches that only touch the NAND subsystem first,
> so that they can be applied even if other patches are being discussed.
>
> Don't hesitate to point any missing dependencies when compiled with
> COMPILE_TEST. I didn't have any problem when compiling, but that might
> be because the dependencies were already selected.

Looks good to me overall.

> In this v2, I tried to fix all warnings/errors reported by kbuild/0day
> robots. The only remaining ones are those in omap_elm.c which seems to
> do some weird cpu_to_be32() conversions. I guess I could replace those
> by iowrite32be() calls (or just add (__force __u32)), but I don't want
> to risk a regression on this driver, so I'm just leaving it for someone
> else to fix :P.

Agreed, this is definedly very odd code. It looks like the intention
is to write all the bits in reverse order, but four bytes at a time. I'm
fairly sure the current implementation cannot work on big-endian,
in particularly this line:

val = cpu_to_be32(*(u32 *) &ecc[0]) >> 12;

Since shifting a number after the byteswap is not well-defined.
It's probably correct on little-endian, but it's not clear what the
best way would be to write this is an endian-neutral way.

        Arnd
