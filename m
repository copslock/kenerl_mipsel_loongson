Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 13:26:21 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:25377
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225214AbUJVM0R>; Fri, 22 Oct 2004 13:26:17 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 22 Oct 2004 12:26:15 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 036E3239E36; Fri, 22 Oct 2004 21:26:13 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i9MCQC3i049324;
	Fri, 22 Oct 2004 21:26:12 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 22 Oct 2004 21:25:03 +0900 (JST)
Message-Id: <20041022.212503.39150495.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: kernel_thread creation bug?
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041022121647.GA27961@linux-mips.org>
References: <20041022.170758.48799763.nemoto@toshiba-tops.co.jp>
	<20041022121647.GA27961@linux-mips.org>
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
X-archive-position: 6176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 22 Oct 2004 14:16:48 +0200, Ralf Baechle <ralf@linux-mips.org> said:
>> With recent change in kernel_thread(), initial cp0_status value
>> comes from current C0_STATUS (which does not include EXL bit).  Is
>> this correct?  The initial value should contain EXL bit to start
>> the thread up safely, shouldn't it?

ralf> Yes ...

I see the fix in CVS.  Thank you.

---
Atsushi Nemoto
