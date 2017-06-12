Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2017 00:48:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16111 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991346AbdFLWrxTQexK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jun 2017 00:47:53 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E403541F8D43;
        Tue, 13 Jun 2017 00:57:07 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 13 Jun 2017 00:57:07 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 13 Jun 2017 00:57:07 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1715F5B0EA4CA;
        Mon, 12 Jun 2017 23:47:43 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 12 Jun
 2017 23:47:47 +0100
Received: from np-p-burton.localnet (10.20.1.33) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 12 Jun
 2017 15:47:45 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 00/11] MIPS: cmpxchg(), xchg() fixes & queued locks
Date:   Mon, 12 Jun 2017 15:47:38 -0700
Message-ID: <1611645.sZenGtTiCG@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <20170612082742.GA5642@linux-mips.org>
References: <20170610002644.8434-1-paul.burton@imgtec.com> <20170612082742.GA5642@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3870649.uKXU0NXBdv";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.33]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart3870649.uKXU0NXBdv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Ralf,

On Monday, 12 June 2017 01:27:42 PDT Ralf Baechle wrote:
> On Fri, Jun 09, 2017 at 05:26:32PM -0700, Paul Burton wrote:
> > This series makes a bunch of cleanups & improvements to the cmpxchg() &
> > xchg() macros & functions, allowing them to be used on values smaller
> > than 4 bytes, then switches MIPS over to use generic queued spinlocks &
> > queued read/write locks.
> 
> A number of nice cleanups there!

Thanks!

> I'm wondering, have you tested the kernel size with and without this
> series applied?  GCC claims since 25 years or so that inlines are as
> efficient as macros but in reality macros have always been superior
> which mattered for things that are expanded very often.
> 
> More recent GCCs have claimed improvments so it'd be interested to see
> actual numbers - and possibly get rid of many more unmaintainable macros.

If I build a pistachio_defconfig v4.12-rc4 kernel, with ftrace disabled (same 
config mentioned in the 2 locking patches) and with my "MIPS: Hardcode 
cpu_has_* where known at compile time due to ISA" patch applied in all cases 
then I see:

   Configuration                  |  Size
  --------------------------------|---------
   v4.12-rc4                      | 7161133
   v4.12-rc4 + cmpxchg cleanups   | 7165597
   v4.12-rc4 + whole series       | 7166600

The cmpxchg cleanups row applies patches 1-9 of this series but leaves off the 
2 queued locking patches, so is a direct look at just the cmpxchg/xchg 
changes.

Sizes are as reported by scripts/bloat-o-meter. The toolchain used was 
Codescape 2016.05-06 (gcc 4.9.2, binutils 2.24.90) as found here:

http://codescape-mips-sdk.imgtec.com/components/toolchain/2016.05-06/

So the cmpxchg patches cost us 4464 bytes, of which __cmpxchg_small() & 
__xchg_small() make up 444 bytes:

function                                     old     new   delta
__cmpxchg_small                                -     236    +236
__xchg_small                                   -     208    +208

The rest is all small changes one way or the other to various functions 
throughout the tree, making up a little under 4KiB cost to the cmpxchg() & 
xchg() cleanups. Not zero (which actually surprises me..!) but hopefully not 
too much.

The generic queued locks then cost us a further ~1KiB but I'd argue offer 
enough benefits to outweigh that (if nothing else look at asm/spinlock.h 
afterwards :p).

Thanks,
    Paul
--nextPart3870649.uKXU0NXBdv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlk/GgoACgkQgiDZ+mk8
HGXaBxAAoe037ZDRuTlB0PPSkVVD6m93etEpcLuzVr9Eb/WWnjbUB33F+ijI5hi9
A/3sCf8iLvtmpnjvuymVXw/LwFk46qiOH6PWujqFDH71Nt23WgIgIitcTKefqK5L
4GbRhYG2TaUn1RWHY1Es7VjmT/bvfWb9tgDNnJYYK3X/WXnJuPiqI7E/4kMlDyxs
Ly7C88MvsZp8Tt//uDOwWNWRJmgLXfg6MYAWoxRNwTvnRLHzC5yJHRwmJEtkGk0c
tFNPbyH3SWN1h6PgsU/1OQbtCZSz9l2S3oqblm+RGPiWckvOFzBeQ6+OGM06JOuA
HwMjX0rMlI9D8zKeF4w0qjpTb0ixpNTqjYa8kbNJw0ultaVyO08yr08ABeJnN+lp
XgbZrKfo0hvT74W5EAV+XKzO438zz/CqgCbXG42minzVu+0KF754w1zzoOHjqitf
cwfhuzL4B+htynsNSZhwtaqh/Y2GqGOkQPFtu6eiRJEKLsz575L/sGgXHclFFtVN
XOmx8Fz67rSkcuxH1n5VHTvipJDWa2s+OuO2KdbzRDLxC7sVWiGWewEgv/ExNrQM
eprVEOzPQpj/TdZTJiSWbHOnWURVEfceHNBpwBWT/XHhZ+sR0QRnBE/nMYX5Vx+w
Hy7SuR5uh4M8G1H73ccJEBFONvYHZtDxWaqjwmpYdSpnbK6P0yM=
=I9xf
-----END PGP SIGNATURE-----

--nextPart3870649.uKXU0NXBdv--
