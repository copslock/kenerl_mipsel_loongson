Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 07:23:12 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:23556
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225202AbTDNGXL>; Mon, 14 Apr 2003 07:23:11 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 14 Apr 2003 06:23:10 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.8/8.12.8) with ESMTP id h3E6N22D002799;
	Mon, 14 Apr 2003 15:23:02 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 14 Apr 2003 15:29:03 +0900 (JST)
Message-Id: <20030414.152903.41628304.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: nemoto@toshiba-tops.co.jp, linux-mips@linux-mips.org
Subject: Re: End c-tx49.c's misserable existence
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030414055038.A29923@linux-mips.org>
References: <20030412163215Z8225197-1272+1264@linux-mips.org>
	<20030414.123514.74756574.nemoto@toshiba-tops.co.jp>
	<20030414055038.A29923@linux-mips.org>
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
X-archive-position: 2016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 14 Apr 2003 05:50:38 +0200, Ralf Baechle <ralf@linux-mips.org> said:
ralf> Excellent.  This should provide a good performance boost for the
ralf> TX49 also as disabling the I-cache during the flush made the
ralf> operation even slower than it has to be.

Thank you for quick response.

One more request.  Please enclose R4600_V1_HIT_CACHEOP_WAR and
R4600_V2_HIT_CACHEOP_WAR with appropriate CONFIG_CPU_XXX.  I do not
know what CPUs need this workaround... (at least TX49 does not need
this)

---
Atsushi Nemoto
