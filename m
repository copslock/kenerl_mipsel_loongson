Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 12:04:55 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22406 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008840AbbCPLEtdzvBQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 12:04:49 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BFB6F41F8DDE;
        Mon, 16 Mar 2015 11:04:44 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 16 Mar 2015 11:04:44 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 16 Mar 2015 11:04:44 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 06270DD2CCD78;
        Mon, 16 Mar 2015 11:04:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 16 Mar 2015 11:04:44 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 16 Mar
 2015 11:04:43 +0000
Message-ID: <5506B8CB.7000903@imgtec.com>
Date:   Mon, 16 Mar 2015 11:04:43 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>
Subject: Re: [PATCH V2 4/5] MIPS: Add support for the IMG Pistachio SoC
References: <1426287249-27185-1-git-send-email-abrestic@chromium.org> <1426287249-27185-5-git-send-email-abrestic@chromium.org>
In-Reply-To: <1426287249-27185-5-git-send-email-abrestic@chromium.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="5jx136UfxsMgQtpB8nEW0obGTejM1jaxT"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46394
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

--5jx136UfxsMgQtpB8nEW0obGTejM1jaxT
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 13/03/15 22:54, Andrew Bresticker wrote:
> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> index e5fc463..2298baa 100644
> --- a/arch/mips/Kbuild.platforms
> +++ b/arch/mips/Kbuild.platforms
> @@ -23,6 +23,7 @@ platforms +=3D netlogic
>  platforms +=3D paravirt
>  platforms +=3D pmcs-msp71xx
>  platforms +=3D pnx833x
> +platforms +=3D pistachio

Please keep this sorted alphabetically.

>  platforms +=3D ralink
>  platforms +=3D rb532
>  platforms +=3D sgi-ip22

=2E..

> diff --git a/arch/mips/include/asm/mach-pistachio/gpio.h b/arch/mips/in=
clude/asm/mach-pistachio/gpio.h
> new file mode 100644
> index 0000000..6c1649c
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-pistachio/gpio.h
> @@ -0,0 +1,21 @@
> +/*
> + * Pistachio IRQ setup
> + *
> + * Copyright (C) 2014 Google, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_MACH_PISTACHIO_GPIO_H
> +#define __ASM_MACH_PISTACHIO_GPIO_H
> +
> +#include <asm-generic/gpio.h>
> +
> +#define gpio_get_value	__gpio_get_value
> +#define gpio_set_value	__gpio_set_value
> +#define gpio_cansleep	__gpio_cansleep
> +#define gpio_to_irq	__gpio_to_irq

Makes me wish ARCH_HAVE_CUSTOM_GPIO_H could be selected on a
per-platform basis :P. Never mind.

> +
> +#endif /* __ASM_MACH_PISTACHIO_GPIO_H */

=2E..

> diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
> new file mode 100644
> index 0000000..6b297d5
> --- /dev/null
> +++ b/arch/mips/pistachio/init.c
> @@ -0,0 +1,131 @@

=2E..

> +static int __init plat_of_setup(void)
> +{
> +	if (!of_have_populated_dt())
> +		panic("Device tree not present");
> +
> +	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL=
))
> +		panic("Failed to populate DT\n");

No need for newline in panic message.

> +
> +	return 0;
> +}
> +arch_initcall(plat_of_setup);

=2E..

Otherwise from what I can tell this patch looks good to me (though I
probably wouldn't know if something important was missing from it).

Thanks!
James


--5jx136UfxsMgQtpB8nEW0obGTejM1jaxT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVBrjLAAoJEGwLaZPeOHZ6MpwP/0wZglHXGQU6krSj1yQV377M
T26aRS1mceW8m6LJ00vNKv0cavWpAFftBN3bwd25FF1NBp/+m9gBF4oVt6+oPCSu
EJ7zSFs4NT+C3Vi9OvDI4rpEBmBbVOVKBVETnMPMc5WXJUhEK+tclR2Qw42xIHYo
GJ8dKuQWoop9itAw/GXHVtASfDBvQaW+6BKQvqV/01FNPJLfHX23oIaGZ7MMpBvG
bvrFNmPn2mS6I46/mwWf/SDOvm763/ERKNigcd5uaNRovOsxSnxeqfbiTpkRXDTW
SgvaY+ttxTVSNnsmGITGyUQxmo8OSAWDn5KluMSNgmxYuRxFSA6EaS+g2FvW8I/T
SOpBdp7KIweLFDgUe2LWlIO66tfL77LkNJfHBA5eIKEp4jS8nln3a9BHLaAkhw6T
zenIHg2bCs3JBf4XYW9K7l1Zj5Qtf0/H52zt7/6obDgr/2aDJKR+QwCvWwpQrW9f
qR3BvauwgzLPRBGm6+/pEDrKHwBvrB1NrWR7xS/Cz5nfov0FAc86R1DM69hrpa1J
n19E+J5nGhuh9DzRII4qnvrMgIhnGIZAEed/rUG714uBBlLDeqOFwhRvHiu2tPK7
i/ER1cuWTNbEX0xICbb3OtATkB0OatSTWdxvpbMFufZ228PcjaEIkMY35PQB8b3D
MXxWEBa8JjBd3rPvRd6t
=DsrG
-----END PGP SIGNATURE-----

--5jx136UfxsMgQtpB8nEW0obGTejM1jaxT--
