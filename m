Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 01:12:34 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:49180 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S3466500AbWBCBL5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 01:11:57 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with SMTP; 3 Feb 2006 01:17:10 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id CBA0620336;
	Fri,  3 Feb 2006 10:17:07 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id B730820177;
	Fri,  3 Feb 2006 10:17:07 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k131H64D022123;
	Fri, 3 Feb 2006 10:17:06 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 03 Feb 2006 10:17:05 +0900 (JST)
Message-Id: <20060203.101705.41198541.nemoto@toshiba-tops.co.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <43E25381.4060309@ru.mvista.com>
References: <20060203.013401.41198517.anemo@mba.ocn.ne.jp>
	<43E25381.4060309@ru.mvista.com>
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
X-archive-position: 10315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 02 Feb 2006 21:46:25 +0300, Sergei Shtylylov <sshtylyov@ru.mvista.com> said:
>> If mfc0 $12 follows store and the mfc0 is last instruction of a
>> page and fetching the next instruction causes TLB miss, the result
>> of the mfc0 might wrongly contain EXL bit.

sshtylyov>     Hmm, a TLB miss in fetching from KSEG0?!

We can call these inline functions from modules running on KSEG2.

---
Atsushi Nemoto
