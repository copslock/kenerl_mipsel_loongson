Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 10:54:15 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:58716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993124AbeDCIyGs3W1O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Apr 2018 10:54:06 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EC3920CAA;
        Tue,  3 Apr 2018 08:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC3920CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 3 Apr 2018 09:53:54 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 3/3] MIPS: use generic GCC library routines from lib/
Message-ID: <20180403085354.GC31222@saruman>
References: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
 <1522320083-27818-3-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <1522320083-27818-3-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 11:41:23AM +0100, Matt Redfearn wrote:
> This commit removes several generic GCC library routines from
> arch/mips/lib/ in favour of similar routines from lib/.

> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
> index e84e12655fa8..6537e022ef62 100644
> --- a/arch/mips/lib/Makefile
> +++ b/arch/mips/lib/Makefile
> @@ -16,5 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+=3D r3k_dump_tlb.o
>  obj-$(CONFIG_CPU_TX39XX)	+=3D r3k_dump_tlb.o
> =20
>  # libgcc-style stuff needed in the kernel
> -obj-y +=3D ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o mu=
lti3.o \
> -	 ucmpdi2.o
> +obj-y +=3D bswapsi.o bswapdi.o multi3.o

Have you missed deleting the files?

Cheers
James

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrDQSIACgkQbAtpk944
dnoaBw/9HMbx/CMVCDbUgpib19iwGMsLVXjz8S8SSeswxejNpm2Be9sRqYwSblYA
qOEgL8A5UQdYJISchU7R38UtCWF2IMfQFbD4R1oSmrKQfGOerxwXRtXYj4tmiXIz
wFYrys908McStD2mNn2WsjCfbN6gTYAtTQ9VLeIwElT6d8Db0Wid3L8MXuqV9Gem
e8/TIrDfjZt/S+RwMvG2aKBKvHByQfpAeE9ipZCwzuOyibj6vJMdlpn/5eJfv9kh
ESlboYbUh0wjJ+barZKGuOe29bNmH+2w/aNSoVCZlyqyhXOxRh1koMdUZJzcvjZR
vliIX/5LCUK2zhCwI5uQOqmLOu9TnT5nbmY0nuYuDEHmmQ4fsikLgKBLdQd6hdME
ip0cjiZT9MZa1qrr96sbq5J117QczJq4baAXW+xzRX1u9uBs3P7sG4+mdP8egTrQ
7pKRslRsNgZUsEAIXhWjN+tTTEI+m2RFCHi0BFyR1neyQ7/9sswXXNNQtIWGswy5
yvEXmgT7wnhuor+PI+CBsqemBKyI4wblOWS92JHlKSEgNvughOGRMQH0RiGM8r+L
prn6lvPZ34uh4H1stDgSBJ1qAAoQn+55jsrEC32R0IJ+dKLjwCy+Vrpsrq5Eqr5K
MjiPN5gnH+/oAIw8NKR0YjRCuSCM/bbrGtYzzVvw/cafDqqAHDA=
=GUUh
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
