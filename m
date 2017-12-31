Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Dec 2017 14:14:44 +0100 (CET)
Received: from forward106j.mail.yandex.net ([5.45.198.249]:36566 "EHLO
        forward106j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990426AbdLaNOiPv1pe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Dec 2017 14:14:38 +0100
Received: from mxback9o.mail.yandex.net (mxback9o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::23])
        by forward106j.mail.yandex.net (Yandex) with ESMTP id 4D1D71802E1C;
        Sun, 31 Dec 2017 16:14:31 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback9o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id e4upMUXNnk-EUXG9b4h;
        Sun, 31 Dec 2017 16:14:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514726071;
        bh=PO0nXIRujH+tTNChOYko5tOCN4CvMOrgdl5DJVMq7n0=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=erkE7TwwHGA0wTXaaYhlzr0phbqornAIvT5avYom3OiY5G/TD2eEkWG3LBcpOxM2t
         6wvtrR3pbRyEq89s40HZTfs3BBduHA3pck6egGKHAbyAQGaJ71Wuu+2E5EBSBvT0YD
         GsgoPIcMifnENPuODcXIcyFYJNS1j552Wp1PzB9s=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Fy6EKbjVTQ-EQ6OWuCe;
        Sun, 31 Dec 2017 16:14:28 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514726069;
        bh=PO0nXIRujH+tTNChOYko5tOCN4CvMOrgdl5DJVMq7n0=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=TR+T1P8TUC3KAoyQyWWDvY3MSqDmIHcIdRyaxuSKBTnQZ8eBiswpYR7gF1BSvkN5y
         xgnuCBBLbVF21+EB38jEgQaMWZrR80k98J0CjLnDrZDclax4ft5vIm1w42eJzwMDHk
         oGz7VIDkfHkB6wXkdW72JfupCjCruzYAb/3xHpEY=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1514726063.1668.7.camel@flygoat.com>
Subject: Re: [PATCHv2 1/8] MIPS: Loongson64: cleanup all cs5536 files to use
 SPDX Identifier
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Philippe Ombredanne <pombredanne@nexb.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>
Date:   Sun, 31 Dec 2017 21:14:23 +0800
In-Reply-To: <CAOFm3uFM+7n_YaKBkZV6jV4VHCBhtGhUTLbB4uedMaCa+nf3PA@mail.gmail.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
         <20171230182830.6496-1-jiaxun.yang@flygoat.com>
         <20171230182830.6496-2-jiaxun.yang@flygoat.com>
         <CAOFm3uFM+7n_YaKBkZV6jV4VHCBhtGhUTLbB4uedMaCa+nf3PA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ShmUMIMlyQsBzwm8+SDI"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61799
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


--=-ShmUMIMlyQsBzwm8+SDI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2017-12-31 Sun 12:17 +0100=EF=BC=8CPhilippe Ombredanne wrote=EF=BC=9A
> Did you CC the original authors? You would need their signoff or at
> least an ack IMHO

Yeah, I CC Huacai Chen in v1 as the Lemote staff who in charge of
Loongson's mainline kernel. Can he sign-off for all the original
authors who were from ICT and Lemote?
As far as I know, some authors are no longer working in Lemote. And I
can't see their new email addresses so it may hard to get their ack or
sign-off.
Thanks for your adivce.

--
Best Regards
Jiaxun Yang

--=-ShmUMIMlyQsBzwm8+SDI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEmAN5vv6/v0d+oE75wRGUkHP8D2cFAlpI4q8ACgkQwRGUkHP8
D2c1yhAAhVhBOLt+0emRLqgAbx+5Pg8EYcc3EJXThZzbmK6nK/atwUcJXO74np53
udRd3OF5MAidb4/5/JmRKADQHiJ4sowXZufQv4TzSCwZy1vPmTbBhxbsxhOP9z+3
GcwPWAhO0ulmI28eHDjsxh6NHXnfob6P3/gMPLgP4KbzA26tDBUMXzVXMZDTzAsu
vRbJl94sKiCaYkb304JwVGuZ2uVPrl1L1netiH9bcJhXaXJao+LMGpWYCviFamDv
cypr9QNKNd5gVm97TMbAO7KkcZMhyKGom2ZdwJ7Np/H0N0e/OPm4U/6JaDQM11S6
Sb6d1o0cTwB5S5BL+jLryMse4AuRiSH9j9gkjqCFs09uUwAP7sRgwIZXDJFDozuX
FFcYX4HaKMp0Cf7McEq5Vb6KHdfyJzVYEDJUVzAOXXfcnJt3oNcL8luH9/eaz5se
8kqjHzVwIej5ZPb0Jt+LDDAD0S4UdnnRgpS57DHXvDBqrvKohmpR3YSVWkfrTOHq
59FfKP4eyn4AnE1TsBj7vBm4I0xGgbF5DzZVc+6BXuWKO8MMIUD2CapPDIGu9WPU
svmd+7U58nJXia0OgKbF3rPZVs9CkdYk7rh/6yvmeqlVGM1YyV8+AWWHzpCIHRlD
OYIl/tPXN95557EofKlGEeGrxVRf3drDRZXlvPOrDN/9K1NNmBA=
=trBS
-----END PGP SIGNATURE-----

--=-ShmUMIMlyQsBzwm8+SDI--
