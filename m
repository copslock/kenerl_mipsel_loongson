Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0P5dcG24747
	for linux-mips-outgoing; Thu, 24 Jan 2002 21:39:38 -0800
Received: from ns4.sony.co.jp (NS4.Sony.CO.JP [146.215.0.102])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0P5dVP24711;
	Thu, 24 Jan 2002 21:39:31 -0800
Received: from mail1.sony.co.jp (GateKeeper11.Sony.CO.JP [146.215.0.74])
	by ns4.sony.co.jp (R8/Sony) with ESMTP id g0P4dKY54130;
	Fri, 25 Jan 2002 13:39:20 +0900 (JST)
Received: from mail1.sony.co.jp (localhost [127.0.0.1])
	by mail1.sony.co.jp (R8) with ESMTP id g0P4dJl07412;
	Fri, 25 Jan 2002 13:39:19 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail1.sony.co.jp (R8) with ESMTP id g0P4dIg07377;
	Fri, 25 Jan 2002 13:39:18 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id NAA01226; Fri, 25 Jan 2002 13:44:02 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id NAA09285; Fri, 25 Jan 2002 13:39:17 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g0P4dHJ13115; Fri, 25 Jan 2002 13:39:17 +0900 (JST)
To: ralf@oss.sgi.com
Cc: kevink@mips.com, aj@suse.de, hjl@lucon.org, linux-mips@oss.sgi.com
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
In-Reply-To: <20020124105915.A838@dea.linux-mips.net>
References: <005301c1a368$87d27ed0$10eca8c0@grendel>
	<20020123145634M.machida@sm.sony.co.jp>
	<20020124105915.A838@dea.linux-mips.net>
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020125133916X.machida@sm.sony.co.jp>
Date: Fri, 25 Jan 2002 13:39:16 +0900
From: Machida Hiroyuki <machida@sm.sony.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk




From: Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
Date: Thu, 24 Jan 2002 10:59:15 -0800

> There is a method for mutual exclusion called Dekker's Algorithem (sp?)
> which only requires just atomic stores and can be implemented in plain
> C.  Downside is it's weak performance that renders it pretty much a CS
> only thing.

Dekker's Algorithem and Lamport's Algorithm  are not match for
test_and_set() interface in glibc.

In test_and_set(), mutex var is INT, but those algorimths need
to share addtional variables.

---
Hiroyuki Machida
Sony Corp.
