Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9MAuZF31127
	for linux-mips-outgoing; Mon, 22 Oct 2001 03:56:35 -0700
Received: from ns5.sony.co.jp (NS5.Sony.CO.JP [146.215.0.105])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9MAuWD31124
	for <linux-mips@oss.sgi.com>; Mon, 22 Oct 2001 03:56:32 -0700
Received: from mail3.sony.co.jp (GateKeeper8.Sony.CO.JP [146.215.0.71])
	by ns5.sony.co.jp (R8/Sony) with ESMTP id f9MAuLL92717;
	Mon, 22 Oct 2001 19:56:21 +0900 (JST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8) with ESMTP id f9MAuL102961;
	Mon, 22 Oct 2001 19:56:21 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail3.sony.co.jp (R8) with ESMTP id f9MAuK202941;
	Mon, 22 Oct 2001 19:56:20 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id UAA29581; Mon, 22 Oct 2001 20:00:40 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id TAA17366; Mon, 22 Oct 2001 19:56:19 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id f9MAuJe12238; Mon, 22 Oct 2001 19:56:19 +0900 (JST)
To: alan@lxorguk.ukuu.org.uk
Cc: ralf@uni-koblenz.de, linux-mips@oss.sgi.com
Subject: Re: csum_ipv6_magic()
In-Reply-To: <E15vZvr-000138-00@the-village.bc.nu>
References: <20011022151606V.machida@sm.sony.co.jp>
	<E15vZvr-000138-00@the-village.bc.nu>
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011022195619A.machida@sm.sony.co.jp>
Date: Mon, 22 Oct 2001 19:56:19 +0900
From: Machida Hiroyuki <machida@sm.sony.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: csum_ipv6_magic()
Date: Mon, 22 Oct 2001 08:55:35 +0100 (BST)

> > I guess that csum_ipv6_magic() in include/asm-mips/checksum.h 
> > needs "addu %0, $1" at the next of "sltu $1, %0, $1".
> > Without this, you cannot add a carry of the last addtion.
> 
> Is that actually needed. The final end around carry cannot itself cause
> a second carry.

I don't know csum_ipv6_magic() in include/asm-mips/checksum.h works
fine or not. But if csum_ipv6_magic() doesn't need "addu %0, $1" at
next of the final "sltu $1, %0, $1", you can remove the final 
"sltu $1, %0, $1".

---
Hiroyuki Machida
Sony Corp.
