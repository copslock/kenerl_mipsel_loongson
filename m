Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 15:27:07 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:47057 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038834AbXBLP1G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2007 15:27:06 +0000
Received: from localhost (p7240-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1C1B5A53B; Tue, 13 Feb 2007 00:25:46 +0900 (JST)
Date:	Tue, 13 Feb 2007 00:25:45 +0900 (JST)
Message-Id: <20070213.002545.03977174.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	vagabon.xyz@gmail.com, fbuihuu@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] signal.c: fix gcc warning on 32 bits kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070212140459.GA9679@linux-mips.org>
References: <20070209210014.GA26939@linux-mips.org>
	<cda58cb80702120101k770e059end43579394206b9d2@mail.gmail.com>
	<20070212140459.GA9679@linux-mips.org>
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
X-archive-position: 14048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 12 Feb 2007 14:04:59 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > How about this instead ?
> 
> Won't work for a pointer to some const thing.

And recent commit 4ed3a77f38c023658784804cb39a7ce18063dc88 reverts
commit 3218357c94af92478ef39163163a81e654385320.

Round and round and round and ...

---
Atsushi Nemoto
