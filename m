Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 11:05:13 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:15114
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225072AbTHLKFL>; Tue, 12 Aug 2003 11:05:11 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 12 Aug 2003 10:05:09 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h7CA522S000664
	for <linux-mips@linux-mips.org>; Tue, 12 Aug 2003 19:05:02 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 12 Aug 2003 19:06:36 +0900 (JST)
Message-Id: <20030812.190636.39150536.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030812065118.GD23104@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp>
	<20030812065118.GD23104@rembrandt.csv.ica.uni-stuttgart.de>
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
X-archive-position: 3031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 12 Aug 2003 08:51:18 +0200, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> said:
>> The option -march=r4600 seems to make gcc 3.3.x choose
>> MIPS_ISA_MIPS3.

Thiemo> Which is ok, because the available ISA has little to do with
Thiemo> the actually used register width.

Thiemo> If the intention is to use mfc0 for 32bit kernels and dmfc0
Thiemo> for 64bit, the check should probably be

Thiemo> #ifdef __mips64
Thiemo> # define MFC0		dmfc0
Thiemo> # define MTC0		dmtc0
Thiemo> #else
Thiemo> # define MFC0		mfc0
Thiemo> # define MTC0		mtc0
Thiemo> #endif

Thanks for your explanations.  Perhaps the code should be fixed is
__BUILD_clear_ade in entry.S, but I'm not sure.  Does anybody know why
__BUILD_clear_ade uses MFC0 and REG_S though other parts using mfc0
and sw ?
