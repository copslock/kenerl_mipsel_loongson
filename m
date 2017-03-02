Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 12:39:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12247 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992213AbdCBLjcTzGFG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 12:39:32 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 70D0741F8DED;
        Thu,  2 Mar 2017 12:44:04 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 02 Mar 2017 12:44:04 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 02 Mar 2017 12:44:04 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2CC5DD9627D79;
        Thu,  2 Mar 2017 11:39:21 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 2 Mar
 2017 11:39:23 +0000
Date:   Thu, 2 Mar 2017 11:39:23 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 11/32] KVM: MIPS: Add VZ capability
Message-ID: <20170302113923.GC2878@jhogan-linux.le.imgtec.org>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
 <17827db14f848b69e8184ae80b5d63ba01b4b106.1488447004.git-series.james.hogan@imgtec.com>
 <bb40a6bb-e6b3-a37b-a08e-daccbf52bbef@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <bb40a6bb-e6b3-a37b-a08e-daccbf52bbef@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56996
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

--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Thu, Mar 02, 2017 at 11:59:28AM +0100, Paolo Bonzini wrote:
> On 02/03/2017 10:36, James Hogan wrote:
> >  - KVM_VM_MIPS_DEFAULT =3D 2
> >=20
> >    This will provide the best available KVM implementation (even on
> >    older kernels), preferring hardware assisted virtualization over trap
> >    & emulate. The KVM_CAP_MIPS_VZ capability should always be checked
> >    against known values to determine what type of implementation was
> >    chosen.
> >=20
> > This is designed to allow the desired implementation (T&E vs VZ) to be
> > potentially chosen at runtime rather than being fixed in the kernel
> > configuration.
>=20
> Can the same kernel run on both TE and VZ?  If not, I'm not sure that
> KVM_VM_MIPS_DEFAULT is a good idea.

It can't right now, though with relocation of the kernel now implemented
in MIPS Linux for KASLR, and hopes for a more generic EVA implementation
(which can require the kernel to be linked in a completely different
segment) it isn't completely infeasible.

Currently the two uses of this I've implemented are:

1) QEMU, which I've implemented using the kvm_type machine callback.
This allows the KVM type to be specified with e.g.
  "-machine malta,accel=3Dkvm,kvm-type=3DTE"
Otherwise it defaults to using KVM_VM_MIPS_DEFAULT.

When you try and load a kernel (which happens after kvm_init() has
already passed the kvm type into KVM_CREATE_VM) it will check that it
supports the current kernel type.

2) My kvm test application, which uses KVM_VM_MIPS_DEFAULT by default
and hackily maps itself into the guest physical address space to run C
code test cases.

Does that justification sound reasonable?

Cheers
James

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYuARkAAoJEGwLaZPeOHZ6ZV4QAJgv+ixjGxsQTcr4COdm+fJd
cfj2OOZvccHVpT2ooAyImFlKH2wyR0Y3lnD6nj5OsoVQ1KC+vHtEXLNzcffm5+5V
J9DCFUQzNvrBuvkUzxug1IkPmXQdnCn+jKeIKH+6e+WTm+Zk8nSSM9mXIGbWWP2v
4z/cXVyhfuXR+ToLjrO2xPfcbx8h2rherRjKpuavFwf2ZgFGZB9XTbevDRMrn6Zl
lIv+y1WsrqDxHtWmFS/VeU7FW0oE2qv9qU1cyEbr2kl49TOYT4pkHNF4ikZiFAv5
ZtSBOcxZemgAbZ1TsMOF1OwT9eLb8ujcaMQMM6S3dc6aQo7jjLb5JTNNmE7WwdaK
6XbmcXZ+wJYTqQU9YlBvr5G+wXnxBkINytZcQQbWvkBw4MH2ncqrEMAf5tqtXf0z
vwqdMS6S0MtbIfmxsnTzZ3J6iM1P3BhpOuMaN/mTRfDgg8NGvrkbFkksP6VxkJES
SW2OpBUDRl7qgpi3REZJhBTba2Y3k8htA0TCyGjHqgkinxGdRyKwxU+/Pe7IcFT5
/N+yLbvxsZCBAkj4nKNCseixUt5qr2Rtnpoe+tFbyBz1REPM6scTsDfzmuQkcIS1
xcOKObZD8mImgYaYUeKnqQPgEl+qS52+jH8vqkvk9kp+9ASUkJ1wr/6JMP34hHHd
uC3N+isYMXXKFlLS8Oe2
=hH9/
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
