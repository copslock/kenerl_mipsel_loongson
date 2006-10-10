Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 16:27:05 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:64250 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039895AbWJJP1C (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 16:27:02 +0100
Received: from localhost (p3213-ipad213funabasi.chiba.ocn.ne.jp [124.85.68.213])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 78961A56E; Wed, 11 Oct 2006 00:26:58 +0900 (JST)
Date:	Wed, 11 Oct 2006 00:29:14 +0900 (JST)
Message-Id: <20061011.002914.76462350.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ths@networkno.de, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of
 CPHYSADDR()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <452BB5E1.5090308@innova-card.com>
References: <452BA4E7.30901@innova-card.com>
	<20061010.231944.42203018.anemo@mba.ocn.ne.jp>
	<452BB5E1.5090308@innova-card.com>
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
X-archive-position: 12872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 10 Oct 2006 17:01:53 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > I think this peice of code is just broken, as you said.  This is bogus
> > but harmless since we have not checked these resources are
> > successfully registered or not.
> 
> what about all other uses of virt_to_phys(x) ? And what the point to set
> PAGE_OFFSET to 0xa800000000000000 ? I'm really confused...

For now I have not seen any problem on other usages.

We can use large flat mapping space in XKPHYS.  No TLB conversion, no
highmem trick.

---
Atsushi Nemoto
