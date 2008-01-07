Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 15:32:20 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:29143 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28574265AbYAGPcL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Jan 2008 15:32:11 +0000
Received: from localhost (p7144-ipad210funabasi.chiba.ocn.ne.jp [58.88.126.144])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E69DE95A9; Tue,  8 Jan 2008 00:32:05 +0900 (JST)
Date:	Tue, 08 Jan 2008 00:34:35 +0900 (JST)
Message-Id: <20080108.003435.126573280.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	gregor.waltz@raritan.com, linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080107122156.GB24700@linux-mips.org>
References: <477EB2EA.7060009@raritan.com>
	<20080105.234256.25910407.anemo@mba.ocn.ne.jp>
	<20080107122156.GB24700@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 7 Jan 2008 12:21:56 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> Well, is mmiowb() needed at all on JMR3927 - or R3000 in general?  Mmiowb()
> is meant to deal with weak ordering which only matters to a few SMP
> configurations.

Well, serial_txx9 driver (mis)use mmiowb() to flush write buffer.

But I was wrong.  TX39H2 core _has_ SYNC instruction.  So the patch I
mentioned is not required for JMR3927 platform anyway.  Sorry for
confusion.

---
Atsushi Nemoto
