Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2016 14:07:56 +0100 (CET)
Received: from chaos.universe-factory.net ([37.72.148.22]:49243 "EHLO
        chaos.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007863AbcCVNHzJobxr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Mar 2016 14:07:55 +0100
Received: from [IPv6:2001:6f8:1d26:0:70b0:be83:fe4e:c804] (unknown [IPv6:2001:6f8:1d26:0:70b0:be83:fe4e:c804])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by chaos.universe-factory.net (Postfix) with ESMTPSA id 8257A183571;
        Tue, 22 Mar 2016 14:07:53 +0100 (CET)
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
To:     Peter Hurley <peter@hurleysoftware.com>
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <56F143A8.6020601@universe-factory.net>
Date:   Tue, 22 Mar 2016 14:07:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <56F0B189.2080206@hurleysoftware.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Xr0k8XIJeaE77AinBk3lMgl9MK6o9MHeJ"
Return-Path: <mschiffer@universe-factory.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschiffer@universe-factory.net
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xr0k8XIJeaE77AinBk3lMgl9MK6o9MHeJ
Content-Type: multipart/mixed; boundary="mPUhDONuxW5gQ9BCwHDlwHdIqeA8JGnnl"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
 jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <56F143A8.6020601@universe-factory.net>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com>
In-Reply-To: <56F0B189.2080206@hurleysoftware.com>

--mPUhDONuxW5gQ9BCwHDlwHdIqeA8JGnnl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> My theory is the following:
>>
>> As soon as ttyS0 is detected and installed as the console, there are t=
wo
>> console drivers active on the serial port at the same time: early0 and=

>> ttyS0. I suspect that the hang occurs when the primitive early0
>> implementation prom_putchar_ar71xx waits indefinitely on THRE, but the=
 real
>> driver has just reset the serial controller in a way that makes THRE n=
ever
>> come.
>=20
> Doubtful.
>=20
> console writes are performed with ints disabled, as is the 8250 driver'=
s
> autoconfig probing. Since this is a UP platform, as long as you're not
> using the DEBUG_AUTOCONF switch in the 8250 driver, I don't think there=
's
> a way for the boot console to be outputting while the 8250 driver is
> configuring.

I see.

>=20
>> When the boot is successful, I also sometimes see just garbage
>> instead of the message "serial8250.0: ttyS0 at MMIO 0x18020000...", wh=
ich
>> supports my idea that the kernel is trying to use the serial console w=
hile
>> it is not correctly setup.
>>

>=20
> I wonder if autoconfig probing (that's what discovers the uart port typ=
e)
> is broken.
>=20
> You could test this hypothesis by setting the port type directly and
> set UPF_FIXED_TYPE; ie., in arch/mips/ath79/dev-common.c
>=20
> diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.=
c
> index 516225d..3814a42 100644
> --- a/arch/mips/ath79/dev-common.c
> +++ b/arch/mips/ath79/dev-common.c
> @@ -36,7 +36,8 @@ static struct plat_serial8250_port ath79_uart_data[] =
=3D {
>  	{
>  		.mapbase	=3D AR71XX_UART_BASE,
>  		.irq		=3D ATH79_MISC_IRQ(3),
> -		.flags		=3D AR71XX_UART_FLAGS,
> +		.flags		=3D AR71XX_UART_FLAGS | UPF_FIXED_TYPE,
> +		.type		=3D PORT_16550A,
>  		.iotype		=3D UPIO_MEM32,
>  		.regshift	=3D 2,
>  	}, {
>=20
>=20
> Regards,
> Peter Hurley

I've tried your patch and I can't reproduce the issue anymore with it; I
have no idea if this actually has to do something with the issue, or the
change of the code path just hid the bug again.

Regarding your other mail: with "small change", I was not talking about
adding an additional printk; as mentioned, even changing the numbers in
UTS_VERSION can hide the issue. I diffed a working and a broken kernel
image, and the UTS_VERSION is really the only difference. I have no idea
how to explain this. (OpenWrt uses an LZMA-compressed kernel image, so
after compression, the differences are much greater; but how these
differences would affect the kernel after decompression eludes me)

I'll continue searching for a board with accessible JTAG which exhibits
this issue. Given the heisenbuggy nature of the issue, getting to the roo=
t
cause is probably impossible without JTAG unless someone has an obvious
explanation...

Thanks,
Matthias


--mPUhDONuxW5gQ9BCwHDlwHdIqeA8JGnnl--

--Xr0k8XIJeaE77AinBk3lMgl9MK6o9MHeJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW8UOoAAoJEBbvP2TLIB2ch1AQANhdVOND3h3/lU/PSmqEPrbl
gI4QS+AS8w4p8falhkt9bsfCwTB+Mra6wH0oFvEiGjS/YASFLRzBwN5evuvI4K11
5sZQSlJcRwq6HH96bvxXdmxYehgme9FKrdZ2OIGnL6HNb/3mVZ+VyznsIMA0qz+0
R1voTtMuzFNQj1u0QOQiIAePcKQ3/MpXinxBaEbd5g+5D92SC7wmGY75mF6TznvJ
K2CNk3XLoICIi3ArpScGJC+awOFGe2GKcbprP3M24jUfzr11Qe0rB6JTzgS4HAwh
5mq1v1MQ01CFnNlUMemk8DZWEyPqvwu3l95sCt/wPa/ile0hBg/99I7fNZENF4Tr
KMK+KzZOsjez9eGKDuEIDRuN8Qud8uX/m1vhrlsViYoO0I9H4zt7pd+1+dGGCOGw
8XsKscuxKSyLfvxR4NtX6S72+MvqzXZCQxGBL86clN7njL5Un4fFEYKclB5ABaI+
zxX3qIhEazNmNZaOSiosWnyJ149cILlX3UxUPWccy0AjcGpwuWvEDXda6x8APUan
Tmb2PHLma1OGYpQJKi9Ggx7XNhbcjhzHT1kaPYSqk9NPljYPu/Lej8yhGMKrh5Y1
rhLjoIgjyE0XEP1Gk4zBDlRP1FSNk+HQH8UK7KwWXUshyBZjPWsHnqBAlL0tlCgy
qMibQUy7M5YH8odie3bz
=KDjV
-----END PGP SIGNATURE-----

--Xr0k8XIJeaE77AinBk3lMgl9MK6o9MHeJ--
