Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 02:24:58 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:8742
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225762AbVDSBYm>; Tue, 19 Apr 2005 02:24:42 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 19 Apr 2005 01:24:41 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9D56C1F2BC;
	Tue, 19 Apr 2005 10:24:38 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 8884E1D1CC;
	Tue, 19 Apr 2005 10:24:38 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j3J1Ob9c092303;
	Tue, 19 Apr 2005 10:24:37 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 19 Apr 2005 10:24:37 +0900 (JST)
Message-Id: <20050419.102437.78704892.nemoto@toshiba-tops.co.jp>
To:	jsun@junsun.net
Cc:	vksavl@cityline.ru, linux-mips@linux-mips.org, mlachwani@mvista.com
Subject: Re: Preemption in do_cpu
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050418212021.GA12996@gw.junsun.net>
References: <1098468403.4266.42.camel@prometheus.mvista.com>
	<1807918959.20050418133246@cityline.ru>
	<20050418212021.GA12996@gw.junsun.net>
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
X-archive-position: 7757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 18 Apr 2005 14:20:21 -0700, Jun Sun <jsun@junsun.net> said:
jsun> fpu_emulator maintains global variables and in general is
jsun> dangerous to be preempted in the middle of processing.

jsun> The quick fix for this problem is probably to move preemption
jsun> disabling/ enabling inside fpu_emulator_cop1Handler().

Also, get_user/put_user should not be used with preempt disabled.

Here is Quick and dirty workaround (including some other preemption fixes):

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20041025.003619.92586674.anemo%40mba.ocn.ne.jp

jsun> Better fix is probably to modify fpu emulator so that it is
jsun> preemption safe overall.

Sure.  It will make fpu emulator SMP safe also.

---
Atsushi Nemoto
