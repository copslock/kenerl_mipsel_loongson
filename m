Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2007 16:15:43 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:44258 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038726AbXBNQPm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Feb 2007 16:15:42 +0000
Received: from localhost (p1218-ipad205funabasi.chiba.ocn.ne.jp [222.146.96.218])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B3BCE9164; Thu, 15 Feb 2007 01:14:20 +0900 (JST)
Date:	Thu, 15 Feb 2007 01:14:20 +0900 (JST)
Message-Id: <20070215.011420.15247947.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [PATCH 2/3] Automatically set CONFIG_BUILD_ELF64
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80702140020l319b987agc88e87c3acaa5e07@mail.gmail.com>
References: <cda58cb80702130909u2c0cbe8fg6929fc78ca8d3cb8@mail.gmail.com>
	<20070214.102801.41198530.nemoto@toshiba-tops.co.jp>
	<cda58cb80702140020l319b987agc88e87c3acaa5e07@mail.gmail.com>
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
X-archive-position: 14092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 14 Feb 2007 09:20:22 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> That's a good point. What about replacing BUILD by KBUILD meaning this
> macro is coming from Kbuild itsel ?

No objections.

> And maybe it would be interesting to make obvious that this macro
> implies 64-bits kernel. What about something like KBUILD_64BIT_SYM32
> and replace 'BUILD_ELF32=no' by 'KBUILD_SYM32=no' ?

Same here.  I just think introducing one name is better than two name.
I also feel "make KBUILD_SYM32=0" is more consistent.

---
Atsushi Nemoto
