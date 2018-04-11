Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2018 11:54:23 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990493AbeDKJyQLF8N3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Apr 2018 11:54:16 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44ABD21725;
        Wed, 11 Apr 2018 09:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ABD21725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 11 Apr 2018 10:54:00 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Maciej Rozycki <macro@mips.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christopher Li <sparse@chrisli.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] bug.h: Work around GCC PR82365 in BUG()
Message-ID: <20180411095359.GB21429@saruman>
References: <20171219114112.939391-1-arnd@arndb.de>
 <20180410224805.GA21429@saruman>
 <CAK8P3a0-_u7_FCj-nH0izBv4ub6krm1uA32bwi2jtBzXJePcnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0-_u7_FCj-nH0izBv4ub6krm1uA32bwi2jtBzXJePcnQ@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 09:30:56AM +0200, Arnd Bergmann wrote:
> On Wed, Apr 11, 2018 at 12:48 AM, James Hogan <jhogan@kernel.org> wrote:
> > Before I forward port those patches to add .insn for MIPS, is that sort
> > of approach (an arch specific asm/compiler-gcc.h to allow MIPS to
> > override barrier_before_unreachable()) an acceptable fix?
>=20
> That sounds fine to me. However, I would suggest making that
> asm/compiler.h instead of asm/compiler-gcc.h, so we can also
> use the same file to include workarounds for clang if needed.

Yes, though there are a few asm/compiler.h's already, and the alpha one
includes linux/compiler.h before undefining inline, so seems to have its
own specific purpose...

Cheers
James

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrN2zcACgkQbAtpk944
dnq4xQ//W/rBEEvKM2KXaxuW0aYIu5tRiVtFhDs8mABCrU7S1CieiW/jwb/hvMpi
y8FpHCqjEIAaLlZT/yv+05QHtPiT8I5+3EcJJmUMpXxXGAAZV1V9IZ3gCM3U9B0G
NoNYHD5kxjf+JX/+47P8hcG5dREp2TmUYrIZ8USYbXkc/jcCCrJfNra/I2OLY9lQ
sw5V67uUE+0CE83n2yGrFLmb2Nh9tIIPo7DTvS7ZmBV0mc2ltU8wwPbkKtpfqEOq
YSF3+2AvJrt9TWpudwuxIp7wnhNWAdOGPiSyDTSdYzK02US8cC1l3KHMswzIbhNK
YCrVHl7U0fa1wx2ka6cbNepnxRUd9lfX64Cs5SsjomgDiItcJJNqkSWijwETm/wh
ZWJids6oj6KYdNDwasNr096sv9S+3+IuVwLVcVtSyN9UHfkfJGAeLubT5JJYG9QH
OR4I0Gdcy2/aH9o+vvvmQFyrNa4yBPNHyl6EsToI8aa+gWqg1wcRROABBxcdElgn
mMBLQ9kruLIp8M6ucVTtowe9u7OzP92lCH1pQhh3yD6rgwUUAeNarxRg2Pim8OiL
B+4S/GODXOUXZyaku7wbaDf4IL3nhArScsspzepnyo//ZOhz69beRfDExDT2gTJk
k7YWsQxMpdhQJpi+XBhDPAHGx+lq4mIK01pMgtp0IGoh59aTTsE=
=OyoV
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
