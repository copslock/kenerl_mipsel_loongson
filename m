Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2006 13:55:47 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:6386 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133790AbWGIMzi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 9 Jul 2006 13:55:38 +0100
Received: from localhost (p7197-ipad202funabasi.chiba.ocn.ne.jp [222.146.78.197])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 905E7A741; Sun,  9 Jul 2006 21:55:33 +0900 (JST)
Date:	Sun, 09 Jul 2006 21:56:51 +0900 (JST)
Message-Id: <20060709.215651.126573568.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80607080915h59f2fcc0yff605fb4afdf1b8b@mail.gmail.com>
References: <cda58cb80607080739i772d439dqc4e06a8b275e03ee@mail.gmail.com>
	<20060709.010316.126574153.anemo@mba.ocn.ne.jp>
	<cda58cb80607080915h59f2fcc0yff605fb4afdf1b8b@mail.gmail.com>
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
X-archive-position: 11953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 8 Jul 2006 18:15:52 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> well I would say without this patch it should break.
> 
> 'pfn' takes values between 0 and max_mapnr. This range includes memory
> holes, doens't it ? In that case what does
> pfn_to_page(pfn_inside_a_hole) ?

Oh, you are right.  The show_mem() must be fixed indeed.

---
Atsushi Nemoto
