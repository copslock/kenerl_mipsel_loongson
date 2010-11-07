Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Nov 2010 13:38:44 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:34299 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491099Ab0KGMik (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 7 Nov 2010 13:38:40 +0100
Received: by wyf22 with SMTP id 22so4499427wyf.36
        for <linux-mips@linux-mips.org>; Sun, 07 Nov 2010 04:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:subject:to
         :x-mailer:message-id:mime-version:content-type;
        bh=qP4lPjzpxuEsSmTHQzOdXrAIBGW8+jrx5WVorUFk6kA=;
        b=Gq6nckwqFAX/JpZrN57qoR/IiyD+rOWNiiVTxbUjEoGESK9U4WTPswRpbuwGlXtNmZ
         Czf2fReJKLGB7UMQdUUP+Zq7ixsG0fqsm9lPC+0YVJPSdiQJspkgyorGPcLUPzgs8n0F
         TjFtsN5BRm/R5lRvV68BvkJSu0vN8m59g9a5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:subject:to:x-mailer:message-id:mime-version
         :content-type;
        b=djapiWYLkfILPS/5wR4oOMXKPTMkbp+QSupx+w0nr/usgyPeGbaCTMiYTQtsxNX1oz
         ghpDtLPAEbWl+BDRgJF8tRaZb7K/IgEsVIQwxFH5W1DpkxDntmbFULr7d30dohe0qXnK
         J0UGoLvtIjnhzwQrgWHhZNWrJakd8uBzO1bmQ=
Received: by 10.216.71.66 with SMTP id q44mr4245246wed.44.1289133514424;
        Sun, 07 Nov 2010 04:38:34 -0800 (PST)
Received: from thorin ([81.38.198.117])
        by mx.google.com with ESMTPS id p4sm2353465wer.5.2010.11.07.04.38.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 04:38:33 -0800 (PST)
Date:   Sun, 07 Nov 2010 13:38:29 +0100
From:   Robert Millan <rmh@gnu.org>
Subject: [PATCH] removed ad-hoc cmdline default
To:     linux-mips@linux-mips.org
X-Mailer: Balsa 2.4.1
Message-Id: <1289133509.1547.1@thorin>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-s9UoF+Gmfng2LtbuSY6p"
Return-Path: <rmh.aybabtu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmh@gnu.org
Precedence: bulk
X-list: linux-mips

--=-s9UoF+Gmfng2LtbuSY6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Loongson builds have an ad-hoc cmdline default of "console=3DttyS0,115200=20
root=3D/dev/hda1". These settings come from vendor (I remember builds=20
from Lemote branch requiring a "console=3Dtty" override in order to get a=20
working console).

At least on my Yeeloong, they're particularly useless: there's no=20
(external) serial port, and the IDE drive is now recognised as /dev/
sda.

I recommend removing them. They make sense from a distributor/vendor=20
POV but otherwise are just a nuissance.


--=-s9UoF+Gmfng2LtbuSY6p
Content-Type: text/x-patch; charset=us-ascii; name=loongson_cmdline.diff
Content-Disposition: attachment; filename=loongson_cmdline.diff
Content-Transfer-Encoding: quoted-printable


Remove ad-hoc cmdline settings.

Signed-off-by: Robert Millan <rmh@gnu.org>

diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/commo=
n/cmdline.c
index 1a06def..353e1d2 100644
--- a/arch/mips/loongson/common/cmdline.c
+++ b/arch/mips/loongson/common/cmdline.c
@@ -44,10 +44,5 @@ void __init prom_init_cmdline(void)
 		strcat(arcs_cmdline, " ");
 	}
=20
-	if ((strstr(arcs_cmdline, "console=3D")) =3D=3D NULL)
-		strcat(arcs_cmdline, " console=3DttyS0,115200");
-	if ((strstr(arcs_cmdline, "root=3D")) =3D=3D NULL)
-		strcat(arcs_cmdline, " root=3D/dev/hda1");
-
 	prom_init_machtype();
 }


--=-s9UoF+Gmfng2LtbuSY6p--
