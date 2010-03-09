Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 22:24:04 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:34519 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492547Ab0CIVYB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Mar 2010 22:24:01 +0100
Received: by bwz7 with SMTP id 7so5508152bwz.24
        for <multiple recipients>; Tue, 09 Mar 2010 13:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=JhQcs8UoidxjVy1BQocjX8WNxK2VH69w0DYMGYBf/FI=;
        b=lzClh7O5ZTCTIUX4BLDTixSaVXwbeBE/18nT9SSrfywwLq5iYUP5wYOi2veSVT5LXr
         P5Ilu0SL0l2j8pDQ/u5QLCXbOPUbEAFfnJ0JjLUJJSPBrZlm4hL62eC1C54wSdnky9t6
         pip6OwLth44Kq1kLaX71cwgTrbRXB93w8D2nU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=KBBdCWf+T8cWUjujzX0WKzZeAEI+N14Copq9SScYjDGjBfuDlCatwb9stU1imHmkoc
         4euPkX7vTErHFUS/5brVrL4E1TOAiEzNTMpomwIV4kqVMn2rBBWGO1nnVKIPuP+8HvRF
         ehnaqbsZWMqtve6csdziVpxca+p0n04Fzl94A=
Received: by 10.204.26.135 with SMTP id e7mr404223bkc.202.1268169834331;
        Tue, 09 Mar 2010 13:23:54 -0800 (PST)
Received: from lenovo.localnet (153.44.69-86.rev.gaoland.net [86.69.44.153])
        by mx.google.com with ESMTPS id a11sm23972730bkc.21.2010.03.09.13.23.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 13:23:53 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     peter fuerst <post@pfrst.de>
Subject: Re: [PATCH] MIPS: make CAC_ADDR and UNCAC_ADDR account for PHYS_OFFSET
Date:   Tue, 9 Mar 2010 22:23:46 +0100
User-Agent: KMail/1.12.4 (Linux/2.6.32-trunk-686; KDE/4.3.4; i686; ; )
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
References: <Pine.LNX.4.21.1003092137280.898-100000@Opal.Peter>
In-Reply-To: <Pine.LNX.4.21.1003092137280.898-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1591353.nO66AmWWmk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201003092223.50837.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--nextPart1591353.nO66AmWWmk
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Le mardi 9 mars 2010 22:03:27, peter fuerst a =E9crit :
> Hi Florian, thats funny!
>=20
> On Tue, 9 Mar 2010, Florian Fainelli wrote:
>   > Date: Tue, 9 Mar 2010 15:46:01 +0100
>   > From: Florian Fainelli <florian@openwrt.org>
>   > To: linux-mips@linux-mips.org
>   > Cc: ralf@linux-mips.org
>   > Subject: [PATCH] MIPS: make CAC_ADDR and UNCAC_ADDR account for
>   >     PHYS_OFFSET
>   >
>   > On AR7, ...
>   >
>   > Signed-off-by: Regards, Florian Fainelli <florian@openwrt.org>
>   > ---
>   > diff --git a/arch/mips/include/asm/page.h
>   > b/arch/mips/include/asm/page.h index ac32572..7b11df5 100644
>   > --- a/arch/mips/include/asm/page.h
>   > +++ b/arch/mips/include/asm/page.h
>   > @@ -188,8 +188,10 @@ typedef struct { unsigned long pgprot; } pgprot_=
t;
>   >  #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
>   >  				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>   >
>   > -#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
>   > -#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
>   > +#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE + 	\
>   > +								PHYS_OFFSET)
>   > +#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET +	\
>   > +								PHYS_OFFSET)
>   >
>   >  #include <asm-generic/memory_model.h>
>   >  #include <asm-generic/getorder.h>
>=20
> I assume, you don't want "+" PHYS_OFFSET in both defines.
>=20
> Two years and a month ago almost the same patch (which used to work on
> the machine that needed it :) was submitted:

Oh I actually did even search for that one.

>=20
>   --- a/linux-2.6.24/include/asm-mips/page.h	Fri Jan 25 12:23:51 2008
>   +++ b/linux-2.6.24/include/asm-mips/page.h	Wed Feb  6 23:26:31 2008
>   @@ -184,8 +184,8 @@
>    #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
>    				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>=20
>   -#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
>   -#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
>   +#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + PHYS_OFFSET +
>  UNCAC_BASE) +#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET -
>  PHYS_OFFSET)
>=20
>    #include <asm-generic/memory_model.h>
>    #include <asm-generic/page.h>
>=20
> But correct versions of these macros seem to be essential for very
> "exotic" systems only ;-)

You are right. This is actually needed when people do weird designs, and th=
at=20
happens ;) Will resubmit with the proper fixing.
=2D- =20
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
=2D------------------------------

--nextPart1591353.nO66AmWWmk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuWvGIACgkQlyvkmBGtjyaHiwCfXuKVHV63x0jLKD9NrAmYLFoE
dS0AoJNMN3fet6y4+pZ3gF8U2u6uxIyH
=sHSC
-----END PGP SIGNATURE-----

--nextPart1591353.nO66AmWWmk--
