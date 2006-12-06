Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 01:28:47 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:42232 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039115AbWLFB2n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 01:28:43 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 6 Dec 2006 10:28:42 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2C21421F8B;
	Wed,  6 Dec 2006 10:28:35 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 176C72043A;
	Wed,  6 Dec 2006 10:28:35 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kB61SYW0084533;
	Wed, 6 Dec 2006 10:28:34 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 06 Dec 2006 10:28:33 +0900 (JST)
Message-Id: <20061206.102833.126141309.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4575A364.1010703@innova-card.com>
References: <20061206.012311.86891097.anemo@mba.ocn.ne.jp>
	<4575A364.1010703@innova-card.com>
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
X-archive-position: 13358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 05 Dec 2006 17:50:44 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Does your patch make the following patch out of date (I sent
> it to the list 4 days ago) ?
> 
> [PATCH] Compile __do_IRQ() when really needed [take #3]

Your patch should have no problem as is, but you might be able to add
more "select GENERIC_HARDIRQS_NO__DO_IRQ" after my patch.

---
Atsushi Nemoto
