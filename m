Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 21:41:41 +0100 (CET)
Received: from comal.ext.ti.com ([198.47.26.152]:52679 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833470Ab3A1UljojkCQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 21:41:39 +0100
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
        by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id r0SKfZGq004639;
        Mon, 28 Jan 2013 14:41:36 -0600
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
        by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id r0SKfXgE022872;
        Mon, 28 Jan 2013 14:41:33 -0600
Received: from dlelxv22.itg.ti.com (172.17.1.197) by dfle73.ent.ti.com
 (128.247.5.110) with Microsoft SMTP Server id 14.1.323.3; Mon, 28 Jan 2013
 14:41:33 -0600
Received: from localhost (h78-16.vpn.ti.com [172.24.78.16])     by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id r0SKfW7I015527;      Mon, 28 Jan
 2013 14:41:33 -0600
Date:   Mon, 28 Jan 2013 22:41:14 +0200
From:   Felipe Balbi <balbi@ti.com>
To:     Florian Fainelli <florian@openwrt.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <jogo@openwrt.org>, <mbizon@freebox.fr>, <cenerkee@gmail.com>,
        <linux-usb@vger.kernel.org>, <stern@rowland.harvard.edu>,
        <gregkh@linuxfoundation.org>, <blogic@openwrt.org>
Subject: Re: [PATCH 03/13] MIPS: BCM63XX: move code touching the USB private
 register
Message-ID: <20130128204114.GA5509@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
 <1359399991-2236-4-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <1359399991-2236-4-git-send-email-florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: balbi@ti.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 28, 2013 at 08:06:21PM +0100, Florian Fainelli wrote:
> diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63x=
x_udc.c
> index ad17533..af450c4 100644
> --- a/drivers/usb/gadget/bcm63xx_udc.c
> +++ b/drivers/usb/gadget/bcm63xx_udc.c
> @@ -41,6 +41,7 @@
>  #include <bcm63xx_dev_usb_usbd.h>
>  #include <bcm63xx_io.h>
>  #include <bcm63xx_regs.h>
> +#include <bcm63xx_usb_priv.h>

actually, I want to see this arch dependency vanish. The whole
"phy_mode" stuff should be a PHY driver, care to implement this properly
using the PHY layer ?

--=20
balbi

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBuJqAAoJEIaOsuA1yqREZqIP/2R/Qe91Wq5F2fujZBPvEmXK
+8WfYf+q50nC/nD7KTUJCr3YvhxDT4UnseHXpEsQaCv7DMdJdGwpmtg3GJaSzRki
HDLf5XbDdolqEIOt/GLVZfyF6DaPCB8LjLzV5AtaRukPcDVRP2H7V9VsvMBPuyK2
+aA03RYnfIIpE06l+3YV5UPbi0bbUITLq3w9wH0V2jtLrgFqsstDL/eQEhyEsLyY
qPPlTLfjxVDQF+4I/prsVYTi6qaubss6txjE/0i23u3vw1AjfK4nQ+sxOTDh0iVe
l7bDJDQSAEUHG3nSoRBZekC3AWr9f8iHZfM1qGImFxe2y2pC96JolvQtNwz9ogmO
m1ujfP19aYmDmxmOjY3dr7OgUftWPwKUmJlHMgw61ZETaEp8pgLN+Qk+pP5Btld+
UO6uMBS9SPOc1lRtXhPM81JtzoRye2oSNYceriHT/U/6eNAcDbthyUp1YF94jzan
NhkcFd4aCIdSQd7GiZVoEDLRPKjCcgHfC7nZ8dQHlv12EFYSnD/BmEmz5iw0S+5H
xupxFdGlVY5lcL144R7qzKnC01HUIKBIattVTc0pZp/Uqj9VbbcpIplKWE6dTqau
OQIqToM++5Mcn3LOkmRh046iNV+cs8VJcqpCE0f1+ChUUSCLgWRNZyvqZkR7bTVM
v/fzDm+1RdD47fecNq/F
=c77T
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
