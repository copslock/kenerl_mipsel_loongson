Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2004 07:06:03 +0000 (GMT)
Received: from [IPv6:::ffff:202.230.225.5] ([IPv6:::ffff:202.230.225.5]:53010
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224793AbUCVHGC>; Mon, 22 Mar 2004 07:06:02 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 22 Mar 2004 07:06:00 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i2M75i1x041949;
	Mon, 22 Mar 2004 16:05:44 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 22 Mar 2004 16:06:27 +0900 (JST)
Message-Id: <20040322.160627.41628364.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Cc: ica2_ts@csv.ica.uni-stuttgart.de
Subject: Re: [PATCH, 2.4] Fix bad check_gcc order for mips64, make offset.h
 creation more robust
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040122040759.GB23173@rembrandt.csv.ica.uni-stuttgart.de>
	<20031105.171701.42767326.nemoto@toshiba-tops.co.jp>
References: <20040122040759.GB23173@rembrandt.csv.ica.uni-stuttgart.de>
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
X-archive-position: 4606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Could you remember this two months old patch?

>>>>> On Thu, 22 Jan 2004 05:07:59 +0100, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> said:
Thiemo> current 2.4 64bit kernels fail to build for newer toolchains
Thiemo> because the -finline-limit=100000 option is ignored. The
Thiemo> symptom is some bogus offset.h content which stops the build
Thiemo> in arch/mips64/mm/tlbex-r4k.S.

Or this four months old patch?

>>>>> On Wed, 05 Nov 2003 17:17:01 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> It seems mips64 Makefile does not pass "-finline-limit=100000"
anemo> to gcc.  The "check_gcc" must be defined before used ?


I think this fix is definitely required for 2.4 mips64 tree.  Please
commit to CVS if no problem with this.

---
Atsushi Nemoto
