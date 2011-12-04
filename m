Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Dec 2011 15:14:45 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:42147 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903601Ab1LDOOh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Dec 2011 15:14:37 +0100
Received: by iaby26 with SMTP id y26so10484iab.36
        for <multiple recipients>; Sun, 04 Dec 2011 06:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:date:in-reply-to:references
         :content-type:x-mailer:message-id:mime-version;
        bh=+9NaFgEwnFftoqhyZgk+TX8VWc1KZ8I7MJFuzxrwSNA=;
        b=On4/qfBgcwSe8KRsAEpLF7Je7KBRPwLgLheKUB42VmKnkp0BdnJXH5YSza2Cjo9YyS
         LDN5x9VMt5zDPMP8V9ftmY40+VxDL6y0BdbkOThSCCZO3w1YYRV0fTv+RFhU67mNS6QU
         MTWCjA1m7XsyvZ4bmOnhS6DfMbgdxOIfUnEW4=
Received: by 10.231.81.146 with SMTP id x18mr1465373ibk.23.1323008070883;
        Sun, 04 Dec 2011 06:14:30 -0800 (PST)
Received: from [127.0.0.1] (jfdmzpr01-ext.jf.intel.com. [134.134.139.70])
        by mx.google.com with ESMTPS id wo4sm35093372igc.5.2011.12.04.06.14.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Dec 2011 06:14:29 -0800 (PST)
Subject: Re: [PATCH] MTD: nand: Convert au1550nd to use
 module_platform_driver()
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Axel Lin <axel.lin@gmail.com>
Cc:     linux-mips@linux-mips.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mtd@lists.infradead.org
Date:   Sun, 04 Dec 2011 16:15:32 +0200
In-Reply-To: <1322748247.31743.1.camel@phoenix>
References: <1322748247.31743.1.camel@phoenix>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-inji+l5rPcf7ZbYZlN52"
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Message-ID: <1323008139.9400.59.camel@sauron.fi.intel.com>
Mime-Version: 1.0
X-archive-position: 32020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2548


--=-inji+l5rPcf7ZbYZlN52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-12-01 at 22:04 +0800, Axel Lin wrote:
> Cc: Manuel Lauss <manuel.lauss@googlemail.com>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> Hi Ralf,
> This patch converts au1550nd to use module_platform_driver().
> You have committed a5bd32fd "MTD: nand: make au1550nd.c a platform_driver=
".
> Currently this patch can only apply to either your tree or linux-next.
> Could you help to take it.
> ( committed a5bd32fd does not exist in l2-mtd-2.6.git,
> so Artem cannot apply it.)

Yes, please, merge the au1550nd.c piece via Ralf, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-inji+l5rPcf7ZbYZlN52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO24CEAAoJECmIfjd9wqK0e7wQAMJWcelDQxxBzqU/aQa/lnZ2
U3QUnVGStwLCL3ADXSPCqQ2P3a2mdPZdljcjYntg4GtDlq6k84a3O9qz6sigw+ts
WgXZ/E2RUy6vqvoPOtSJHL1jbqI8pF5+4hcOErbGeidssNVpG4RAyvfRxocD86dt
B9L2rQFBqFGyzdVc13F/hxtsGpk8ROx0UlsMO4ymrAnyNqSv4nyeT/UNEd+tUvje
ZpZhPl5RTTOx+R5gq2U4RGM9Dm7GEGKldBTMH84TJGC2abx/xmQ35e4WWT5uoqrA
y6gWBgz2AvNILyvouW5Fsuh2cVTgxrVFueYBR4rMNNlHSU7uDWdMJCDYIj2aZmL4
prrAWmtlYDOuMLZoz9DOM/3JpjppURHxkjKf48xQt/M4eEoJCUgUVoD0WIkPrGOg
e+lTfwefyEgrDBP8BbGbplPBJOzeEgCXeO+WhTpnsOCYjbVw5Zv2oqZwG8Lw8CpI
vjCG7nmQhyoTMD9wKRLNPjyZsIFREh90aeGl9qMqYdRQnzZGQShmo9chh+3K1st5
MYWqCZAFenUVTaSg5bhGqH7uZqEaQCQYmMkfoc+l7TdUxTz9aBTtjwUnXnOcIxoA
8oVAENtvSXAjRdu4JoF1vq2QyQ+PpIjiBlwfM+hBvIcVrwKaM9mNG68FAj2ZsObs
mt+t/7SFmpfdpKsEqhP0
=/ziI
-----END PGP SIGNATURE-----

--=-inji+l5rPcf7ZbYZlN52--
