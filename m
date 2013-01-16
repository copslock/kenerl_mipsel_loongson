Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 11:04:11 +0100 (CET)
Received: from moutng.kundenserver.de ([212.227.126.187]:56009 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817128Ab3APKEGfT-X3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 11:04:06 +0100
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
        id 0MIjEq-1Txbhm10Ce-002gOT; Wed, 16 Jan 2013 11:03:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 28EBF2A28162;
        Wed, 16 Jan 2013 11:03:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4rD0Ku2GQvA5; Wed, 16 Jan 2013 11:03:53 +0100 (CET)
Received: from mailman.adnet.avionic-design.de (mailman.adnet.avionic-design.de [172.20.31.172])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id E87422A28066;
        Wed, 16 Jan 2013 11:03:52 +0100 (CET)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        by mailman.adnet.avionic-design.de (Postfix) with ESMTP id 1A4E51003EB;
        Wed, 16 Jan 2013 11:03:49 +0100 (CET)
Date:   Wed, 16 Jan 2013 11:03:52 +0100
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PNX8550: Fix build failures
Message-ID: <20130116100352.GB13628@avionic-0098.adnet.avionic-design.de>
References: <1358320033-30032-1-git-send-email-thierry.reding@avionic-design.de>
 <CAMuHMdVYCx+qyWwYh0pEZyeLOSz+5_7=fYAa7aAteGt-GmH2og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVYCx+qyWwYh0pEZyeLOSz+5_7=fYAa7aAteGt-GmH2og@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:7NlDnT+FFyryV0RqUzSbx+qU5noTe61xLmSdj+YbxOK
 t+MrbwnLN9/DW47tdrqOwniJrp5zc9bZ6PyZof9crqB+DZtkr+
 5Cdjc6GPjEj+PF8lV3METfJqUQmGiZCHRmTrRPykyYwc5jFYNN
 Y4L5atDGfYwWNlyjN5Q9MTptdrT3dgFSnOKIk+i0sZ1QB9ofjf
 epIzv4MmuX+7kAE5WCqY5fSc6Iu2qsIN2op2IAT2zBjhJbq0hd
 NIvch3sX0X9ePgTQF5Y9mm2m38kuX2iGjm197K0C8PQiTJxwmH
 r7roHJH99XJ76ZlSIfX5GrB7knFxZiSbDvgOgutqjZ1KT+aMhK
 qbhQny3oDAKfbZAeqHw92dIw87T/nhfRXF2GxxLijxeFkodc4X
 aYEXEe5jzN8nsCnORfNgPGTFbN/nU0+dtQ=
X-archive-position: 35462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2013 at 10:51:47AM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 16, 2013 at 8:07 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > The OHCI support code fails to build because the PCI_BASE and udelay()
> > macros which are defined in pci.h and linux/time.h respectively. Adding
>=20
> > +#include <linux/delay.h>
>=20
> time.h or delay.h?

That'd be delay.h. Can this be fixed up when the patch is committed or
shall I resend?

Thierry

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ9nsIAAoJEN0jrNd/PrOhHn0P/1nppxrNzncmsmIigCENM2aW
ahvyDSfGpA9zbCpz0d2lfGDCD4EiBmn+a765GqvUAuSrYWsnHBzT8fp13/sby1/m
EUDBgbHQh9DDe0bNFPkjFYzgKYZ9P1P9pc5F+41E21k5uw3vHo+Ni9wKhi+oJPsK
gLUoASG6KMwGjMhtQ40XeiuPqGn0cb/4vZykG9sAS0E8AQdf4pY0l7R7W2qhl8TO
mc+GYd7KGuKObxQ0n4715AWh0m/upovTkp0sxWMBaVm2VgD9qwX3CPj7Hk4r7ii9
MFsqWpeJ26iF33wkpFoX0NdLTlC4XkwPAW6o8aOT8ZkLaOwm7Ul3760YJx/+gwOc
LnBdtofLFxTGbqYdurMaS/xUVbSRiV1cDwrTIcfDtrfEJO6P+Vmox9s+qL76hBQv
uJ8ZxdMZQMH8MU6ourpDan+JAXTlVkk0gvSuFWuMOVsmZGMmCkSVjjPHT6ItddNS
kcTKzITNbec5Q8eSqvhIs/eWUKth6XH0Oz7QAt6bT+CA6qoxM7qoSXxxweFt3QQ6
JXJxdLOU8fHwwLyYJXsZHeeSLXQaiFYNfvVHfV8LPpwqNEwmqkq0A5lFtnLLc+EW
OWSbab8aNxnV6c31VQNsweeqV9Xi4cIs6I6dZL+pIT5sbrzsKJVRKLtj/zC/HuAa
/L6NelrJKPhJ0bCbT7ES
=DQhD
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
