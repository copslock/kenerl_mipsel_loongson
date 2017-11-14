Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 12:02:54 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:34081 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdKNLCrCxlWo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 12:02:47 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 11:02:14 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 14 Nov
 2017 03:02:13 -0800
Date:   Tue, 14 Nov 2017 11:02:11 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     <linux-mips@linux-mips.org>, <linux-serial@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [PATCH RFC 3/3] MIPS: AR7: ensure the port type's FCR value is
 used
Message-ID: <20171114110211.GA5823@jhogan-linux.mipstec.com>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
 <20171029152721.6770-4-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20171029152721.6770-4-jonas.gorski@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510657334-637137-28373-261011-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186911
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2017 at 04:27:21PM +0100, Jonas Gorski wrote:
> Since commit aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt
> trigger I/F of FIFO buffers"), the port's default FCR value isn't used
> in serial8250_do_set_termios anymore, but copied over once in
> serial8250_config_port and then modified as needed.
>=20
> Unfortunately, serial8250_config_port will never be called if the port
> is shared between kernel and userspace, and the port's flag doesn't have
> UPF_BOOT_AUTOCONF, which would trigger a serial8250_config_port as well.
>=20
> This causes garbled output from userspace:
>=20
> [    5.220000] random: procd urandom read with 49 bits of entropy availab=
le
> ers
>    [kee
>=20
> Fix this by forcing it to be configured on boot, resulting in the
> expected output:
>=20
> [    5.250000] random: procd urandom read with 50 bits of entropy availab=
le
> Press the [f] key and hit [enter] to enter failsafe mode
> Press the [1], [2], [3] or [4] key and hit [enter] to select the debug le=
vel
>=20
> Fixes: aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt trigger =
I/F of FIFO buffers")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
> I'm not sure if this is just AR7's issue, or if this points to a general
> issue for UARTs used as kernel console and login console with the "fixed"
> commit.

Thanks. Given nobody seems to have objected, I've applied to my
mips-fixes branch, with stable tag for 3.17+.

Cheers
James

>=20
>  arch/mips/ar7/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
> index 4674f1efbe7a..e1675c25d5d4 100644
> --- a/arch/mips/ar7/platform.c
> +++ b/arch/mips/ar7/platform.c
> @@ -575,7 +575,7 @@ static int __init ar7_register_uarts(void)
>  	uart_port.type		=3D PORT_AR7;
>  	uart_port.uartclk	=3D clk_get_rate(bus_clk) / 2;
>  	uart_port.iotype	=3D UPIO_MEM32;
> -	uart_port.flags		=3D UPF_FIXED_TYPE;
> +	uart_port.flags		=3D UPF_FIXED_TYPE | UPF_BOOT_AUTOCONF;
>  	uart_port.regshift	=3D 2;
> =20
>  	uart_port.line		=3D 0;
> --=20
> 2.13.2
>=20
>=20

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloKzTMACgkQbAtpk944
dnqUFQ/+MP4o3tfIW8phx025jDOCj/rS4EeehRPU7mIqghWK6z3MGxPBVTTX+l3H
nihHRg2bKM1SwLNoi1ScKAsQRenc15Q3DYT8bDsxivNIR1x4eapZLliDF4fT5gBv
7PqfdVSxKxVkrUAoGjoL3x2VNrUz3RYtg/ugDhmQJch4ism5M/Ni1n7s3ZhXxm0K
Yjvvd6+OFjZyZ+adpjILNoTmJs4Vze8csT2yLlPpWMAyOhlYb7gxb52/yVtOgh0H
L/kewcTin/hb/CDwoas2ZGav/eG6MQnWY3SaKleWPdoWUFKhXheLI7jzWwCaqPl1
TRzSrSs4/nPRIGg4HLpMCBkYGbZAHDCQQuH861/O3y1FqUhptoZ1wkw3H/AoRdws
3AwMXNaWYB6/vrR1eQg2Jn9tWWGHMiUUOPEMF/bqTLpQswJVKvqi/cIxsFoNHm3p
AHElatCRUkA95jFZ8Asui4ZB2X5zNuI9yCN5HO5+nCa1bHoMAX8tSGZHhd2dilQ4
XxyCSx7ZhRJHSio5acpPEjnHRAB0PDCbhg+2hEP9yTVm/q5k0zRfrPLf4iuXCIxt
5HTZoE1PG/+mfs5y8SxYhG6PFMdRxN9HnOfvrwFIxNNKfYAzTFXW8rm0Go6KhgAa
6eM96GzjzpBFlPFWrrG0MjNzjLwNao2VPmJrWUiC48tPdSJmolw=
=2C6E
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
