Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2005 05:46:36 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:35603
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224914AbVAKFqb>; Tue, 11 Jan 2005 05:46:31 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 11 Jan 2005 05:46:30 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id B7B9E239E3B; Tue, 11 Jan 2005 14:46:27 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j0B5kRRm027645;
	Tue, 11 Jan 2005 14:46:27 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 11 Jan 2005 14:46:27 +0900 (JST)
Message-Id: <20050111.144627.11594416.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: cpu_has_64bits vs. cpu_has_64bit_addresses
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 6876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Hi.  I found that __ioremap_mode() uses cpu_has_64bit_addresses and
iounmap() uses cpu_has_64bits.  Is this intentional?  Or iounmap()
should be fixed?

---
Atsushi Nemoto
