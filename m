Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 May 2004 07:32:47 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:41671 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225375AbUEUGcg>; Fri, 21 May 2004 07:32:36 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id E90D74B69E; Fri, 21 May 2004 08:32:32 +0200 (CEST)
Date: Fri, 21 May 2004 08:32:32 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: [zli4@cs.uiuc.edu: [OPERA] Another potential bug in /arch/mips/kernel/sysirix.c]
Message-ID: <20040521063232.GL1912@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1KBBbqQMyIFUBNXy"
Content-Disposition: inline
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--1KBBbqQMyIFUBNXy
Content-Type: multipart/mixed; boundary="EIfQsdwoOfRLryR6"
Content-Disposition: inline


--EIfQsdwoOfRLryR6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This just came in by lkml. Forwarded in the hope of catching Ralf's
eyes:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--EIfQsdwoOfRLryR6
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <linux-kernel-owner+jbglaw=40lug-owl.de-S265184AbUETW20@vger.kernel.org>
X-Original-To: jbglaw@lug-owl.de
Delivered-To: jbglaw@lug-owl.de
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244])
	by dvmwest.gt.owl.de (Postfix) with ESMTP id 20E164B6D1
	for <jbglaw@lug-owl.de>; Fri, 21 May 2004 00:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265184AbUETW20 (ORCPT <rfc822;jbglaw@lug-owl.de>);
	Thu, 20 May 2004 18:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUETW20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:28:26 -0400
Received: from dcs-server2.cs.uiuc.edu ([128.174.252.3]:47330 "EHLO
	dcs-server2.cs.uiuc.edu") by vger.kernel.org with ESMTP
	id S265184AbUETW2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:28:23 -0400
Received: from Turandot (turandot.cs.uiuc.edu [128.174.246.118])
	(authenticated bits=0)
	by dcs-server2.cs.uiuc.edu (8.12.10/8.12.10) with ESMTP id i4KMSMgn020818
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 May 2004 17:28:22 -0500 (CDT)
From: "Zhenmin Li" <zli4@cs.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [OPERA] Another potential bug in /arch/mips/kernel/sysirix.c
Date: Thu, 20 May 2004 17:26:36 -0500
Message-ID: <001801c43eb9$835b09f0$76f6ae80@Turandot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on mail
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=4.0 tests=BAYES_00 autolearn=ham 
	version=2.63
X-Spam-Report: 
	* -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]

We ran our bug detection tool upon Linux 2.6.6, and found some potential
errors. 
We would sincerely appreciate your help if anyone can confirm whether they
are bugs or not.


Linux 2.6.6, /arch/mips/kernel/sysirix.c, Line 1642

1634 asmlinkage int irix_statvfs64(char *fname, struct irix_statvfs64 *buf)
1635 {
1636         struct nameidata nd;
1637         struct kstatfs kbuf;
1638         int error, i;
1639
1640         printk("[%s:%d] Wheee.. irix_statvfs(%s,%p)\n",
1641                current->comm, current->pid, fname, buf);
!1642         error = verify_area(VERIFY_WRITE, buf, sizeof(struct
irix_statvfs));
1643         if(error)
1644                 goto out;


May be changed to:
1634 asmlinkage int irix_statvfs64(char *fname, struct irix_statvfs64 *buf)
1635 {
1636         struct nameidata nd;
1637         struct kstatfs kbuf;
1638         int error, i;
1639
1640         printk("[%s:%d] Wheee.. irix_statvfs(%s,%p)\n",
1641                current->comm, current->pid, fname, buf);
!1642         error = verify_area(VERIFY_WRITE, buf, sizeof(struct
irix_statvfs64));
1643         if(error)
1644                 goto out;



Thanks a lot,
OPERA Research Group
University of Illinois at Urbana-Champaign




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--EIfQsdwoOfRLryR6--

--1KBBbqQMyIFUBNXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAraKAHb1edYOZ4bsRAgS7AKCMMtcG7IH9W8lS21CyoH5a4bRMDgCcDhzi
F+Q4Q8Rm/5vydS/wz5m+p9M=
=Qr+x
-----END PGP SIGNATURE-----

--1KBBbqQMyIFUBNXy--
