Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 15:19:30 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:34567
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225464AbTISOTS>; Fri, 19 Sep 2003 15:19:18 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 19 Sep 2003 14:19:16 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h8JEIvgc080101;
	Fri, 19 Sep 2003 23:18:57 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 19 Sep 2003 23:21:23 +0900 (JST)
Message-Id: <20030919.232123.38717932.nemoto@toshiba-tops.co.jp>
To: macro@ds2.pg.gda.pl
Cc: linux-mips@linux-mips.org
Subject: Re: mips64 cpu-probe.c compile failure
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.GSO.3.96.1030919132308.9134B-100000@delta.ds2.pg.gda.pl>
References: <20030918.232202.07646481.anemo@mba.ocn.ne.jp>
	<Pine.GSO.3.96.1030919132308.9134B-100000@delta.ds2.pg.gda.pl>
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
X-archive-position: 3229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 19 Sep 2003 13:55:45 +0200 (MET DST), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
macro>  Well, the asm statement requires immediates, so if macros are
macro> used variables won't work anyway, but the the code will look
macro> more obscurely.

Yes, though variables won't work anyway, the inline function looks
like it can accept variables (for careless reader).  But that's just
my impression.

macro>  It looks like gcc insists on forcing the constants into
macro> registers.  The following patch should work for gcc 3.x.  A few
macro> warnings will still be emitted, but the code will get build
macro> properly.

Thanks.  It works fine with gcc 3.3.1.
---
Atsushi Nemoto
