Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Nov 2004 03:16:47 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:41243
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224943AbUKPDQl>; Tue, 16 Nov 2004 03:16:41 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 16 Nov 2004 03:16:40 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id E3E5B239E1A; Tue, 16 Nov 2004 12:16:35 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id iAG3GZdD075948;
	Tue, 16 Nov 2004 12:16:35 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 16 Nov 2004 12:15:20 +0900 (JST)
Message-Id: <20041116.121520.27957567.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: gcc 3.3.4/3.4.1 and get_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041112134440.GA7588@linux-mips.org>
References: <20040920171021.GA25371@linux-mips.org>
	<20041104.153744.122623401.nemoto@toshiba-tops.co.jp>
	<20041112134440.GA7588@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 12 Nov 2004 14:44:40 +0100, Ralf Baechle <ralf@linux-mips.org> said:
ralf> Right, part of the same mistake.  See the patch below which gets
ralf> my test system working.  The 32-bit parts are cosmetic and
ralf> shouldn't change the generated code.  They just make the 32-bit
ralf> and 64-bit str*_user.S files almost identical.

Thank you.  They work fine.

ralf> I'm surprised somebody still cares about 2.4 64-bit ;-) The
ralf> 64-bit improvments in 2.6, especially in the area of the 32-bit
ralf> compatibility code are so substancial that I don't think 2.4 is
ralf> still a good choice.

Yes, I agree that 2.6 is better.  I just want to run 2.4 64-bit for
comparison from time to time. (only when something failed on 2.6 :-))

---
Atsushi Nemoto
