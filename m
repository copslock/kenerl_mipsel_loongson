Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 17:46:26 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:34982 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225240AbTDNQqZ>; Mon, 14 Apr 2003 17:46:25 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA28707;
	Mon, 14 Apr 2003 18:46:55 +0200 (MET DST)
Date: Mon, 14 Apr 2003 18:46:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [patch] Board bus error handler clean-ups
In-Reply-To: <20030414181421.E9808@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030414184531.24742O-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 14 Apr 2003, Ralf Baechle wrote:

> Yes, please apply,

 So in it went, together with a handler for ECC-capable DECstations (if
anyone else cares). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
