Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2005 23:26:49 +0000 (GMT)
Received: from mail2.dataflo.net ([IPv6:::ffff:207.252.248.127]:59663 "EHLO
	mail2.dataflo.net") by linux-mips.org with ESMTP
	id <S8224905AbVBOX0e> convert rfc822-to-8bit; Tue, 15 Feb 2005 23:26:34 +0000
Received: (qmail 94660 invoked by uid 1009); 15 Feb 2005 17:26:32 -0600
Received: from elk-righthand-router.dataflo.net (HELO server1.RightHand.righthandtech.com) (207.252.249.22)
  by mail2.dataflo.net with SMTP; 15 Feb 2005 17:26:32 -0600
Subject: swapon failure with au1550
Date:	Tue, 15 Feb 2005 17:09:13 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-ID: <B482D8AA59BF244F99AFE7520D74BF9609D4F0@server1.RightHand.righthandtech.com>
X-MS-Has-Attach: 
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
X-MS-TNEF-Correlator: 
Thread-Topic: swapon failure with au1550
Thread-Index: AcUTs12VqmcQod0AS8mZtpfv1+CwWw==
From:	"Bob Breuer" <bbreuer@righthandtech.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <bbreuer@righthandtech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bbreuer@righthandtech.com
Precedence: bulk
X-list: linux-mips

With the current cvs on an au1550 configured with 64-bit physical
address, I get a kernel oops when trying to activate a swap partition
with swapon.

It looks like mm/swapfile.c line 1385 is hitting the BUG_ON() in both
pte_to_swp_entry() and swp_entry_to_pte().

Bob Breuer
