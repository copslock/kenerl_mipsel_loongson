Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 12:15:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21033 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009512AbbGWKPHB6tol (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jul 2015 12:15:07 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9ED1841F8D35;
        Thu, 23 Jul 2015 11:15:01 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 23 Jul 2015 11:15:01 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 23 Jul 2015 11:15:01 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1E52BC755EE31;
        Thu, 23 Jul 2015 11:14:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 23 Jul 2015 11:15:01 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 23 Jul
 2015 11:15:00 +0100
Message-ID: <55B0BEB3.7010502@imgtec.com>
Date:   Thu, 23 Jul 2015 11:15:15 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "David Daney" <ddaney@caviumnetworks.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>
Subject: Re: [PATCH 1/2] MIPS: Handle page faults of executable but unreadable
 pages correctly.
References: <cover.1437644062.git.ralf@linux-mips.org> <b02d2b2d33026271c663207dc68bfa0531b16251.1437644062.git.ralf@linux-mips.org>
In-Reply-To: <b02d2b2d33026271c663207dc68bfa0531b16251.1437644062.git.ralf@linux-mips.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="VJFCq1wT3tjxMxxtlpwJ6IpJCJJ3x4TIJ"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e4aa9c8
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48400
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

--VJFCq1wT3tjxMxxtlpwJ6IpJCJJ3x4TIJ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23/07/15 10:10, Ralf Baechle wrote:
> Without this we end taking execeptions in an endless loop hanging the
> thread.

A little more explanation would be nice. Under what situations does this
occur? Does this mean any VM_EXEC and !VM_READ page can't actually be
faulted in without it being treated as an RI violation, or does it only
affect when read from kernel emulation code?

Cheers
James

>=20
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  arch/mips/mm/fault.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
> index 36c0f26..852a41c 100644
> --- a/arch/mips/mm/fault.c
> +++ b/arch/mips/mm/fault.c
> @@ -133,7 +133,8 @@ good_area:
>  #endif
>  				goto bad_area;
>  			}
> -			if (!(vma->vm_flags & VM_READ)) {
> +			if (!(vma->vm_flags & VM_READ) &&
> +			    exception_epc(regs) !=3D address) {
>  #if 0
>  				pr_notice("Cpu%d[%s:%d:%0*lx:%ld:%0*lx] RI violation\n",
>  					  raw_smp_processor_id(),
>=20


--VJFCq1wT3tjxMxxtlpwJ6IpJCJJ3x4TIJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVsL6zAAoJEGwLaZPeOHZ6CPYQAI8sm6y851iBka20iNkjxPMo
wqPJaANo9LQtDhLUoefsVwOJD5mhkPuFeKHp9Qk7z8GGdo+zr6UkWWesuzVDYaMk
23BgeBw9gkDHraD9sb8tSkCbgFcubW2KJ58asViZw74ZP9v7gBEZIueWu3XoteGn
6SIuC9mZRL3yOxh9QUYTK15XishTPa1CZ5/3hQXB3yBIOybL+9deZYQo6DRhLziJ
g9RdPY+SWAHWDuS1fdnkjcRIczsy9G/KJ6xHrIQfl5PKYIu4nOXTW2vN4jNRN/nx
iynu8BGY42/N9woJFhYsfW1Vu8oHA0JJtLyBc0qFtQt62liFaz8Jd32QsjeQz90x
Ddof9kBdxal+1A/XoPifbqeESJROt+hOgJ+wnR2P33ZvV5ZfDkyjoVg9vx8HTQsy
hXnSQQZUedvEdvBmuXJJoAO3/UsPxUYFwWRv596OzDixIu3BwIQi7c2Cm+ordeTY
KpcUUJSZQA1BfQVHEmRLgfNSnyO1jRLziyBkcKm4B6+OPlP5+7ZfPePayD4fpjFj
5n0jjuGivAuzsvRCZsqMZ2+zg1bYHUlbyv80Rp2SPtqneg+eEfa70dUKkXTjxMdC
4Xs1p3CkUfjfAs+dOeLQeQpUk0UuUdVEbSdAYdENMbuvMZMapWVzugDPaVZ5gpo8
sipzepj5vAn0Ucv6PDOQ
=P69W
-----END PGP SIGNATURE-----

--VJFCq1wT3tjxMxxtlpwJ6IpJCJJ3x4TIJ--
