Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MEje311504
	for linux-mips-outgoing; Fri, 22 Feb 2002 06:45:40 -0800
Received: from ns5.sony.co.jp (NS5.Sony.CO.JP [146.215.0.45])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MEjb911501
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 06:45:37 -0800
Received: from mail2.sony.co.jp (mail2.sony.co.jp [43.0.1.202])
	by ns5.sony.co.jp (R8/Sony) with ESMTP id g1MDjQS99525;
	Fri, 22 Feb 2002 22:45:26 +0900 (JST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8) with ESMTP id g1MDjPH12995;
	Fri, 22 Feb 2002 22:45:25 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (R8) with ESMTP id g1MDjO712958;
	Fri, 22 Feb 2002 22:45:24 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id WAA15480; Fri, 22 Feb 2002 22:45:18 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id WAA08343; Fri, 22 Feb 2002 22:45:23 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g1MDjNS24593; Fri, 22 Feb 2002 22:45:23 +0900 (JST)
Date: Fri, 22 Feb 2002 22:45:22 +0900 (JST)
Message-Id: <20020222.224522.80690047.machida@sm.sony.co.jp>
To: macro@ds2.pg.gda.pl
Cc: hjl@lucon.org, wgowcher@yahoo.com, linux-mips@oss.sgi.com
Subject: Re: pthread support in mipsel-linux
From: Hiroyuki Machida <machida@sm.sony.co.jp>
In-Reply-To: <Pine.GSO.3.96.1020222143540.5266C-100000@delta.ds2.pg.gda.pl>
References: <20020221102503.A28936@lucon.org>
	<Pine.GSO.3.96.1020222143540.5266C-100000@delta.ds2.pg.gda.pl>
X-Mailer: Mew version 2.1.51 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: pthread support in mipsel-linux
Date: Fri, 22 Feb 2002 14:38:53 +0100 (MET)

> On Thu, 21 Feb 2002, H . J . Lu wrote:
> 
> > > Just to clarify, the glibc rpm in your Redhat 7.1 is
> > > compiled with -mips1 right ? So as it is broken yes ?
> > 
> > Yes. -mips1 doesn't work well with thread.
> 
>  What's wrong with -mips1 currently?  It used to be OK around glibc 2.2 --
> has anything changed since then that needs -mips1 to be fixed?
> 

Functions such as compre_and_swap() in sysdeps/mips/atomicity.h are
not atmoic with -mips1 option.

---
Hiroyuki Machida
Sony Corp.
