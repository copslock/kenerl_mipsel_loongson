Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 15:50:57 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:20968 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3465572AbWAWPuj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 15:50:39 +0000
Received: from localhost (p2198-ipad02funabasi.chiba.ocn.ne.jp [61.214.22.198])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 70E2FA2B4; Tue, 24 Jan 2006 00:54:50 +0900 (JST)
Date:	Tue, 24 Jan 2006 00:54:24 +0900 (JST)
Message-Id: <20060124.005424.112260730.anemo@mba.ocn.ne.jp>
To:	pulsar@kpsws.com
Cc:	linux-mips@linux-mips.org, niels.sterrenburg@philips.com
Subject: Re: "useless" pgprot_noncached define in include/asm-mips/pgtable.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <49175.194.171.252.101.1137674027.squirrel@mail.kpsws.com>
References: <Pine.LNX.4.62.0601191100001.21230@pademelon.sonytel.be>
	<200601191230.59347.p_christ@hol.gr>
	<49175.194.171.252.101.1137674027.squirrel@mail.kpsws.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 19 Jan 2006 13:33:47 +0100 (CET), "Niels Sterrenburg" <pulsar@kpsws.com> said:

pulsar> #define pgprot_noncached pgprot_noncached
pulsar> Was there any ideas behind this code or can it be removed ?

There are some codes testing whether pgprot_noncached is defined or
not.  Please see phys_mem_access_prot() in drivers/char/mem.c.

---
Atsushi Nemoto
