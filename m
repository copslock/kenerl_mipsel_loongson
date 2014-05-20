Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 01:15:00 +0200 (CEST)
Received: from mail-we0-f179.google.com ([74.125.82.179]:33731 "EHLO
        mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855084AbaETXOwv9CUl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 01:14:52 +0200
Received: by mail-we0-f179.google.com with SMTP id q59so1259140wes.10
        for <linux-mips@linux-mips.org>; Tue, 20 May 2014 16:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-type;
        bh=rKJ0aO9dRcPGohRi7vuZtegQRaWueQDB16OEq+DPgds=;
        b=DP7qkd0yai30SutHXdCyts/T9uCtHXBp0rGnFgxGmOM/UNB6qpPJtMD2tb1/gx29H8
         ab+01UdeTQr/CwFJujG0QypZKWVnzV4wGWwk7XKQl/AOcDOMuBY38M/DbQ3RylN8W7Sr
         5QHhFBcASnTPqfumrka4PhrtJY/HU2du1mjqGnvtWTKtBlR22evzzolAVqS3q/NmIRs1
         t57NrGUdgHGPM3e9Psti1/yhldhgZOAFLe8/Iq/lI9v9AxvKptrHy9vwZP+Ivm1tiZ5c
         PnQOsXidHOA3rXLiZ1P0s0WKvo21/2LWbnhyg5rPAdHRnYCxAk8ZPtXpWzin4nYno9If
         V8Gw==
X-Gm-Message-State: ALoCoQl+hZldm/reWTmQH1xL4GPK18vl3Tl9LtIQaK0aPHxyzThRfU9kBIZiOFqio5U+BnOFftYF
X-Received: by 10.180.85.10 with SMTP id d10mr7014811wiz.0.1400627687482;
        Tue, 20 May 2014 16:14:47 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id w6sm20137568wjq.29.2014.05.20.16.14.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 16:14:46 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 13/15] MIPS: Add defconfig for mips_paravirt
Date:   Wed, 21 May 2014 00:14:31 +0100
Message-ID: <5385064.E38JNkq7Qq@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.12.5 (Linux/3.15.0-rc5+; KDE/4.12.5; x86_64; ; )
In-Reply-To: <1400597236-11352-14-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-14-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2106048.AoCNC1f7DD"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40196
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


--nextPart2106048.AoCNC1f7DD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andreas,

On Tuesday 20 May 2014 16:47:14 Andreas Herrmann wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>  arch/mips/configs/mips_paravirt_defconfig | 1524
> +++++++++++++++++++++++++++++ 1 file changed, 1524 insertions(+)
>  create mode 100644 arch/mips/configs/mips_paravirt_defconfig
> 
> diff --git a/arch/mips/configs/mips_paravirt_defconfig
> b/arch/mips/configs/mips_paravirt_defconfig new file mode 100644
> index 0000000..f0cac9c
> --- /dev/null
> +++ b/arch/mips/configs/mips_paravirt_defconfig
> @@ -0,0 +1,1524 @@
> +#
> +# Automatically generated file; DO NOT EDIT.
> +# Linux/mips 3.15.0-rc4 Kernel Configuration
> +#

This isn't a minimal defconfig.

Try make savedefconfig and copy the resulting defconfig file.

Cheers
James
--nextPart2106048.AoCNC1f7DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTe+HkAAoJEGwLaZPeOHZ6h+0QAKOrMAR8oyZZ2In+bKJ2R4af
ccxPSYr2GaetOU3pTp6CJWigfnOt1t23gP9wCEIIZot99FvHT/pLRNaDbUm5nI97
u7fWK5eZH6xCTgFm7mVQVRKrlSat2cIGsiaGLl0kiqufRyjj4bgbGYOYr6yXx3kj
n0Juzyhy2VxSMP8P76K4TKPW5XbqHuUj5XFtZJwWFo5PanSxaWZRpXvY4EFiJrfV
ktjB7nrzA0phA86xHh0kOi9FjgCkI8p83oDLAjZyK+V7KWTq5iyV1hoV4peN8O18
cvA0zkHNWVrt8lyapMVqXfQORR7AdZ+6SZqLXPc4xNIsvXsHoY4rcVYEnAr5n+Q2
wsYytppG3x7FY3FwUDcRurbwt5TgXBS6GNDLpKCFWimbN+h2/rU4/+osME00Kefk
IrhYXFHQ+TijPYYDbbYBcEcPO1ZNHOA+Pa96w55jx8v1gh8AZrKZtJAit/2QV4jO
UBmnd4tf2pyN1KmzOR3zzmA/TaCcLKwTQ5iKm1OcMYNVN+0EgzsrPpVVoqYKn3RS
IRZwgWhyXZV0P9Biq7dN6ci4l8qUzGKAfCSJd8RwbTHtocadDBqqAhEyEoESYmGj
pHddFqPjQfiiT8DB0abq6Yn7nyjAzjcwlUigDXKTWtfVY+QiiaWAGj1FvvPb19rj
lQPq3vu0AdR1IZhROhtY
=ix5B
-----END PGP SIGNATURE-----

--nextPart2106048.AoCNC1f7DD--
