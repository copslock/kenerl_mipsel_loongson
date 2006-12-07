Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 03:17:13 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:4729 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039065AbWLGDRJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 03:17:09 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 7 Dec 2006 12:17:08 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 700AD20752;
	Thu,  7 Dec 2006 12:17:05 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 63AF820488;
	Thu,  7 Dec 2006 12:17:05 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kB73H2W0089697;
	Thu, 7 Dec 2006 12:17:04 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 07 Dec 2006 12:17:02 +0900 (JST)
Message-Id: <20061207.121702.108739943.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80612060040o17ec40f3x4c2f7d0037d3cd1@mail.gmail.com>
References: <20061205194907.GA1088@linux-mips.org>
	<20061205195702.GA2097@linux-mips.org>
	<cda58cb80612060040o17ec40f3x4c2f7d0037d3cd1@mail.gmail.com>
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
X-archive-position: 13387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 6 Dec 2006 09:40:50 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> Atsushi, could you take care of removing "select
> GENERIC_HARDIRQS_NO__DO_IRQ" in your patch where needed ? specially
> all boards based on NEC VR41XX cpu.

You mean "adding" ?  I think now we can select
GENERIC_HARDIRQS_NO__DO_IRQ for all MACH_VR41XX boards.

Also I think most codes in vr41xx/nec-cmbvr4133/irq.c can be removed
if we made I8259A_IRQ_BASE customizable, but that would be another
story...

---
Atsushi Nemoto
