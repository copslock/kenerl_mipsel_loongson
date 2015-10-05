Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 15:29:43 +0200 (CEST)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33430 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009507AbbJEN3lazkjQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 15:29:41 +0200
Received: by wiclk2 with SMTP id lk2so120563066wic.0;
        Mon, 05 Oct 2015 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3g7nirAFxCfjhy3270OyNudgnudBiSAW98NmYNCCUvI=;
        b=dm7ujL+FPoqJFZlkFRgqkFPsjEkopqskaOYC5Vq/p2DLoXqU1H/e6HtWweqyTcTVoC
         94E/BeSYozEzweRCt97+sisHqqe35bnyVYp3u5uB9tEEPQj7Njqsi2KGnWWGYcSynoq6
         385Pwmv3475bK5I6CNb5AIfb86fyvMd8MStqIwJ7BwUc8nVxpXGyA2tkerTgKFYf/nY7
         a18kSiFv2hOza9jvMcvGDkEkkWuwIK/1SHvqQ9XJXbm7SCykzAL1582sBiyr6HnUR4xM
         RnQJiksud3pkuWAR+xjNKmm+C2Mutn4fhYf4qlCgiU2zcXyeaK3uLdOG8L7h8JUDYKar
         pGuw==
X-Received: by 10.194.221.4 with SMTP id qa4mr33534039wjc.145.1444051776241;
        Mon, 05 Oct 2015 06:29:36 -0700 (PDT)
Received: from localhost (port-54044.pppoe.wtnet.de. [46.59.211.200])
        by smtp.gmail.com with ESMTPSA id z2sm14685506wij.1.2015.10.05.06.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 06:29:35 -0700 (PDT)
Date:   Mon, 5 Oct 2015 15:29:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: jz4740: Add missing gpio.h include
Message-ID: <20151005132934.GA22979@ulmo>
References: <1444044571-11304-1-git-send-email-thierry.reding@gmail.com>
 <20151005151803.5b5a5b40@avionic-0020>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20151005151803.5b5a5b40@avionic-0020>
User-Agent: Mutt/1.5.23+102 (2ca89bed6448) (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2015 at 03:18:03PM +0200, Alban wrote:
> Am Mon,  5 Oct 2015 13:29:31 +0200
> schrieb Thierry Reding <thierry.reding@gmail.com>:
>=20
> > Commit 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h") was
> > incomplete in that it didn't replace any of the includes for the JZ4740
> > platform and thus broke the qi_lb60_defconfig build.
>=20
> The fix for this break has just been merged upstream yesterday.

Okay, great.

Thanks,
Thierry

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEns6AAoJEN0jrNd/PrOhXWwQALa74BeEX1D2KG2bRtr+L7xK
SCE+tp0hYUPADkaDDXLPRoELBcoQQmg6vnlL9fKTKK8Ji5u1sL4N5ZlL2Sc5pjDz
AKUn9bA3grOpNR9Aiu3Wjee+9R3YPtHqdkkyJuj/u4ihAeIMhK4Ld1E3+y+fJglQ
Ff1J2uH8aTo9FLagHUu8fQpX2Un2hzZjI1lkf8YEXOu1VpsPvNKozSmuhzVQo5m4
JDlqitzKD8jzisQ16LJBR9YA+C4pob5qlbkaCcmZLfb/PIr3A0zycEpyjSROMLNP
FYsI8fUekLYNM+RRF0+GPab3Blyi/gJXckNs2GMkAiUNR6Z9nh1hLfqko/FLIFhm
GMEwhO+w6meOCgzoVg4X/iYOa/R9dCbLsCg8XkWcN0kpeW3/EwQZQ5ncvzISOHcC
qES2LmZZWCBO+arl3cp7V3xV6EfJKOkFSqL6OgCdSPWYG1LFAmixZjYYo411vB7D
XYbL5sKx8uepu5sCYd3jlcEfMUDx826dLXnb4Gp09ShTRARPvWakmvtf2wuTxHPB
Kz0Py7zQ5V7CI7zvKXokWnGNxEHoSdLtd1oh+ynVyUq2ptMK080wKBdypN/SIsOr
SdV2iPICFq6GMRzgBqGbJsOHmdy/RFpzzHVga3b638RxEi3fH/bdbE/0zPioet63
9UoUIuEPUy3T1Tu8GvV+
=stUm
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
