Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2014 12:54:19 +0200 (CEST)
Received: from mail-ee0-f51.google.com ([74.125.83.51]:57877 "EHLO
        mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821221AbaDQKyRDEytR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2014 12:54:17 +0200
Received: by mail-ee0-f51.google.com with SMTP id c13so515253eek.10
        for <multiple recipients>; Thu, 17 Apr 2014 03:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lug0nCpJeWlHHyu1KqsraO4ES+k0kRwGxYp7KOL9huw=;
        b=mnvre90x8IjPB7FmBY9nzRqm7vXz3PyWfb/i8wuQZlp1EBxBwcju+zw6g4bokKQ+Ue
         76FXTTWZhONpSapaqdu+2/0xgVBsA0jTtgJ0nI6mWsr9EU16fNLVMjQ7XHIPn6cUQqKv
         rGGrOWLd49OB+wUzuPnsFhuBYnqFKdS3PPvzbUCXW37o7gaF/X4Rn8ZyfQt2sEp16lXf
         9Ks4RbyO12Y/Jg6Gw1EicEUkX62Jf38e+KBJFlJKEr7RriYwZ++ZwPkQ33uMwwQS/FAH
         KTZCeC6rwq4T07bpDKwRaNnt3tKZgem4oGQu06/w8TLTR93+bqEAYvyUMTFnsMhXC/UA
         5/4w==
X-Received: by 10.14.3.69 with SMTP id 45mr3964366eeg.68.1397732051636;
        Thu, 17 Apr 2014 03:54:11 -0700 (PDT)
Received: from localhost (port-7483.pppoe.wtnet.de. [84.46.29.88])
        by mx.google.com with ESMTPSA id q49sm66291834eem.34.2014.04.17.03.54.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Apr 2014 03:54:10 -0700 (PDT)
Date:   Thu, 17 Apr 2014 12:53:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>, linux-mtd@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        Shawn Guo <shawn.guo@freescale.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Steven Miao <realmz6@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 0/5] defconfigs: add MTD_SPI_NOR (dependency for M25P80)
Message-ID: <20140417105302.GA32603@ulmo>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39849
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


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2014 at 12:21:44AM -0700, Brian Norris wrote:
> Hi all,
>=20
> We are introducing a new SPI-NOR library/framework for MTD, to support va=
rious
> types of SPI-NOR flash controllers which require (or benefit from) intima=
te
> knowledge of the flash interface, rather than just the relatively dumb SPI
> interface. This library borrows much of the m25p80 driver for its abstrac=
tion
> and moves this code into a spi-nor module.

If this is a common library, then the more common approach to solve this
would be to have each driver that uses it to select MTD_SPI_NOR rather
than depend on it. That way you can drop this whole series to update the
default configurations.

Thierry

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTT7KNAAoJEN0jrNd/PrOhzhQP/3ocjlUpPSUcBT7myTaYn8dC
zbZ0Zp5MO34d42OXHqfYC0q6LiCYp4I6xQDn8usqKBxpHd1dBAirD0z7Ofp3nAo5
JwH+vr8zDZNTZcQd5W/LRI90fa/9qVNytVFNSEbmeNUop74+yhnQb//rq3YCskEZ
v8rHJpH7uaJUPeVTsvrbmtW/9ZW5+ofFWj2JffogOyC4NY/oOldXl4gsOcP+PuF7
gFdIn+D+hyEa2ZLjdeYD9lIvmLHczXhda0KPDZO31gDQyHvgMt+goUUgtWlqfHv+
8cuKJjhHeMhMYtdZByrYRRVuhlafZlLJ2PqmunFCgsd/1P9Ww+k+nZJASw8jFqbd
nGxDcgXG/4vfiFj0HMZoR/cWh845wYrWXdzaZdmY0bjiHEsz1ip+OVNq5ACq+d+L
9posY8HH1btDrrcJEsce4DTHTJsAYdeX0oik8DK+gHi5no7sd8Twd2ZjJaZxtwXk
pH+RZqVa3Wrj68vCXuyTZSFZb/QC/ZttUgW5YhfVcQJcsOC02+LRKOIbu0Em8hMq
3sdsgTImKHFAEdWm4oNOHlOPN4nk/tMRo3nrCUV4Pb+yaCelIBlKo/9JLK0JfDQJ
/qPtjG0OAPJYmHmwPcSB57kA/MZlF6RnNI1V8CHWOCQm94NwGirKBropQ/9yLxs7
lrnTat974tXvX/gLJ7Do
=Xz6I
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
