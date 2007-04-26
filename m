Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2007 09:50:04 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:4992 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20023300AbXDZIuC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Apr 2007 09:50:02 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 26 Apr 2007 17:50:01 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 1E4D123CD0;
	Thu, 26 Apr 2007 17:49:54 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 0B22F20457;
	Thu, 26 Apr 2007 17:49:54 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l3Q8nrW0023337;
	Thu, 26 Apr 2007 17:49:53 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 26 Apr 2007 17:49:53 +0900 (JST)
Message-Id: <20070426.174953.11964712.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Fix kunmap_coherent() usage.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20022608AbXCYMav/20070325123051Z+2132@ftp.linux-mips.org>
References: <S20022608AbXCYMav/20070325123051Z+2132@ftp.linux-mips.org>
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
X-archive-position: 14909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 25 Mar 2007 13:30:46 +0100, linux-mips@linux-mips.org wrote:
> Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp> Sun Mar 25 02:10:10 2007 +0900
> Comitter: Ralf Baechle <ralf@linux-mips.org> Sun Mar 25 02:06:30 2007 +0100
> Commit: 116e34f274dabaf989e4c1c021c4be49f85294e5
> Gitweb: http://www.linux-mips.org/g/linux/116e34f2
> Branch: master

I just found this commit is not exist in Linus's tree.  Anyway it is
harmless and will be overwritten by an another cleanup in linux-queue
tree.

---
Atsushi Nemoto
