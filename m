Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 21:05:56 +0100 (CET)
Received: from mail-qy0-f202.google.com ([209.85.221.202]:52360 "EHLO
        mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492026Ab0CCUFx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 21:05:53 +0100
Received: by qyk40 with SMTP id 40so1273979qyk.23
        for <linux-mips@linux-mips.org>; Wed, 03 Mar 2010 12:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=l+ZVcVJtJhqi9xfps4F4iDRSC9PCLietqkIEA1oGCyE=;
        b=TiTc6CtzL4fgkVdVKQju1FGBjIiFZUHW9S/jJpjq4uJnOyhyA/c3kqZJaTrMJdF3pc
         nU2JPLe7ngBJcco2yejF9LR0cmshScBT3VeU0yZmKKLN6oKj9hypHEnUYpu6rqIsujSK
         OtcQXeUXwlEbb7Qp+BH9+sN/siIcO3WzhRVNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=TyInW96tBybeizjv6ahcTNUmvKs3UHnn6ZQsH7yrJZBOtWRFapfIqU71DDw4p8kWdE
         qcck1W3p2IS0/dTVvog+hRfdzJGHLC5VYso8L+5hony9wrXAwUuHq3DekWQ7jjaltOwo
         tUTPNKLe2krO5HXlJIUjc8fRRv8MFIuIWenb4=
Received: by 10.224.81.85 with SMTP id w21mr12302qak.129.1267646747080;
        Wed, 03 Mar 2010 12:05:47 -0800 (PST)
Received: from lenovo.localnet (153.44.69-86.rev.gaoland.net [86.69.44.153])
        by mx.google.com with ESMTPS id y67sm632326iby.21.2010.03.03.12.05.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 12:05:44 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     "Dea_RU" <dryukovz@mail.ru>
Subject: Re: TI AR7 7200 - no boot
Date:   Wed, 3 Mar 2010 21:05:29 +0100
User-Agent: KMail/1.12.4 (Linux/2.6.32-trunk-686; KDE/4.3.4; i686; ; )
Cc:     linux-mips@linux-mips.org
References: <27766331.post@talk.nabble.com> <27768844.post@talk.nabble.com> <27772495.post@talk.nabble.com>
In-Reply-To: <27772495.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4853521.4Xh0pBEFZh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201003032105.43176.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--nextPart4853521.4Xh0pBEFZh
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 3 mars 2010 20:20:22, Dea_RU a =C3=A9crit :
> I show this rtunk left 10 day....
>=20
> and patch src 2.6.33 from dir root/trunk/target/linux/ar7/patches-2.6.32

Ok, then why do not you simply use OpenWrt trunk?

>=20
> to day i see :
>=20
> florian: [ar7] add missing patch to arch/mips/kernel/traps.c to allow ar7
>  to setup =E2=80=A6 :confused:
>=20
> ------------------
> for 2.6.33 need this modify ?? or not ?
>=20
> arch/mips/include/asm/page.h
> ---------
> #define UNCAC_ADDR(addr)        ((addr) - PAGE_OFFSET + UNCAC_BASE +
> PHYS_OFFSET)
> #define CAC_ADDR(addr)          ((addr) - UNCAC_BASE + PAGE_OFFSET -
> PHYS_OFFSET)
> ---------

This is not needed.

>=20
>=20
> ----------------
> my console not work correctly - baudrate no standart ?!  :( i change port
> type
>=20
> ---- i change port type in ar7platform.c to:
>=20
> uart_port[0].type =3D PORT_16550A
> to
> uart_port[0].type =3D PORT_AR7
>=20
> boot process ttyS0 detected as AR7.
>=20
> Console baudrate not work correct again ....&-(

You will also need this patch:=20
https://dev.openwrt.org/browser/trunk/target/linux/ar7/patches-2.6.32/500-
serial_kludge.patch


>=20
> =3D=3D=3D=3D=3D=3D=3D log =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ............
> alg: No test for stdrng (krng)
> Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
> serial8250: ttyS0 at MMIO 0x8610e00 (irq =3D 15) is a AR7
> Id=10=C3=81=05=16Id=10=C3=81=05=12Id=10=C3=81=05=12Id=10=C3=81=05=12Id=10=
=C3=81=05=12Id=10=C3=81=05=12Yd=10=C3=81=05=12Yd=10=C3=81=05=12Yd=10=C3=81=
=05=12Yd=10=C3=81=05=12Yd=10=C3=81=05=12Yd=10=C3=81=05=12Yd=10
> =C3=81=05=12Yd=10=C3=81=05=12Yd=10=C3=81=05=16Yd=10=C3=81=05=16Yd=10=C3=
=81=05=16Yd=10 ......
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> if remart set_termios() in serial_core.c i see all messages ...
>=20
=2D-=20
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
=2D------------------------------

--nextPart4853521.4Xh0pBEFZh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuOwQsACgkQlyvkmBGtjybwnwCfdXkE6np8kjIjoklMPhxd9Q5c
gdEAn0BWhLgAsicfjAdE/MHELuicepXf
=Qww9
-----END PGP SIGNATURE-----

--nextPart4853521.4Xh0pBEFZh--
