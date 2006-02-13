Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 02:38:00 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:25557 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S3466466AbWBMChu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 02:37:50 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 13 Feb 2006 11:44:03 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 601E01FF65;
	Mon, 13 Feb 2006 11:44:00 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 4D8FA1FF61;
	Mon, 13 Feb 2006 11:44:00 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1D2hx4D069276;
	Mon, 13 Feb 2006 11:43:59 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 13 Feb 2006 11:43:59 +0900 (JST)
Message-Id: <20060213.114359.07641583.nemoto@toshiba-tops.co.jp>
To:	pdh@colonel-panic.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2.6.X] Early console for Cobalt
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060212171025.GB1562@colonel-panic.org>
References: <20060212171025.GB1562@colonel-panic.org>
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
X-archive-position: 10411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sun, 12 Feb 2006 17:10:25 +0000, Peter Horton <pdh@colonel-panic.org> said:
pdh> Adds early console support for Cobalts.

We already have EARLY_PRINTK.  How about using it?  (like dec does)

---
Atsushi Nemoto
