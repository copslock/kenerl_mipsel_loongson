Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 12:47:49 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:18697
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225278AbTDPLrS>; Wed, 16 Apr 2003 12:47:18 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 16 Apr 2003 11:47:16 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h3GBkqNr003376;
	Wed, 16 Apr 2003 20:46:52 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 16 Apr 2003 20:52:56 +0900 (JST)
Message-Id: <20030416.205256.63134579.nemoto@toshiba-tops.co.jp>
To: macro@ds2.pg.gda.pl
Cc: kevink@mips.com, linux-mips@linux-mips.org, source@mvista.com
Subject: Re: wbflush() abuse for TOSHIBA_RBTX4927
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.GSO.3.96.1030415180933.13254I-100000@delta.ds2.pg.gda.pl>
References: <00ae01c3035e$d431aba0$10eca8c0@grendel>
	<Pine.GSO.3.96.1030415180933.13254I-100000@delta.ds2.pg.gda.pl>
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
X-archive-position: 2073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 15 Apr 2003 18:25:38 +0200 (MET DST), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
>> I remember that some of the Toshiba parts of the TX39 series
>> had some interesting quirks relating to the write buffer.  Perhaps
>> some of these were carried into the TX49 series as well?

macro> I suppose that's unrelated, since I'm specifically referring to
macro> the way the buffer is handled in the TOSHIBA_RBTX4927 code --
macro> the __wbflush() backend is not invoked by wbflush() and calls
macro> like mb() (used by portable drivers) unless the kernel is
macro> configured in an unobvious way and then there is duplicate
macro> "sync" (but maybe that's needed, thus my question among
macro> others).

I suppose it's just because the code was written before
CONFIG_CPU_HAS_SYNC was introduced.

AFAIK TX49's SYNC instruction correctly flushes the write buffer.
No bc0f loop is required.

---
Atsushi Nemoto
