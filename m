Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3U14KwJ026442
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 29 Apr 2002 18:04:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3U14KNl026441
	for linux-mips-outgoing; Mon, 29 Apr 2002 18:04:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ns5.sony.co.jp (NS5.Sony.CO.JP [146.215.0.45])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3U14FwJ026438
	for <linux-mips@oss.sgi.com>; Mon, 29 Apr 2002 18:04:16 -0700
Received: from mail3.sony.co.jp (mail3.sony.co.jp [43.0.1.203])
	by ns5.sony.co.jp (R8/Sony) with ESMTP id g3U14wL67525;
	Tue, 30 Apr 2002 10:04:58 +0900 (JST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id g3U14vt03520;
	Tue, 30 Apr 2002 10:04:57 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id g3U14vL03516;
	Tue, 30 Apr 2002 10:04:57 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id KAA01180; Tue, 30 Apr 2002 10:04:51 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id KAA15200; Tue, 30 Apr 2002 10:04:56 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g3U14tS20456; Tue, 30 Apr 2002 10:04:55 +0900 (JST)
Date: Tue, 30 Apr 2002 10:04:55 +0900 (JST)
Message-Id: <20020430.100455.68542723.machida@sm.sony.co.jp>
To: jsun@mvista.com
Cc: ppopov@mvista.com, alan@lxorguk.ukuu.org.uk, linux-mips@oss.sgi.com
Subject: Re: reiserfs
From: Hiroyuki Machida <machida@sm.sony.co.jp>
In-Reply-To: <3CCD847A.8050905@mvista.com>
References: <E171Yfh-0000gA-00@the-village.bc.nu>
	<1019937954.1260.22.camel@localhost.localdomain>
	<3CCD847A.8050905@mvista.com>
X-Mailer: Mew version 2.1.51 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hello, all

From: Jun Sun <jsun@mvista.com>
Subject: Re: reiserfs
Date: Mon, 29 Apr 2002 10:35:54 -0700

> Here is the test case that reveals the toolchain problem.  Brave souls are 
> welcome to look into it.
> 
> Apparently the bug only happens on be tools with 2.95.x.
> 
> Jun

I think this bug has been fixed with
     http://gcc.gnu.org/ml/gcc-patches/2000-02/msg00489.html
for gcc-3.x.

You can apply the patch included that mail to gcc-2.95.x, easily.

---
Hiroyuki Machida
Sony Corp.
