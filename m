Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9N57Ve25455
	for linux-mips-outgoing; Mon, 22 Oct 2001 22:07:31 -0700
Received: from ns5.sony.co.jp (NS5.Sony.CO.JP [146.215.0.105])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9N57PD25451;
	Mon, 22 Oct 2001 22:07:25 -0700
Received: from mail1.sony.co.jp (GateKeeper8.Sony.CO.JP [146.215.0.71])
	by ns5.sony.co.jp (R8/Sony) with ESMTP id f9N57OL21478;
	Tue, 23 Oct 2001 14:07:24 +0900 (JST)
Received: from mail1.sony.co.jp (localhost [127.0.0.1])
	by mail1.sony.co.jp (R8) with ESMTP id f9N57NZ06680;
	Tue, 23 Oct 2001 14:07:23 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail1.sony.co.jp (R8) with ESMTP id f9N57Na06666;
	Tue, 23 Oct 2001 14:07:23 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id OAA29559; Tue, 23 Oct 2001 14:11:42 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id OAA19052; Tue, 23 Oct 2001 14:07:22 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id f9N57Me14080; Tue, 23 Oct 2001 14:07:22 +0900 (JST)
To: ralf@oss.sgi.com
Cc: alan@lxorguk.ukuu.org.uk, linux-mips@oss.sgi.com
Subject: Re: csum_ipv6_magic()
In-Reply-To: <20011022224828.A20032@dea.linux-mips.net>
References: <20011022195619A.machida@sm.sony.co.jp>
	<20011022203324G.machida@sm.sony.co.jp>
	<20011022224828.A20032@dea.linux-mips.net>
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011023140722J.machida@sm.sony.co.jp>
Date: Tue, 23 Oct 2001 14:07:22 +0900
From: Machida Hiroyuki <machida@sm.sony.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


From: Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: csum_ipv6_magic()
Date: Mon, 22 Oct 2001 22:48:28 +0200

> > * (csum_ipv6_magic): Have same paramter types as net/checksum.h.
> >   Correct carry computation.  Add a final carry.
> 
> The len argument of that prototype should be __u32 because of IPv6
> jumbograms.

I suppose csum_ipv6_magic() in include/net/checksum.h should have __u32
len. Please update include/net/checksum.h to avoid confusion.

Thanks.

---
Hiroyuki Machida
Sony Corp.
