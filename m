Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2018 12:56:23 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992678AbeBHL4RJPxEJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Feb 2018 12:56:17 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADAD62178E;
        Thu,  8 Feb 2018 11:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAD62178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 8 Feb 2018 11:55:59 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Miodrag Dinic <Miodrag.Dinic@mips.com>
Cc:     Paul Burton <Paul.Burton@mips.com>,
        Maciej Rozycki <Maciej.Rozycki@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        DengCheng Zhu <DengCheng.Zhu@mips.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Redfearn <Matt.Redfearn@mips.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: Re: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
Message-ID: <20180208115559.GA31316@saruman>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8CFEA@MIPSMAIL01.mipstec.com>
 <20171130100957.GG5027@jhogan-linux.mipstec.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8D102@MIPSMAIL01.mipstec.com>
 <alpine.DEB.2.00.1712061657520.4584@tp.orcam.me.uk>
 <20171206182400.6va3pqdmgisbino7@pburton-laptop>
 <48924BBB91ABDE4D9335632A6B179DD6A8E6B2@MIPSMAIL01.mipstec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <48924BBB91ABDE4D9335632A6B179DD6A8E6B2@MIPSMAIL01.mipstec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62461
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


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 07, 2017 at 11:33:47AM +0000, Miodrag Dinic wrote:
> > On Wed, Dec 06, 2017 at 05:50:52PM +0000, Maciej W. Rozycki wrote:
> > >  What problem are you trying to solve anyway?  Is it not something th=
at=20
> > > can be handled with the `execstack' utility?
> >=20
> > The commit message states that for Android "non-exec stack is required".
> > Is Android checking that then Aleksandar? If so, how?=20
>=20
> Android is using SELinux configured to disallow NX mappings by handling
> the following sepolicy rules :
> * Executable stack (execstack)
> * Executable heap (execheap)
> * File-based executable code which has been modified (execmod)
> * All other executable memory (execmem)

=2E..

> The effect of not having some workaround like this in the kernel, would
> be to run Android only in SELinux permissive mode.

So you want to override the lack of RIXI so that SELinux sees an
RX->RW->RX transition as execmod instead of execmem (since without RIXI
its effectively RX->RWX->RX which is execmem)?

Looking at file_map_prot_check(), it does the execmem check on this
condition:

if (default_noexec &&
    (prot & PROT_EXEC) && (!file || IS_PRIVATE(file_inode(file)) ||
			   (!shared && (prot & PROT_WRITE)))) {
	/*
	 * We are making executable an anonymous mapping or a
	 * private file mapping that will also be writable.
	 * This has an additional check.
	 */

default_noexec is set if VM_DATA_DEFAULT_FLAGS doesn't have the exec
flag set, and that flag depends on current->personality &
READ_IMPLIES_EXEC, which depends on elf_read_implies_exec(), i.e.
mips_elf_read_implies_exec(), and that should already return 1 if RIXI
is unavailable.

I.e.

mips_elf_read_implies_exec() =3D=3D 1

elf_read_implies_exec() =3D=3D 1

READ_IMPLIES_EXEC will be set in current->personality

VM_DATA_DEFAULT_FLAGS will have VM_EXEC set

default_noexec will be set to 0 in selinux_init()

none of the execmem, execheap, execstack, execmod permission
checks should take place.

So whats the problem exactly? Perhaps I misinterpreted something.

Cheers
James

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlp8OskACgkQbAtpk944
dnpXnRAAg8eCnu8MmRP7+MTOs3F4aNFTs3o5Wp9ERlenik4MfNwkHimTj1uwrvuu
sgMn6qc2x2HuctxuOXBNFlfix84qUFmAEggTUq9skE4PagLhy/6wmdCtlGBsmIPN
tmxgrGEoq0Zt0hT0puvDYOForX8nUAnO/B2zzhbTkIAeDj3VCamx8wR5d0JgoHit
F8Ls313c64AEI+3jN7eyFE18NbgMbtf/1APkIvHJLZm3hF3nSaks5X7gmpV4YrtY
TFglq8n9P/HBRs41JhKVdUShKip4H38ESVy0sBniemicC3OxwLP+B6GuftzsoX2G
OaNgYV4PNiQ4NOAiZgyBAC4oTyKEU+xgZwXzJjDjgitpkidDQYMhAw2oUu4SGZGX
BWgB7dHTGGO1eZzESuuf/9xjp7ZM2C8S5yK0/YstY+HLaaoi0b5h1iP+VH+hFcM2
PUeGZuCVYs6TCBBOVmEFtBhBDzlB/F9lnn60Fw7F7FrB6YbFTo+9V3Id4f1DUtmV
OjnvLji4DlVXlOAs2S7qwFRyZ0d6j6GdLx9MguxP0VezGTQzelUXiyBp9NcsD+du
rRAloaYtdAKkAj7t9RZmEaOdPLII3IDPCuvwvDeT1IFmtLo3ZEcxzoCjwgelv8dp
gyX8vyrV4TMIZJ8TeblON1vFiluXYzzmrucM/8o+PbQFfPvJoCA=
=ZezC
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
