Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2003 19:38:56 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:23473 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTDQSiz>; Thu, 17 Apr 2003 19:38:55 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA21533;
	Thu, 17 Apr 2003 20:39:29 +0200 (MET DST)
Date: Thu, 17 Apr 2003 20:39:28 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: linux-mips@linux-mips.org
Subject: Re: What is .MIPS.options ELF section?
In-Reply-To: <20030417094759.C1642@mvista.com>
Message-ID: <Pine.GSO.3.96.1030417203540.16154L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 17 Apr 2003, Jun Sun wrote:

> I started to play with the new N32/N64 toolchains.  I notice a new
> section is generated for kernel, called .MIPS.options.  (it actually
> causes some grief for some firmware)

 It's a replacement for the .reginfo section of o32.  See
'ftp://ftp.linux-mips.org/pub/linux/mips/doc/ABI/ELF64.ps' for details. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
