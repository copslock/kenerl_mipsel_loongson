Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2004 06:39:08 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:50203
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224903AbUKDGjC>; Thu, 4 Nov 2004 06:39:02 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 4 Nov 2004 06:39:00 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 0687B239E1A; Thu,  4 Nov 2004 15:38:57 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id iA46cudD024722;
	Thu, 4 Nov 2004 15:38:56 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 04 Nov 2004 15:37:44 +0900 (JST)
Message-Id: <20041104.153744.122623401.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: gcc 3.3.4/3.4.1 and get_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040920171021.GA25371@linux-mips.org>
References: <87656yqsmz.fsf@redhat.com>
	<20040920154042.GB5150@linux-mips.org>
	<20040920171021.GA25371@linux-mips.org>
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
X-archive-position: 6258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 20 Sep 2004 19:10:21 +0200, Ralf Baechle <ralf@linux-mips.org> said:
ralf> And here the same for 2.4.  Actually this is a straight backport
ralf> of the 2.6 uaccess.h to 2.4 so with this patch
ralf> include/asm-mips/uaccess.h and include/asm-mips64/uaccess.h are
ralf> going to be identical.

I found that asm-mips/uaccess.h and asm-mips64/uaccess.h in 2.4 are
sill not identical.  Is this intentional?  Current
asm-mips64/uaccess.h seems broken...

Also, arch/mips64/lib/strxxx_user.S should be modified to use t0/t1
instead of ta0/ta1 ? (__UA_t0 is now $12, not $8)

---
Atsushi Nemoto
