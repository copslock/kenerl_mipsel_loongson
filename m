Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 19:34:56 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:12466 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225211AbTDXSez>; Thu, 24 Apr 2003 19:34:55 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA00251;
	Thu, 24 Apr 2003 20:35:18 +0200 (MET DST)
Date: Thu, 24 Apr 2003 20:35:17 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Steven Seeger <sseeger@stellartec.com>
cc: "'Jun Sun'" <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: RE: [patch] wait instruction on vr4181
In-Reply-To: <078a01c30a8c$a4cb9350$3501a8c0@wssseeger>
Message-ID: <Pine.GSO.3.96.1030424202042.24567D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 24 Apr 2003, Steven Seeger wrote:

> Hey, when I try to patch in standby, it says that opcode isn't available for
> the R6000. Why does arch/mips/Makefile use -mcpu=r4600 for the VR41XX?

 I fear you need to handcode the instruction until gas supports some sort
of a CPU override, similar to ".set mips".  Using "-mcpu" or "-march" 
won't help as the code wants to be compiled regardless of the CPU
selection.  Currently gas supports the opcode for VR4100, VR4111 and
VR4120, but there is no way to select any of them except on the command
line. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
