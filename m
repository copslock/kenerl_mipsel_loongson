Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 16:27:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:22737 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20255614AbYIQP0x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 16:26:53 +0100
Received: from localhost (p3101-ipad302funabasi.chiba.ocn.ne.jp [123.217.141.101])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 19322B6CB; Thu, 18 Sep 2008 00:26:48 +0900 (JST)
Date:	Thu, 18 Sep 2008 00:27:05 +0900 (JST)
Message-Id: <20080918.002705.78730226.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	u1@terran.org, linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
	<20080917.222350.41199051.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl>
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
X-archive-position: 20522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 17 Sep 2008 15:46:56 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > Well, csum_partial()'s return value is __wsum (32-bit).  So strictly
> > there is no need to folding into 16-bit.
> 
>  Hmm, what's the purpose of doing the fold in csum_partial() then?

Well, maybe odd-byte handling requires 16-bit holded values?

---
Atsushi Nemoto
