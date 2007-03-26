Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 22:19:40 +0100 (BST)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:37024 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20022622AbXCZVTi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 22:19:38 +0100
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 70D048D1695;
	Mon, 26 Mar 2007 23:18:21 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	Thiemo Seufer <ths@networkno.de>
Subject: Re: [PATCH] Fix a warning in lib-64/dump_tlb.c
Date:	Mon, 26 Mar 2007 23:16:23 +0200
User-Agent: KMail/1.9.6
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <45FABA5A.5000007@int-evry.fr> <20070321165521.GI2311@networkno.de> <200703262309.57577.florian.fainelli@int-evry.fr>
In-Reply-To: <200703262309.57577.florian.fainelli@int-evry.fr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4466807.I0LEuth0cH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200703262316.24160.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--nextPart4466807.I0LEuth0cH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46orgot including bug.h. Final fix :

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
=2D-----
diff --git a/arch/mips/lib-64/dump_tlb.c b/arch/mips/lib-64/dump_tlb.c
index 8232900..a2a12ee 100644
=2D-- a/arch/mips/lib-64/dump_tlb.c
+++ b/arch/mips/lib-64/dump_tlb.c
@@ -15,6 +15,7 @@
 #include <asm/mipsregs.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/bug.h>

 static inline const char *msk2str(unsigned int mask)
 {
@@ -30,6 +31,7 @@ static inline const char *msk2str(unsigned int mask)
        case PM_64M:    return "64Mb";
        case PM_256M:   return "256Mb";
 #endif
+       default:        BUG();
        }
 }


Le lundi 26 mars 2007, Florian Fainelli a =E9crit=A0:
> Hello,
>
> Here is the patch taking into account your remarks. Thanks !
>
> Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
> ------
> diff --git a/arch/mips/lib-64/dump_tlb.c b/arch/mips/lib-64/dump_tlb.c
> index 8232900..a320944 100644
> --- a/arch/mips/lib-64/dump_tlb.c
> +++ b/arch/mips/lib-64/dump_tlb.c
> @@ -30,6 +30,7 @@ static inline const char *msk2str(unsigned int mask)
>         case PM_64M:    return "64Mb";
>         case PM_256M:   return "256Mb";
>  #endif
> +       default:        BUG();
>         }
>  }

--nextPart4466807.I0LEuth0cH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGCDgokwOXMtq9F3IRAiFaAJ9t2Ss2+HnkOpGLFOj07J6OPQQc+wCfb6X/
fqe6/txq/0iPFeBu+pLYRfk=
=2HaB
-----END PGP SIGNATURE-----

--nextPart4466807.I0LEuth0cH--
