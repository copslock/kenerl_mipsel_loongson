Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 11:17:26 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:60196
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224831AbUJEKRV>; Tue, 5 Oct 2004 11:17:21 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 5 Oct 2004 10:17:20 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 7D11E239E2B; Tue,  5 Oct 2004 19:19:58 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i95AHC8G021491;
	Tue, 5 Oct 2004 19:17:12 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 05 Oct 2004 19:16:08 +0900 (JST)
Message-Id: <20041005.191608.59649656.nemoto@toshiba-tops.co.jp>
To: sara@procsys.com
Cc: linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - Assembler errors in rtld.c
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <41626E7D.2070405@procsys.com>
References: <41626E7D.2070405@procsys.com>
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
X-archive-position: 5942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 05 Oct 2004 15:20:53 +0530, "T. P. Saravanan" <sara@procsys.com> said:
sara> glibc-2.2.3 build on mips linux breaks with following assembler errors:
...
sara> /tmp/ccNhjRu0.s: Assembler messages:
sara> /tmp/ccNhjRu0.s:48: Warning: missing .end
sara> /tmp/ccNhjRu0.s:80: Warning: No .frame pseudo-op used in PIC code
sara> /tmp/ccNhjRu0.s:88: Warning: .end directive without a preceding .ent 

This is now fixed in libc CVS.

http://sources.redhat.com/ml/libc-alpha/2004-04/msg00078.html

Also, you might have to pass -fno-unit-at-a-time to gcc 3.4.  (at
least glibc 2.3.2 requires it).

---
Atsushi Nemoto
