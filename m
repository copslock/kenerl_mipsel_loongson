Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 15:16:11 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:48093 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024739AbXIDOQC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 15:16:02 +0100
Received: from localhost (p7110-ipad205funabasi.chiba.ocn.ne.jp [222.146.102.110])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 37C1CD00B; Tue,  4 Sep 2007 23:14:42 +0900 (JST)
Date:	Tue, 04 Sep 2007 23:16:08 +0900 (JST)
Message-Id: <20070904.231608.51867742.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46DD6616.6030303@gmail.com>
References: <46DD53BE.2070004@gmail.com>
	<20070904.225402.106261140.anemo@mba.ocn.ne.jp>
	<46DD6616.6030303@gmail.com>
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
X-archive-position: 16383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 04 Sep 2007 16:05:10 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Yeah, that what I think too and that's also why I was suggesting to
> test a plain 2.6.23-rc5 with the randomize_va_space=0. Please see my
> previous reply...
> 
> Could you give it a try ?

OK, I'll try it in a few days...
---
Atsushi Nemoto
