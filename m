Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2011 11:55:11 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:41257 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903600Ab1LSKzH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2011 11:55:07 +0100
Received: by iadk27 with SMTP id k27so8241489iad.36
        for <linux-mips@linux-mips.org>; Mon, 19 Dec 2011 02:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version;
        bh=hQjm1Gcjp1fqRLSRJqLgOWRNQMBxDN/qpFMd7MEvQV8=;
        b=qnxdtZdfzyr6sd92jEs87SoD8Wrx5Zh6pxsCBH9h+g0sLZwuWGsuPdYeplqHk+qvf4
         2xxzgPN2LRLa+R63vzj/JVBT/6pOBG/nijV/ivM1zmzSJHRWHDBMu3pnXhnT4JYPzAsa
         QKLAOqNzrz1aEZLmaLHqpcR5jB6M/ohn/sUoo=
Received: by 10.50.207.72 with SMTP id lu8mr26437129igc.23.1324292101116;
        Mon, 19 Dec 2011 02:55:01 -0800 (PST)
Received: from [127.0.0.1] (jfdmzpr01-ext.jf.intel.com. [134.134.139.70])
        by mx.google.com with ESMTPS id aq5sm19123464igc.5.2011.12.19.02.54.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 02:54:59 -0800 (PST)
Message-ID: <1324292192.32675.6.camel@sauron.fi.intel.com>
Subject: Re: [PATCH V2 2/5] MTD: bcm63xxpart: make sure CFE and NVRAM
 partitions are at least 64K
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>
Date:   Mon, 19 Dec 2011 12:56:32 +0200
In-Reply-To: <1324290964-14096-1-git-send-email-jonas.gorski@gmail.com>
References: <1324208821.17534.0.camel@sauron.fi.intel.com>
         <1324290964-14096-1-git-send-email-jonas.gorski@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-HZ8UQEm6HImn2CDjNfdP"
X-Mailer: Evolution 3.2.2 (3.2.2-1.fc16) 
Mime-Version: 1.0
X-archive-position: 32141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14881


--=-HZ8UQEm6HImn2CDjNfdP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-12-19 at 11:36 +0100, Jonas Gorski wrote:
> The CFE boot loader on BCM63XX platforms assumes itself and the NVRAM
> partition to be 64 KiB (or erase block sized, if larger).
> Ensure this assumption is also met when creating the partitions to
> prevent accidential erasure of CFE or NVRAM.
>=20
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

If someone creates a partition smaller than 64 KiB, then why it is
better to silently make it 64 KiB (and thus doing not what the user
asked to do and possibly confusing him), rather than returning an error
or just printing a warning?

--=20
Best Regards,
Artem Bityutskiy

--=-HZ8UQEm6HImn2CDjNfdP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO7xhgAAoJECmIfjd9wqK0Yu4QAJuZQBWO0WhtiH6F2ykgVoCU
LSLZoeC1QdQx2CMMnEE8+2U6bQmlTspP33J9yKxDpLI2KFpfRuFhEmFwzRWZ0FHV
DrAB9DXJ1kTqBnDg1VyUPdvI3gAV+KwUUpfs1/q4oiZg64sdAlKXlqNu6G1XBSQd
G74xecxyX+Cfr96x3RIjXKPPN2rqLWrcDJD+VBHsawD0ogEoQjOVuaY6R0SqgvT+
2izECvxQywcWYUSdjt2WQcytiCzntfKmnQin6VjM5DnFY5jUQVXDPnTHU3OW3wTA
NlhLe7hVcPRWvtd22hadhq5aCoOQGIxE+U/+GPA8ufbzJUy7NPn6aYnVYolIcuLh
HBuQzhnH6Pl0DMmVr2JM4ivxscvrHoEyxSmjVs/JLogmoC8DHlgVvAXUtV/qhJc7
8VZDx3NZR4L+jHXmKByyHvACSrUBX8sEIBEpsyO3PBJsjwq30B2PvTwHtzwQbMzk
FZJg1ajI8KF8OTC0Rs+wNqLYixivtTXNCP0JlbQQpp5qT3bAoH0M5tp0BvjZqzKW
wxMYAkx1amY0vUjH132Wyo0TJGXd7U4eVLKSCOGWShujXNcChxBvknCHxA85w1ka
VI+hFy62Cca/gdh3Gx/30NZCYboeHOtY/QMPcoX70gCO7Sqx7nwFBxCSaPy2ROJt
rg4UzOZ813Qj3q72CSd+
=oLiF
-----END PGP SIGNATURE-----

--=-HZ8UQEm6HImn2CDjNfdP--
