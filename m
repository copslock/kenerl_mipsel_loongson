Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2005 22:21:12 +0000 (GMT)
Received: from mail2.dataflo.net ([IPv6:::ffff:207.252.248.127]:56847 "EHLO
	mail2.dataflo.net") by linux-mips.org with ESMTP
	id <S8225208AbVBVWU5> convert rfc822-to-8bit; Tue, 22 Feb 2005 22:20:57 +0000
Received: (qmail 66210 invoked by uid 1009); 22 Feb 2005 16:20:54 -0600
Received: from elk-righthand-router.dataflo.net (HELO server1.RightHand.righthandtech.com) (207.252.249.22)
  by mail2.dataflo.net with SMTP; 22 Feb 2005 16:20:54 -0600
content-class: urn:content-classes:message
Subject: RE: swapon failure with au1550
Date:	Tue, 22 Feb 2005 16:20:28 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <B482D8AA59BF244F99AFE7520D74BF9609D4F2@server1.RightHand.righthandtech.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: swapon failure with au1550
Thread-Index: AcUZLLaERrIB9opzSlWlu0VPWdsF7g==
From:	"Bob Breuer" <bbreuer@righthandtech.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <bbreuer@righthandtech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bbreuer@righthandtech.com
Precedence: bulk
X-list: linux-mips

The bitmask in a pte for swap type is 0x0000_1f00.  In the CPU_MIPS32 &&
64BIT_PHYS_ADDR case, _PAGE_FILE is 0x0000_0400.  Since _PAGE_FILE is
set in the maxed out swap type, it triggers a BUG().

If I move the swap type field like this:
  #define __swp_type(x)  (((x).val >> 2) & 0x0f)
then it works for me.  This makes use of the _PAGE_DIRTY and _CACHE_MASK
bits which were being used in the !64BIT_PHYS_ADDR case.

Is this a reasonable solution, or should a different grouping of bits be
used?

Bob Breuer
