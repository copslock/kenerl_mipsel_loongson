Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2008 02:07:40 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:63603 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20041957AbYDUBHi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Apr 2008 02:07:38 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for [213.58.128.207] [213.58.128.207]) with ESMTP; Mon, 21 Apr 2008 10:07:36 +0900
Received: from localhost (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with SMTP id 0CFC54742A;
	Mon, 21 Apr 2008 10:07:28 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2A26D47421;
	Mon, 21 Apr 2008 10:07:22 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m3L17LAF091093;
	Mon, 21 Apr 2008 10:07:22 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 21 Apr 2008 10:07:21 +0900 (JST)
Message-Id: <20080421.100721.07644724.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Fix handling of trap and breakpoint instructions
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20041689AbYDUAiN/20080421003813Z+6727@ftp.linux-mips.org>
References: <S20041689AbYDUAiN/20080421003813Z+6727@ftp.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

> Author: Ralf Baechle <ralf@linux-mips.org> Sun Apr 20 16:28:54 2008 +0100
> Commit: 5881bb0de64887a60f7f49922cf73a3b4d40fc01
> Gitweb: http://www.linux-mips.org/g/linux/5881bb0d
> Branch: master

You must drop left shift of this line too.

		if (bcode == (BRK_DIVZERO << 10))

---
Atsushi Nemoto
