Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2018 12:19:55 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:38012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990656AbeDKKTppbBW3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Apr 2018 12:19:45 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BF6421785;
        Wed, 11 Apr 2018 10:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF6421785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 11 Apr 2018 11:19:27 +0100
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
        linux-sparse@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH] bug.h: Work around GCC PR82365 in BUG()
Message-ID: <20180411101927.GA29949@saruman>
References: <20171219114112.939391-1-arnd@arndb.de>
 <20180410224805.GA21429@saruman>
 <CAK8P3a0-_u7_FCj-nH0izBv4ub6krm1uA32bwi2jtBzXJePcnQ@mail.gmail.com>
 <20180411095359.GB21429@saruman>
 <CAK8P3a2_ihWCuUvDz_SVA1TMomkO1d7pa6e2bOQkZcEVP+Ff-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2_ihWCuUvDz_SVA1TMomkO1d7pa6e2bOQkZcEVP+Ff-A@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63490
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


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 12:08:51PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 11, 2018 at 11:54 AM, James Hogan <jhogan@kernel.org> wrote:
> > On Wed, Apr 11, 2018 at 09:30:56AM +0200, Arnd Bergmann wrote:
> >> On Wed, Apr 11, 2018 at 12:48 AM, James Hogan <jhogan@kernel.org> wrot=
e:
> >> > Before I forward port those patches to add .insn for MIPS, is that s=
ort
> >> > of approach (an arch specific asm/compiler-gcc.h to allow MIPS to
> >> > override barrier_before_unreachable()) an acceptable fix?
> >>
> >> That sounds fine to me. However, I would suggest making that
> >> asm/compiler.h instead of asm/compiler-gcc.h, so we can also
> >> use the same file to include workarounds for clang if needed.
> >
> > Yes, though there are a few asm/compiler.h's already, and the alpha one
> > includes linux/compiler.h before undefining inline, so seems to have its
> > own specific purpose...
>=20
> Interesting. For the other ones, including asm/compiler.h from linux/comp=
iler.h
> seems appropriate though, so the question would be what to do with the
> alpha case. I think we can simply remove that header file and replace
> it with this patch:
>=20
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index b2022885ced8..5502404f54cd 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -81,6 +81,9 @@ config PGTABLE_LEVELS
>         int
>         default 3
>=20
> +config OPTIMIZE_INLINING
> +       def_bool y
> +
>  source "init/Kconfig"
>  source "kernel/Kconfig.freezer"
>=20
> which should have the same effect.

Hmm yes, and I suppose alpha would need ARCH_SUPPORTS_OPTIMIZED_INLINING
too. I'll give it a try.

Cheers
James

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrN4S4ACgkQbAtpk944
dnoXAxAAsHoTKQyZDTU/r/kGekG1pEfs0mc8yWLe9iRHbilM5u/YOGj6o0cqkkv8
7YEH7lfapOs5Fi3+t+kXezfDtIijHFiwlgWJXnqe8z1ZRoovmIw4BYZvZGRMUjrf
syPK/fOx2ZkQ+L3Zv02UdXfITV2rvWaK58olIs9Qnl7mwkUViA7cK3tzRtOhyKG1
mEi58L9dOR8SZIGLJjUvBHpMDKyXsTb1AD4chQ5I3TCs8eCOq5FCOb6b0sa9P2x5
UOpiJ1IMORXgML+FQ2o8lakjkk7b+jmj+NP4dgtydiMqlwZTcXydXW7POh7HMzko
G6R2+QQiDl8Wf8fqTokXskTT3v2/vM+TwufVJlxWTqirUmuDN2l8AICSXO0Y3PR4
aTJPIamIA/izYNBo0ukletJRH89TdHdzG5zSNypm6tYu5Vil69A20NnRHHQOYAk6
Wt1BZUZp9/hz1bcxMCT9jnB10xDO/cXOIODWiwWQQbgx/upbK6oFOHh8YKxgSnXQ
HFPAwV5tFNT7jVabbj43IQ2lIg+LlwLxL96VghSWxfmOrbUbZhBq7owHp3wwPYiF
2TAD34tz6oWpgismxcQMV3dnIILncctozEKBleRA63TxYh8gCSH/QsvTi+3zZI2M
8jnlOr4EkFefBAHhOAjZQE14qDig9/rW8FgnJTAhLteAF8f5wY0=
=HfmN
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
