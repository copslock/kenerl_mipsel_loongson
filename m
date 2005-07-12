Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 09:28:07 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:64285
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8226402AbVGLI1u>; Tue, 12 Jul 2005 09:27:50 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 12 Jul 2005 08:28:49 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 3E3181F489;
	Tue, 12 Jul 2005 17:28:43 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 28CA71F487;
	Tue, 12 Jul 2005 17:28:43 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j6C8Sgoj068449;
	Tue, 12 Jul 2005 17:28:42 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 12 Jul 2005 17:28:42 +0900 (JST)
Message-Id: <20050712.172842.79300034.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	djohnson+linuxmips@sw.starentnetworks.com,
	linux-mips@linux-mips.org
Subject: Re: preempt_schedule_irq missing from mfinfo[]?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050706090138.GC3226@linux-mips.org>
References: <20050705200308.GE18772@linux-mips.org>
	<20050706.122912.71087098.nemoto@toshiba-tops.co.jp>
	<20050706090138.GC3226@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 6 Jul 2005 10:01:38 +0100, Ralf Baechle <ralf@linux-mips.org> said:
>> You can find the caller of "schedule()" even with simple
>> thread_saved_pc().  I think it is enough so I do not think it is
>> worth to fix (and maintain) current minfo[].

ralf> The alternative would be to finally bite the bullet and add a
ralf> wchan field to thread_struct and initialize it in all the
ralf> sleeping functions.

ralf> The IA-64 people have something like a DWARF-based frame
ralf> unwinder but that just seems to heavy.

Another alternative would be:

1.  Using KALLSYMS feature in kernel to obtain an address in
__sched/__lock function.  This might solve static function (and
maintainance) issue.

2.  Unwinding stack based on "addiu sp,sp,-NN" instruction in prologue
of the function.  This might solve omit-frame-pointer issue.

Anybody try? :-)

---
Atsushi Nemoto
