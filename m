Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2003 18:38:11 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:24468 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225518AbTIVRiJ>; Mon, 22 Sep 2003 18:38:09 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA28470;
	Mon, 22 Sep 2003 19:38:05 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 22 Sep 2003 19:38:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix character loss in drivers/tc/zs.c
In-Reply-To: <20030921213104.GO13578@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030922193409.25762B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 21 Sep 2003, Thiemo Seufer wrote:

> this patch reduces the zs driver's character lossage.

 Can you please elaborate?  tty is expected to be NULL if info->hook is
not, so the code after the change should not differ effectively -- only a
useless check is added at the end.  Am I missing anything?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
