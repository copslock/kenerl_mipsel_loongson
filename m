Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 17:07:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:65271 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023607AbXFSQHd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2007 17:07:33 +0100
Received: from localhost (p2028-ipad208funabasi.chiba.ocn.ne.jp [60.43.103.28])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 32E31A494; Wed, 20 Jun 2007 01:07:27 +0900 (JST)
Date:	Wed, 20 Jun 2007 01:08:05 +0900 (JST)
Message-Id: <20070620.010805.23009775.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, macro@linux-mips.org, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80706190033y47ccec58u8fc8254ced24f96f@mail.gmail.com>
References: <cda58cb80706180238r17da4434jcdee307b0385729b@mail.gmail.com>
	<20070619.005121.118948229.anemo@mba.ocn.ne.jp>
	<cda58cb80706190033y47ccec58u8fc8254ced24f96f@mail.gmail.com>
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
X-archive-position: 15463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 19 Jun 2007 09:33:33 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> What do you mean by "pnx8550 can have customized copy of cp0_hpt
> routines" ? Do you mean that it should copy the whole clock event
> driver ?
>
> It seems to me that using cp0 hpt as a clock event only is a valid usage...

Well, I thought the customized cp0 clockevent codes (custom
.set_next_event routine is needed anyway, isn't it?) would be small
enough.  But I did not investigate deeply.  If generic cp0 hpt can
handle this beast without much bloating, it would be great.

---
Atsushi Nemoto
