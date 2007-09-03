Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 16:54:08 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:2542 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022925AbXICPxy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2007 16:53:54 +0100
Received: from localhost (p7196-ipad03funabasi.chiba.ocn.ne.jp [219.160.87.196])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 770D5DA50; Tue,  4 Sep 2007 00:52:34 +0900 (JST)
Date:	Tue, 04 Sep 2007 00:54:00 +0900 (JST)
Message-Id: <20070904.005400.52128244.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46DC29F0.3060200@gmail.com>
References: <46D8089F.3010109@gmail.com>
	<20070903.225239.61509667.anemo@mba.ocn.ne.jp>
	<46DC29F0.3060200@gmail.com>
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
X-archive-position: 16361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 03 Sep 2007 17:36:16 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > Now copy_strings() calls this and I'm wondering we should implement or
> > not.  It seems the kernel works fine for me without the API...
>  
> Do you use a cpu with dcache aliasing issue ?

Yes.  4 way 32KB dcache.

> > Do you have any problem due to luck of the API?
> 
> No, but looking at copy_strings(), I think we can have some trouble.
> 
> BTW, do you recall flush_anon_page() and fuse bug ? It seems the same
> here...

Indeed.  But copy_strings() is not rare case (called on each execve),
so there might be some constraints which make us free from the
aliasing problem.  I'll look at it further, but any testcase are
welcome.

---
Atsushi Nemoto
