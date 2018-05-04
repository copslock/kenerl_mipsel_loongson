Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2018 15:24:50 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:53142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991843AbeEDNYoT6DhR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 May 2018 15:24:44 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96672177F;
        Fri,  4 May 2018 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525440277;
        bh=8DaIsRvvib4k3SRAmldQr1mX+KGT9cRTGSSsmbCi/pU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fOC5RfIQ44t1+GCSa4yZt7aAl3WFkktfiYST17cM4FdyIUf8ubvRTZptOPN8537aP
         H9/Kyy0kIDXKOP30fjX2Pz+ipNm96wvNGOXZeyKwdfJYlSU+9I4FG4oM5Vq9lZJhrH
         KHiOCrffptxJmtUYTJBFjSyayPqhpLkfQ7rnS3Dg=
Date:   Fri, 4 May 2018 14:24:33 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Matthew Fortune <Matthew.Fortune@mips.com>
Subject: Re: Introducing a nanoMIPS port for Linux
Message-ID: <20180504132432.GA30458@jamesdev>
References: <20180502215107.GA9884@saruman>
 <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63871
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


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 06:40:07PM -0400, Arnd Bergmann wrote:
> On Wed, May 2, 2018 at 5:51 PM, James Hogan <jhogan@kernel.org> wrote:
>=20
> > Due to the binary incompatibility between previous MIPS architecture
> > generations and nanoMIPS, and the significantly revamped compiler ABI,
> > where for the first time, a single Linux kernel would not be expected to
> > handle both old and new ABIs, we have decided to also take the
> > opportunity to modernise the Linux user ABI for nanoMIPS, making as much
> > use of generic interfaces as possible and modernising the true
> > architecture specific parts.
> >
> > This is similar to what a whole new kernel architecture would be
> > expected to adopt, but has been done within the existing MIPS
> > architecture port to allow reuse of the existing MIPS code, most of
> > which does not depend on these ABI specifics. Details of the proposed
> > Linux user ABI changes for nanoMIPS can be found here:
>=20
> While I haven't looked at the individual changes, I wonder whether
> it would be useful to make this new ABI use 64-bit time_t from
> the start, using the new system calls that Deepa and I have been
> posting recently.

Personally I'm all for squeezing as much API cleanup in as possible
before its merged, though obviously there'll be a point when the ABI may
need to be frozen, at which point we'll mostly have to accept what we
have within reason.

> There are still a few things to be worked out:
> only the first of four sets of syscall patches is merged so far,
> and we have a couple of areas that will require further ABI changes
> (sound, sockets, media and maybe a couple of smaller drivers),
> so it depends on the overall timing. If you would otherwise merge
> the patches quickly, then it may be better to just follow the existing
> 32-bit architectures and add the 64-bit entry points when we do it
> for everyone.

I think it'll likely be a couple of cycles before it gets merged anyway.
There's still work to do, and limited resources.

Cheers
James

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuxfDgAKCRA1zuSGKxAj
8gFKAQDBKIiLApOFjRYGPadIj0pTPL6FcfLozP0XuoIjjwlKdAEAguVMty7TjYS0
+MKImps2UKe+xTw3YLPtnZlk+cVTpQ0=
=7SKV
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
