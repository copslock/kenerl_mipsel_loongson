Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2003 03:21:22 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:42533
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225201AbTDQCVQ>; Thu, 17 Apr 2003 03:21:16 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 17 Apr 2003 02:21:15 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h3H2KwNr004901;
	Thu, 17 Apr 2003 11:20:58 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 17 Apr 2003 11:27:04 +0900 (JST)
Message-Id: <20030417.112704.74755522.nemoto@toshiba-tops.co.jp>
To: macro@ds2.pg.gda.pl
Cc: anemo@mba.ocn.ne.jp, kevink@mips.com, linux-mips@linux-mips.org,
	source@mvista.com
Subject: Re: wbflush() abuse for TOSHIBA_RBTX4927
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.GSO.3.96.1030416153600.2017A-100000@delta.ds2.pg.gda.pl>
References: <20030416.205256.63134579.nemoto@toshiba-tops.co.jp>
	<Pine.GSO.3.96.1030416153600.2017A-100000@delta.ds2.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 16 Apr 2003 15:46:54 +0200 (MET DST), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
>> AFAIK TX49's SYNC instruction correctly flushes the write buffer.

macro>  That would be an overkill; we only need to enforce strong
macro> ordering here.

Hmm... But SYNC is a only TX49 instruction that enforce completions of
preceding read operations.  (TX49 have "non-blocking load" feature
which allows non-cached read/write to overtake preceding cached read)

I can imagine three configurations:

1. Enable CONFIG_CPU_HAS_SYNC and disable CONFIG_CPU_HAS_WB.  In this
   case, wmb/rmb/mb/iob/wbflush macro all issues a SYNC instruction.

2. Disable CONFIG_CPU_HAS_SYNC and enable CONFIG_CPU_HAS_WB, In this
   case, wmb/rmb macro does nothing and mb/iob/wbflush macro calls
   __wbflush().

3. Enable both CONFIG_CPU_HAS_SYNC and CONFIG_CPU_HAS_WB, In this
   case, wmb/rmb macro issues a SYNC instruction, mb/iob macro calls
   __wbflush() and wbflush macro do both.

In the case 2 and 3, __wbflush() must be implemented with SYNC instruction
and/or bc0f loop.

I think the case 1 is good and enough for TX49.

>> No bc0f loop is required.

macro>  But an external buffer may be attached to a TX49 core, IIRC,
macro> so if it is the case for TOSHIBA_RBTX4927, it's obviously
macro> needed.

Although I'm not sure whether TX49 core can be integrated with such an
external write buffer, all TX49XX (not TX39) I have ever seen does not
have it.

---
Atsushi Nemoto
