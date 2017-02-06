Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 15:07:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7405 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993543AbdBFOG4taHVj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 15:06:56 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B6E0241F8E39;
        Mon,  6 Feb 2017 15:10:26 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 06 Feb 2017 15:10:26 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 06 Feb 2017 15:10:26 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 8077B69160B79;
        Mon,  6 Feb 2017 14:06:47 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 6 Feb
 2017 14:06:50 +0000
Date:   Mon, 6 Feb 2017 14:06:50 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     <linux-mips@linux-mips.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Jonathan Corbet <corbet@lwn.net>, <kvm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 4/4] KVM: MIPS: Implement console output hypercall
Message-ID: <20170206140650.GW13049@jhogan-linux.le.imgtec.org>
References: <cover.3a9aba89648ae37be335c79cc2b18cf6bf57ef08.1486377433.git-series.james.hogan@imgtec.com>
 <7ae3d49bf9ce153a5460a393bfa513a585930487.1486377433.git-series.james.hogan@imgtec.com>
 <e6ab68b3-4ef1-cb4c-494b-402d22185d27@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NQqDiQVflaif2hna"
Content-Disposition: inline
In-Reply-To: <e6ab68b3-4ef1-cb4c-494b-402d22185d27@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--NQqDiQVflaif2hna
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2017 at 02:25:59PM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 06/02/2017 11:46, James Hogan wrote:
> > Documentation/virtual/kvm/api.txt seems to suggest that
> > KVM_EXIT_HYPERCALL is obsolete. When it suggests using KVM_EXIT_MMIO,
> > does it simply mean the guest should use MMIO to some virtio device of
> > some sort rather than using hypercalls, or that the hypercall should
> > somehow be munged into the mmio exit information?
>=20
> The former.

Okay, thanks.

>=20
> But there are cases when using hypercalls is unavoidable.  In that case
> the trend is to use other exit reasons than KVM_EXIT_HYPERCALL, such as
> KVM_EXIT_PAPR_HCALL in PowerPC.  Feel free to add KVM_EXIT_MIPS_CONOUT
> or something like that.

Okay, that sounds sensible. The existing mips_paravirt_defconfig does
contain CONFIG_VIRTIO_CONSOLE=3Dy though, so I'm thinking we may be able
to get away without this hypercall and without old paravirt guest
kernels becoming unusable.

David/Andreas: would you agree, or do you feel strongly that this
hypercall API should be kept? (with a different KVM exit reason)

>=20
> How would you find the character device to write to in QEMU?

I imagine it'd need a custom character device driver in QEMU so it could
be wired up to stdio/pty or whatever using QEMU arguments. I've only
tested it with a test case in my own MIPS KVM test suite so far though.

Cheers
James

--NQqDiQVflaif2hna
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYmILcAAoJEGwLaZPeOHZ6IhgP/j7Zkm8pD0g2GRV0OqwyRguG
pH/oRNOtSkvybCwRNzJu1akdOt2KCIxuF8CJmYlA5bExVG/X9JwVCEptnVgrihkH
hwOv9ihX5dE55h2lxWKcEKvBZnqHltfb4DG/14vWyWWIUOvVAyeQ3JlMX7GEGv4A
CEIcqO/dnywXtBEFoP4ukygQTFfVUo5/BC3qZ3+nPCcWdfFd6JhDMO2ZwHG5hRUV
yh0/x2hccyEL5Sp2BCAAFW7wUmlQ7TFG0BVjGbgGsIfOgl2xqfv/fXKkBUWzWtc1
LTOsU8+zbW4AX0A1/ob/Vt3S1rQimVl8+yOdqfjHRyOXTxFTFsestIQILDiUGj13
AWPFaZXF3wo/UazBnL78EQKQP9CCsuImCpXBiCLMgcQWOFzs4cU6D8Qe4P3TVBMC
lXKmwTbDtRkJYHopw7iglPHoIHdIKg9SzPQd/ZMFr/4ailKUo3wps8vaEzaImW8i
WK13aWKQ6WSwJH+dTDZq0SxOBYGyEXsvum0pTMZ/GOhq+wyTiRlUlyoKWee5dm/6
C1yA1PAG7+sJsNujkxgtjtnvGXmfcILxcTTHDXoNBgAhtGTV+TyRPsNgR5INP7XH
b0YOJmrLIlpBHenO2hCVGVBNxCEAcWiRqjLWpulPEoHs/LkCKjYMQ3Zf7TX9DmW4
IK1L/kvk0aFsBGu6bWel
=3oBt
-----END PGP SIGNATURE-----

--NQqDiQVflaif2hna--
