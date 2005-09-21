Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2005 16:45:18 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:7126 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225417AbVIUPo6>; Wed, 21 Sep 2005 16:44:58 +0100
Received: from localhost (p8015-ipad210funabasi.chiba.ocn.ne.jp [58.88.127.15])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 7F1258522
	for <linux-mips@linux-mips.org>; Thu, 22 Sep 2005 00:44:53 +0900 (JST)
Date:	Thu, 22 Sep 2005 00:43:27 +0900 (JST)
Message-Id: <20050922.004327.74753021.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: sparse for mips
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 9013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Hi.  I got following error on make C=1

  CHECK   /home/anemo/linux/scripts/mod/empty.c
No such file: 0

It seems sparse can not handle '-G 0' option correctly.  I'm using
this snapshot:

http://www.codemonkey.org.uk/projects/git-snapshots/sparse/sparse-2005-09-21.tar.gz

Is there any trick to run sparse on mips?

Thank you.
---
Atsushi Nemoto
