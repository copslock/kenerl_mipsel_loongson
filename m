Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Sep 2004 17:49:17 +0100 (BST)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:32645 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225002AbUIGQtN>; Tue, 7 Sep 2004 17:49:13 +0100
Received: by the-doors.enix.org (Postfix, from userid 1105)
	id 082871EFF8; Tue,  7 Sep 2004 18:49:03 +0200 (CEST)
Date: Tue, 7 Sep 2004 18:49:03 +0200
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
To: linux-mips@linux-mips.org
Subject: Missing include/asm-mips/reg.h ?
Message-ID: <20040907164903.GB32393@enix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <thomas@the-doors.enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

Hello,

While trying to compile uClibc, I get an error concerning Linux kernel
headers. The file include/asm-mips/user.h includes the file asm/reg.h,
but the file include/asm-mips/reg.h doesn't exist. So the EF_SIZE symbol
required by the definition of the user structure is not declared.

I checked the linux-mips CVS but couldn't find this file.

How should I proceed ?

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org 
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7
