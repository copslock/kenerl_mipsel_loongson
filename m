Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 17:24:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38262 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991759AbcJQPYLIya4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 17:24:11 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9239B41F8EC0;
        Mon, 17 Oct 2016 16:23:41 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 17 Oct 2016 16:23:41 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 17 Oct 2016 16:23:41 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id E9B28494D69F2;
        Mon, 17 Oct 2016 16:24:01 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 16:24:05 +0100
Received: from np-p-burton.localnet (10.100.200.11) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct
 2016 16:24:04 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: generic: Fix KASLR for generic kernel.
Date:   Mon, 17 Oct 2016 16:24:04 +0100
Message-ID: <10204742.RjzdRO4fSK@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.7.6-1-ARCH; KDE/5.27.0; x86_64; ; )
In-Reply-To: <1476698709-6771-1-git-send-email-matt.redfearn@imgtec.com>
References: <1476698709-6771-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2506538.jQ0TzL8J65";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.11]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55462
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

--nextPart2506538.jQ0TzL8J65
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 17 October 2016 11:05:09 BST Matt Redfearn wrote:
> The KASLR code requires that the plat_get_fdt() function return the
> address of the device tree, and it must be available early in the boot,
> before prom_init() is called. Move the code determining the address of
> the device tree into plat_get_fdt, and call that from prom_init().
> 
> The fdt pointer will be set up by plat_get_fdt() called from
> relocate_kernel initially and once the relocated kernel has started,
> prom_init() will use it again to determine the address in the relocated
> image.
> 
> Fixes: eed0eabd12ef
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
> 
>  arch/mips/generic/init.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
> index 0ea73e845440..d493ccbf274a 100644
> --- a/arch/mips/generic/init.c
> +++ b/arch/mips/generic/init.c
> @@ -30,9 +30,19 @@ static __initdata const void *mach_match_data;
> 
>  void __init prom_init(void)
>  {
> +	plat_get_fdt();
> +	BUG_ON(!fdt);
> +}
> +
> +void __init *plat_get_fdt(void)
> +{
>  	const struct mips_machine *check_mach;
>  	const struct of_device_id *match;
> 
> +	if (fdt)
> +		/* Already set up */
> +		return (void *)fdt;
> +
>  	if ((fw_arg0 == -2) && !fdt_check_header((void *)fw_arg1)) {
>  		/*
>  		 * We booted using the UHI boot protocol, so we have been
> @@ -75,12 +85,6 @@ void __init prom_init(void)
>  		/* Retrieve the machine's FDT */
>  		fdt = mach->fdt;
>  	}
> -
> -	BUG_ON(!fdt);
> -}
> -
> -void __init *plat_get_fdt(void)
> -{
>  	return (void *)fdt;
>  }

Hi Matt,

Apart from the Fixes tag niggle James mentioned (which checkpatch ought to 
pick up on):

    Reviewed-by: Paul Burton <paul.burton@imgtec.com>

Thanks,
    Paul
--nextPart2506538.jQ0TzL8J65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYBO0UAAoJEIIg2fppPBxlh9MP/j6TJ53Mc/QXmVElvtccy+8Q
D0XkUwGTix1Vj1xHdG6zvjnz60cyzjtdDqBdVIyEQ3gnM7pIyWm08AWdLG0260lX
tg1DQfbE95Q2Lk/iChts/fMoHnnZEwaVBTWWK2ebr0X6p8fIK0t3ia5SIpW/9EZJ
39kV2LZ2Tyae+q/gKIMz1cPc4Nx2ZjyGC0m9bqFrYGHCdwIei/Eu38sq7e2oiYzv
MSppemg2TNuZe+7nd7G2+rnMMvlbklkffSEKvN9SJwGk5oSr5qUNPqU4jhP7qx2O
QFn4oQJYC75ykA5DXjw8bMyC0zzaTeFg2apL0/YzsmYBYGXW0pk+hgAfySDcM00t
/vAEIiEWR6TZ5bcumdfT+YEks7IOW07pdPzj2U+wt53SMB50CW40abRLOPhUbGLK
lu4gpBMrpEV+eA9dibRyyiR1W/nPu0e8ZS1iQjFquI8TU6J2tyqO+Xd453h5/SLy
rQ5j67rU745lGqAh530nhRcv38h91Q25iV3/faODt5+eM8w/oL8o/3fSxGLEuDu8
fbvs/yAS9gkUQGk00q7OoTztUczWwFRcccPLBWJQdP50irr42qtuC4WclAWtnUt6
vP4sKcwQaD+9FQKkam+SwFJXfc71jMSYXEMsMauVOfgsrhfrwPlZy2dpE7sq+14n
OdKRnrwNf/nbYPHwPDK6
=EzB6
-----END PGP SIGNATURE-----

--nextPart2506538.jQ0TzL8J65--
