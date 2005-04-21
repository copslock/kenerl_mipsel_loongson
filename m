Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2005 08:20:07 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:24593
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225072AbVDUHTu>; Thu, 21 Apr 2005 08:19:50 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 21 Apr 2005 07:19:48 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id B0FC21F30A;
	Thu, 21 Apr 2005 16:19:45 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id A4EC51F2F4;
	Thu, 21 Apr 2005 16:19:45 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j3L7Jjoj008950;
	Thu, 21 Apr 2005 16:19:45 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 21 Apr 2005 16:19:45 +0900 (JST)
Message-Id: <20050421.161945.79301612.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	dom@mips.com, macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: ieee754[sd]p_neg workaround
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050420131304.GF5212@linux-mips.org>
References: <Pine.LNX.4.61L.0504201312520.7109@blysk.ds.pg.gda.pl>
	<16998.20933.14301.397793@arsenal.mips.com>
	<20050420131304.GF5212@linux-mips.org>
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
X-archive-position: 7781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 20 Apr 2005 14:13:04 +0100, Ralf Baechle <ralf@linux-mips.org> said:
>> So file a bug against glibc, but we should fix the emulator so it
>> correctly imitates the MIPS instruction set...

ralf> As a matter of defensive design I think we should try to follow
ralf> the establish behaviour if nothing more specific is defined
ralf> anywhere.

OK, I sent a bug reoport to glibc bugzilla. (Bug# 864)

---
Atsushi Nemoto
