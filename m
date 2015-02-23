Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2015 15:07:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25866 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006947AbbBWOHYMW0w0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Feb 2015 15:07:24 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id AB04B41F8D20;
        Mon, 23 Feb 2015 14:07:18 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 23 Feb 2015 14:07:18 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 23 Feb 2015 14:07:18 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0FC1391A59A18;
        Mon, 23 Feb 2015 14:07:16 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 23 Feb 2015 14:07:18 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 23 Feb
 2015 14:07:17 +0000
Date:   Mon, 23 Feb 2015 14:07:17 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Tapasweni Pathak <tapaswenipathak@gmail.com>
CC:     <gleb@kernel.org>, <pbonzini@redhat.com>, <ralf@linux-mips.org>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <julia.lawall@lip6.fr>
Subject: Re: [PATCH] arch: mips: kvm: Enable after disabling interrupt
Message-ID: <20150223140717.GI9453@jhogan-linux.le.imgtec.org>
References: <20150222161821.GA6980@kt-Inspiron-3542>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLfjTIIQuAzj8yil"
Content-Disposition: inline
In-Reply-To: <20150222161821.GA6980@kt-Inspiron-3542>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45890
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

--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2015 at 09:48:21PM +0530, Tapasweni Pathak wrote:
> Enable disabled interrupt, on unsuccessful operation.
>=20
> Found by Coccinelle.
>=20
> Signed-off-by: Tapasweni Pathak <tapaswenipathak@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/kvm/tlb.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
> index bbcd822..b6beb0e 100644
> --- a/arch/mips/kvm/tlb.c
> +++ b/arch/mips/kvm/tlb.c
> @@ -216,6 +216,7 @@ int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, un=
signed long entryhi,
>  	if (idx > current_cpu_data.tlbsize) {
>  		kvm_err("%s: Invalid Index: %d\n", __func__, idx);
>  		kvm_mips_dump_host_tlbs();
> +		local_irq_restore(flags);
>  		return -1;
>  	}
>=20
> --
> 1.7.9.5
>=20
>=20

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU6zQVAAoJEGwLaZPeOHZ6lgoP/j25UWrtzVRfyl/43bLEPOj5
GFSXtHbAQMYakZ5EPVUF1fpRxGGpMqgyvzAR0WxesaBfkj2IpJC2IHXpF3BrNqOf
yGydDqlJXaBbmTN4UMeMnVZCVUAc8tPINHVCDyQOm3sA4mnioPLqYzud5R+ssVEu
14spDnK/tLXUUrV+cmVIjcX58oCb57UOor/jhHcVQxU9r/wUHG+1fiM5BtdE2gD+
7VrGY6LnJZ/mIYqYnFQQPHZPVCeUztpFrusxRTMhGyN3oTLMNdckKQfTCLEg9KMT
0B/cWz+9FD8U0ANrG2l0QjwxC9Z7FSOcryiooFVhCn1c1lmwKteRSkaHvYCj7nqM
RGWF9k7M3saijJ5Bp7u0grjrFgMzS50pk251hT7/fGrta5bDd7NZMILrt34JIfJN
m3zxWACF1kYWqxqIfbPxBInVYMKoNDq92DZ71wVcM8fByj8mVwf8nrYS2WSW7l+C
9QVYoBPy9MQMn5B3UPjJpEKaxJ2pR76IrbJVrxpPLuUxJtuANHdL9s7PyZientnA
W77h4gmK8O9FllDVlxfiJklVZpYCpkx6b1rdDhyIPuONFTI5YNbwwlCmhFfXESvj
kAYUV608oBfS877GIP61a8EK8KzTCoL3BRIThimGIxkPR/5zbG8tw1WZHQ8pACSk
kE0DL1SB7HnW8ddj8FJN
=ejr/
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--
