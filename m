Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 13:54:34 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:21910 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225272AbSLQNyd>; Tue, 17 Dec 2002 13:54:33 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA09483;
	Tue, 17 Dec 2002 14:54:46 +0100 (MET)
Date: Tue, 17 Dec 2002 14:54:45 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: compute_return_epc
In-Reply-To: <20021217134333.A26119@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021217145149.7289B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Dec 2002, Ralf Baechle wrote:

> So I'd like to apply the following patch which limits the use of
> compute_return_epc to those cases where we actually did some sort of
> instruction emulation.  Comments?

 Ah, finally!  Thanks for offloading the task from me. ;-) 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
