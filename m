Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Apr 2004 22:42:57 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:38802 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225792AbUDPVm4>; Fri, 16 Apr 2004 22:42:56 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 7EFE047607; Fri, 16 Apr 2004 23:42:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 7116D459C1; Fri, 16 Apr 2004 23:42:48 +0200 (CEST)
Date: Fri, 16 Apr 2004 23:42:48 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: IP30 goes relatively far now
In-Reply-To: <Pine.GSO.4.10.10404162305570.25696-100000@helios.et.put.poznan.pl>
Message-ID: <Pine.LNX.4.55.0404162332150.24278@jurand.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10404162305570.25696-100000@helios.et.put.poznan.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 16 Apr 2004, Stanislaw Skowronek wrote:

> I don't know if it's been already fixed in >2.6.1, but in genex.S there
> should be a 'nop' between 'jal do_\handler' and 'ret_from_exception'. The
> symptom is a hang on 'Checking for the daddi bug...'. Somebody apparently
> got used to '.set reorder' :P

 The bug is elsewhere -- there's an incorrect extraneous ".set push" in
the file.  I'll commit a fix immediately.

 Thanks for the report.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
