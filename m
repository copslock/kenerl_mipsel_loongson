Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2004 02:17:17 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:64798
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225305AbUJGBRM>; Thu, 7 Oct 2004 02:17:12 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 7 Oct 2004 01:17:11 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 7AB78239E23; Thu,  7 Oct 2004 10:19:49 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i971H28G029005;
	Thu, 7 Oct 2004 10:17:03 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 07 Oct 2004 10:15:58 +0900 (JST)
Message-Id: <20041007.101558.126571743.nemoto@toshiba-tops.co.jp>
To: jsun@junsun.net
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: fpu_emulator can lose fpu on get_user/put_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041006220936.GA21135@gateway.junsun.net>
References: <20041006.101920.126571873.nemoto@toshiba-tops.co.jp>
	<20041006220936.GA21135@gateway.junsun.net>
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
X-archive-position: 5965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 6 Oct 2004 15:09:36 -0700, Jun Sun <jsun@junsun.net> said:
>> I found a potential problem in math emulation.  The math-emu uses
>> put_user/get_user to fetch the instruction or to emulate load/store
>> fp-regs.  The put_user/get_user can sleep then we can lose fpu
>> ownership on it.  It it happened, subsequent restore_fp will cause
>> CpU exception which not allowed in kernel.

jsun> I don't feel good about this patch.  If emulator loses FPU
jsun> ownership it should get it back, not the caller of emulator.

Hmm... Inserting following 2 lines after each get_user, put_user (and
do_dsemulret, mips_dsemul, cond_resched) in cp1emu.c is better?

	if (!is_fpu_owner())
		own_fpu();

Actually, FPU might be lost in get_user, so get_user should get it
back?  I don't think so.  Similarly, getting it back by the caller of
emulator is not so bad, I think.  Maintenance of FPU ownership is not
emulator's work, isn't it?

---
Atsushi Nemoto
