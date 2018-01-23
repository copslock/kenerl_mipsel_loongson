Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2018 15:29:06 +0100 (CET)
Received: from forward103j.mail.yandex.net ([IPv6:2a02:6b8:0:801:2::106]:54560
        "EHLO forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992821AbeAWO26qVytF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Jan 2018 15:28:58 +0100
Received: from mxback5j.mail.yandex.net (mxback5j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10e])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id F28B734C3CFE;
        Tue, 23 Jan 2018 17:28:51 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback5j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id n2LOo8Eho2-SpoKvFnT;
        Tue, 23 Jan 2018 17:28:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1516717731;
        bh=mEtc8zsPuzvi0ppFJYMuKbT+gLDOo88pyI5LigjB3LM=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gCc930CrvqZ0kqatIHI7rBWwvMcFugpcgQA7xX//XTRV2A/ZdM7uGV9AyI+Qjssor
         7j11GnJ0AYHZ+fNIjuUOmDlSzEZ/CFiWv7MCaq18gO4M/Im0QmbWA+3YtNLPHT1+9U
         qfWIzXBM0guGBQm2HEL6G8kqkUgbJ9aAAxofNdPE=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id WyZQJr2GSk-Snd0HRxx;
        Tue, 23 Jan 2018 17:28:50 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1516717731;
        bh=mEtc8zsPuzvi0ppFJYMuKbT+gLDOo88pyI5LigjB3LM=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gCc930CrvqZ0kqatIHI7rBWwvMcFugpcgQA7xX//XTRV2A/ZdM7uGV9AyI+Qjssor
         7j11GnJ0AYHZ+fNIjuUOmDlSzEZ/CFiWv7MCaq18gO4M/Im0QmbWA+3YtNLPHT1+9U
         qfWIzXBM0guGBQm2HEL6G8kqkUgbJ9aAAxofNdPE=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1516746524.20678.6.camel@flygoat.com>
Subject: Re: [PATCH 12/14] MIPS: memblock: Discard bootmem from Loongson3
 code
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Jan 2018 22:28:44 +0000
In-Reply-To: <20180117222312.14763-13-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
         <20180117222312.14763-13-fancer.lancer@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-s/MyWgNO68vY8ht4D1sc"
X-Mailer: Evolution 3.26.4 
Mime-Version: 1.0
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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


--=-s/MyWgNO68vY8ht4D1sc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2018-01-18=E5=9B=9B=E7=9A=84 01:23 +0300=EF=BC=8CSerge Semin=E5=
=86=99=E9=81=93=EF=BC=9A
Hi Serge

> Loongson64/3 runs its own code to initialize memory allocator in
> case of NUMA configuration is selected. So in order to move to the
> pure memblock utilization we discard the bootmem allocator usage
> and insert the memblock reservation method for
> kernel/addrspace_offset
> memory regions.

Thanks for your patch. However, In my test, the system didn't boot
anymore with your patch. Since I don't have any lowlevel debug
instuments(ejtag or something). I can't provide any detail about the
problem. Just let you know that we have a problem here.


--
Jiaxun Yang
--=-s/MyWgNO68vY8ht4D1sc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEmAN5vv6/v0d+oE75wRGUkHP8D2cFAlpntxwACgkQwRGUkHP8
D2cMAw//dYQJdyFPAue/1OhaM44yI20efQ+iBu6uHU1weWq7bV/cAqTnZ45YYkip
HMyscS1zIm5CrecmyzdqFQEfb8J6wb7JcofQucsWeBrT6UisiT26JseOrxxZjf+X
t/ijcfPGOVlY3f4kcS7vs+ZfXCeF/3uvUdGDDcen7rspWcEw2KfG4J+ImevrtGhU
CgrEJHQko/XvFJ4DW/Yo7HE1lb/jitHGLI0ovS0M6nDiv+mrYWfLu4zFLh4dBjDt
EnD8sAfS+7SehYvLDJ0as7GgQzrbrhdZqHCN+VY5vvRH+2umYfQhw/uPxFmyKpJm
1ASbtSraFyrFIF1HJ72lG+FSwWDG1cICFQEXXZ+hwJTyWnMJwZgdFPGCE5vV3dlz
d/aUNYVJQT63vhyoNVthKcVqRrRbUvG5FFeIIjGs50wLXL0kt9EOrS/FJ/lU5zi+
GBeKr35Gn6HmW7Qn+0rCkcd3AD4Sts0PhO+J1T5gy7JaXgqWxapThr55UE8nn8zX
UKDiUHv6Fh4BHbLV0xnBF747S18vspiG0MJ2gcp9PGUqGoD6HyJvpIpTl2ooQ3eI
SyudMrt11TFlPIusUh9qHi0h9GZys2HLkozRYlsrNIjynVdiEWnX6pVG148Xs2IU
wHk9OE62uvvM1+MSCB7ab6s4O+B5/0dwl9zaWs4eooZwsx+tCdQ=
=yAql
-----END PGP SIGNATURE-----

--=-s/MyWgNO68vY8ht4D1sc--
