Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 14:51:27 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:52968 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022415AbXICNvS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2007 14:51:18 +0100
Received: from localhost (p7196-ipad03funabasi.chiba.ocn.ne.jp [219.160.87.196])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5BF0FE2C0; Mon,  3 Sep 2007 22:51:14 +0900 (JST)
Date:	Mon, 03 Sep 2007 22:52:39 +0900 (JST)
Message-Id: <20070903.225239.61509667.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46D8089F.3010109@gmail.com>
References: <46D8089F.3010109@gmail.com>
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
X-archive-position: 16356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 31 Aug 2007 14:25:03 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> I noticed that there's currently (v2.6.23-rc4) no implementation
> of this function even for mips CPUs that have dcache aliasing.
> 
> Could anybody explain why ?

Maybe because the API was not called by anybody until 2.6.23-rc1 :)

Now copy_strings() calls this and I'm wondering we should implement or
not.  It seems the kernel works fine for me without the API...

Do you have any problem due to luck of the API?

---
Atsushi Nemoto
