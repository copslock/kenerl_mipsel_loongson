Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64EAPRw007484
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 07:10:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64EAP8G007483
	for linux-mips-outgoing; Thu, 4 Jul 2002 07:10:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ns5.sony.co.jp (NS5.Sony.CO.JP [146.215.0.45])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64EAARw007472;
	Thu, 4 Jul 2002 07:10:13 -0700
Received: from mail7.sony.co.jp ([43.0.1.209])
	by ns5.sony.co.jp (R8/Sony) with ESMTP id g64EE8l39494;
	Thu, 4 Jul 2002 23:14:08 +0900 (JST)
Received: from mail7.sony.co.jp (localhost [127.0.0.1])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id g64EE8704428;
	Thu, 4 Jul 2002 23:14:08 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id g64EE7V04424;
	Thu, 4 Jul 2002 23:14:07 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id XAA03937; Thu, 4 Jul 2002 23:13:16 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id XAA05243; Thu, 4 Jul 2002 23:14:06 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g64EE6S16036; Thu, 4 Jul 2002 23:14:06 +0900 (JST)
Date: Thu, 04 Jul 2002 23:14:06 +0900 (JST)
Message-Id: <20020704.231406.103018688.machida@sm.sony.co.jp>
To: ralf@oss.sgi.com
Cc: kevink@mips.com, hjl@lucon.org, linux-mips@oss.sgi.com,
   libc-alpha@sources.redhat.com
Subject: Re: PATCH: Always use ll/sc for mips
From: Hiroyuki Machida <machida@sm.sony.co.jp>
In-Reply-To: <20020704155726.A28268@dea.linux-mips.net>
References: <20020702220651.B9566@dea.linux-mips.net>
	<00d401c22337$7e731580$10eca8c0@grendel>
	<20020704155726.A28268@dea.linux-mips.net>
X-Mailer: Mew version 2.1.51 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk




From: Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: PATCH: Always use ll/sc for mips
Date: Thu, 4 Jul 2002 15:57:26 +0200

> No, Sony's ABI isn't MP proof and will break silently on MP systems.  As
> such I can't consider it anything else but a hack.  sysmips(MIPS_ATOMIC_SET,
> ...) and ll/sc however are MP proof.

We can support MP with few modifications.  

On MP system, the pseudo-device will provide ll/sc if CPU support
it. Otherwise, the pseudo-device will be failed to open. In this
case, sysmips() will be used as last resort in libc.

---
Hiroyuki Machida
Sony Corp.
