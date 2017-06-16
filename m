Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 18:50:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35093 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994819AbdFPQt7RHrZz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 18:49:59 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E8BA541F8E09;
        Fri, 16 Jun 2017 18:59:22 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 16 Jun 2017 18:59:22 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 16 Jun 2017 18:59:22 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CA56DABCEDA72;
        Fri, 16 Jun 2017 17:49:48 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 16 Jun
 2017 17:49:52 +0100
Received: from np-p-burton.localnet (10.20.1.33) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 16 Jun
 2017 09:49:40 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/5] MIPS: FP cleanup & no-FP support
Date:   Fri, 16 Jun 2017 09:49:35 -0700
Message-ID: <3803102.5EWcPJmQIq@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <alpine.DEB.2.00.1706160348450.23046@tp.orcam.me.uk>
References: <20170605182131.16853-1-paul.burton@imgtec.com> <alpine.DEB.2.00.1706160348450.23046@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1610634.8HxNOHsFot";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.33]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58528
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

--nextPart1610634.8HxNOHsFot
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Maciej,

On Thursday, 15 June 2017 19:55:26 PDT Maciej W. Rozycki wrote:
> On Mon, 5 Jun 2017, Paul Burton wrote:
> > This series tidies up support for floating point a little, then
> > introduces support for disabling it via Kconfig. The end result is that
> > it becomes possible to compile a kernel which does not include any
> > support for userland which makes use of floating point instructions -
> > meaning that it never enables an FPU & does not include the FPU
> > emulator. The benefit of this is that if you know your userland code
> > will not use FP instructions then you can shrink the kernel by around
> > 65KiB.
> > 
> > Applies atop v4.12-rc4.
> > 
> > Paul Burton (5):
> >   MIPS: Remove unused R6000 support
> >   MIPS: Move r4k FP code from r4k_switch.S to r4k_fpu.S
> >   MIPS: Move r2300 FP code from r2300_switch.S to r2300_fpu.S
> >   MIPS: Remove unused ST_OFF from r2300_switch.S
> >   MIPS: Allow floating point support to be disabled
> 
> Doesn't ptrace(2) require suitable updates for requests that deal with
> the FP context?

I mentioned in the commit message for patch 5 that removing the actual context 
fields & ptrace access to them could be done as a further improvement.

> Preferably along with the last change (or maybe ahead of
> it) so that we don't have a kernel revision that presents rubbish to the
> userland (of course tools like GDB will have to be updated accordingly to
> cope, but that's out of scope for Linux itself).

Well, as-is ptrace would still let you read & write to FP registers if you 
try, it's just those values will never be used. Are you opposed to that 
behaviour? If we do later remove the context entirely then presumably ptrace 
would either read 0 or return an error, and ignore writes or return an error - 
I suppose if we want to ensure consistent behaviour for that potential future 
change then we could choose one of those options & do that here.

In practice I'm not sure I see much benefit - if a debugger wants to write to 
context corresponding to registers that just aren't there then letting it 
doesn't seem like a big problem. Do you disagree? Note that we already allow 
this for hi & lo registers on r6 for example - ptrace will freely read/write 
the context even though the registers don't exist.

> Also how about those prctl(2) calls that also operate on FP state?

Patch 5 has them return -EOPNOTSUPP, which is consistent with behaviour when 
attempting to set an unsupported mode.

Thanks,
    Paul
--nextPart1610634.8HxNOHsFot
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAllEDB8ACgkQgiDZ+mk8
HGU2FRAAhxztfj9aSiawAYbZOZ3ZFvILSBKvFIaGJm7LiogzdFR53tQUF9BHCuxK
B2POW/e8leKZAKVNVG8atjCw1e12D1JDpeotIl1lQi5KA6NOgktUtASb2oHe1mN0
3x1SLIgX5RC3A5SXwE6hzkJimIlyaD5lToDYmNVHBlPSn++r4eiMRD6oIhXxTKQr
OvV36NjGpU/f6xR4ZnPf7ZYnbZTuqx9zMjV90KUStrQ69E+1BKf0f2FqWkuNQf2C
5/PSvQ/nKaEHe85nUyhg71cmfQ3Z4ZHJ3n1OjoPpyy/+X0g2bmSNV1hX/KcVk7+A
VwiQET/RRVsc+noOMV4Gl9/s7JL1m24Sq/DX7cxaf+tvk+Ygb+ZFI3jxgG4dDkEo
AuB/1/GFWLXGOC94Po8YGI3o1vbELPHakzv8mMpN6H3Jb/b+Q8hpc7uwwTbYXJJq
b2ewPsw3nj6rZCHiqKtul5i3SbBqCxZpKE/RE1+owagB8yf4NXK7vVAu+cMieTpG
zbfBA4/hUxPu10KYziH/9T7g9sWBropT5F8TAazk4GVHWBnfPKhX2lkbRIYalNgd
57OiBZo2zcEGv8hNc2vXaeD2lqAL/JIV3ObvzCFAN7ObDvtfOt9ai8Tucf47or+i
LYQaElWEPZb6I9Ln5XejzhW+l6r/gSpRyq/Ir410em/THJJJ/0k=
=cetp
-----END PGP SIGNATURE-----

--nextPart1610634.8HxNOHsFot--
