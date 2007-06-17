Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2007 17:13:55 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:34753 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022997AbXFQQNx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Jun 2007 17:13:53 +0100
Received: from localhost (p1058-ipad201funabasi.chiba.ocn.ne.jp [222.146.64.58])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E83CD9FBA; Mon, 18 Jun 2007 01:13:47 +0900 (JST)
Date:	Mon, 18 Jun 2007 01:14:25 +0900 (JST)
Message-Id: <20070618.011425.93018724.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, macro@linux-mips.org, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80706170636kbff000cw849fa1d5ccf31152@mail.gmail.com>
References: <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>
	<20070615134948.GB16133@linux-mips.org>
	<cda58cb80706170636kbff000cw849fa1d5ccf31152@mail.gmail.com>
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
X-archive-position: 15437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 17 Jun 2007 15:36:53 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> b) Are there some weird MIPS CPUs out there which don't read/ack cp0
> hpt in the normal way ?

PNX8550?  Their count/compare interrupt altomatically clears the count
register.  Please refer this thread:

http://www.linux-mips.org/archives/linux-mips/2006-12/msg00194.html

I'm not sure this fits new clockevent codes or not.

---
Atsushi Nemoto
