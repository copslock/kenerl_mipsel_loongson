Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2005 00:53:24 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:13602
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225280AbVAKAxT>; Tue, 11 Jan 2005 00:53:19 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 11 Jan 2005 00:53:16 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 8BD39239E1A; Tue, 11 Jan 2005 09:53:12 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j0B0rCRm026535;
	Tue, 11 Jan 2005 09:53:12 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Tue, 11 Jan 2005 09:53:11 +0900 (JST)
Message-Id: <20050111.095311.126572083.nemoto@toshiba-tops.co.jp>
To: macro@mips.com
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <Pine.LNX.4.61.0501101750420.18023@perivale.mips.com>
References: <Pine.LNX.4.61.0501101503020.18023@perivale.mips.com>
	<20050111.022138.25909508.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.61.0501101750420.18023@perivale.mips.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 10 Jan 2005 18:11:14 +0000 (GMT), "Maciej W. Rozycki" <macro@mips.com> said:
>> Well, maybe the 'volatile' have no sense, but some archs (including
>> i386, of course :-)) and some drivers use it.  Adding the
>> 'volatile' will remove some compiler warnings.

macro>  As will removing "volatile" from broken ports.

Sure.

>> And I have some custom boards which really needs different swapping
>> properties (PCI regions need SWAP_IO_SPACE, but ISA region does
>> not, for example).  I agree that those boards were misdesigned but
>> I want to run Linux on it without modifying existing drivers.

macro>  Hmm, that's strange -- does the system glue ISA otherwise than
macro> behind a PCI-ISA bridge?  So far I've only spotted a single
macro> PCI/ISA system wiring the buses as "peers", namely the ancient
macro> Intel's i82420EX for 486-class processors.

Yes.  The system have ISA devices connected via local bus (like ROMs).
Also I have an another system which have two PCI controllers with
different endian conversion (what mad hardware!).

---
Atsushi Nemoto
