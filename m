Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2016 18:40:54 +0100 (CET)
Received: from chaos.universe-factory.net ([37.72.148.22]:38627 "EHLO
        chaos.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008216AbcCWRkxk19oV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2016 18:40:53 +0100
Received: from [IPv6:2a01:170:1112:0:3c3b:fe96:1a5b:510f] (unknown [IPv6:2a01:170:1112:0:3c3b:fe96:1a5b:510f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by chaos.universe-factory.net (Postfix) with ESMTPSA id EF530183584;
        Wed, 23 Mar 2016 18:40:52 +0100 (CET)
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
To:     Peter Hurley <peter@hurleysoftware.com>
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
 <56F16708.4020109@hurleysoftware.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <56F2D523.6000405@universe-factory.net>
Date:   Wed, 23 Mar 2016 18:40:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <56F16708.4020109@hurleysoftware.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6GnP9oGHJtpEQjK3MvkFs1DbxNJgxmulJ"
Return-Path: <mschiffer@universe-factory.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52687
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
--6GnP9oGHJtpEQjK3MvkFs1DbxNJgxmulJ
Content-Type: multipart/mixed; boundary="0PMULBeX4VHQGssvpmuonTxpJW6nHkDtM"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
 jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <56F2D523.6000405@universe-factory.net>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
 <56F16708.4020109@hurleysoftware.com>
In-Reply-To: <56F16708.4020109@hurleysoftware.com>

--0PMULBeX4VHQGssvpmuonTxpJW6nHkDtM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2016 04:38 PM, Peter Hurley wrote:
> On 03/22/2016 06:07 AM, Matthias Schiffer wrote:
>> I've tried your patch and I can't reproduce the issue anymore with it;=
 I
>> have no idea if this actually has to do something with the issue, or t=
he
>> change of the code path just hid the bug again.
>>
>> Regarding your other mail: with "small change", I was not talking abou=
t
>> adding an additional printk; as mentioned, even changing the numbers i=
n
>> UTS_VERSION can hide the issue. I diffed a working and a broken kernel=

>> image, and the UTS_VERSION is really the only difference. I have no id=
ea
>> how to explain this.
>=20
> If _any_ change may hide the problem, that will make it impossible
> to determine if any attempted fix actually works, regardless of what
> debugging method you use.
>=20
> FWIW, you could still use the boot console to debug the problem by
> disabling the regular command-line console.
>=20
> Regards,
> Peter Hurley

Hi,
it seems Peter was on the right track. With some help from Ralf, I was ab=
le
to narrow down the issue a bit, and I'm fairly sure the hang happens
somewhere in autoconfig().

autoconfig_16550a() is doing all kinds of weird checks to detect differen=
t
hardware by writing a lot of register values which are documented as
reserved in the AR7242 datasheet (there's a leaked version going around
that can be easily googled...), no idea if any of those are problematic.
Just setting UPF_FIXED_TYPE as suggested by Peter would avoid that code
altogether.

That being said, I found another minimal change that seems to fix the
issue: prom_putchar_ar71xx() in arch/mips/ath79/early_printk.c only waits=

for UART_LSR_THRE, while serial_putc() in
drivers/tty/serial/8250/8250_early.c waits for (UART_LSR_TEMT |
UART_LSR_THRE). Adjusting arch/mips/ath79/early_printk.c in the same way
makes the hangs go away. Maybe the AR7242 doesn't like its serial config
registers being poked while there's still something in the FIFO? Waiting
for UART_LSR_TEMT seems like a good idea anyways to ensure that all
characters have been printed before autoconfig() starts taking things
apart. (Why do these two versions of essentially the same code exist anyw=
ays?)

Regards,
Matthias


--0PMULBeX4VHQGssvpmuonTxpJW6nHkDtM--

--6GnP9oGHJtpEQjK3MvkFs1DbxNJgxmulJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW8tUkAAoJEBbvP2TLIB2c4kQQAKpwvb+WuT6iWF3cii/Wavp2
rkVSc/Zu6D5A5e+yYbXaJa4tPOni1R5RAmlRwi9XV6LWXPSq+PElcSL5DwO8b9zs
Av8vuWOtB0RCav0LBsjzLcXwFTGf0eqFiL+2s3m4RTu5/0B6teFhKyEPLSJM2SHw
/gsh491vmtpR4hSeoUYjaWruRk5hewyIkwbNln6nVJt2PDXYZe83xv0/L2FMAdnw
SIi8SFl6oSy3JajgrLjomLVLCcPBqa+W15RyUmN8rYi6SmfOhaM5FrE1+9qGOf8D
S2wQbt6nOtURraTFaRXot933kEjUzTvkwnq2mL1c809Nd/TvfpmsXb4ES9gzxVkV
qi4wIbMpawPvHJhJxM2rQCygSbY8J/gZke3AtyJMFVChGs0E2JO6OXvErE4nibF4
c65Vh+sAyDFUUQVP0B6i+YvDKYQPYCJhjdpPjn+F02O8Y24NRPme5VEp8Cim+ulN
GIkYUGDCIk5FVj0urabwmfRRIWqw0y3xrOluLuatMu1UeJvTZjkuaZdkKRcpa5jr
LLGh6XJT6M66gMuzWZOphVpFdUoSlTHJjqCqPxm/9EUtU3U48DzD40v2qHhwtyR2
tJtPub076DKmrX6BjwvjaY1aTQrb+v+8x5/l1Ru09utKekdrw64pfSXnzek+Q+Rz
QQLSo6PlLZ37UINIxvo/
=FjKH
-----END PGP SIGNATURE-----

--6GnP9oGHJtpEQjK3MvkFs1DbxNJgxmulJ--
