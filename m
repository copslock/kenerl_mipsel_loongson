Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0M7tCT26333
	for linux-mips-outgoing; Mon, 21 Jan 2002 23:55:12 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0M7tAP26330
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 23:55:10 -0800
Received: from ns5.sony.co.jp (NS5.Sony.CO.JP [146.215.0.105]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA01895
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 22:55:05 -0800 (PST)
	mail_from (machida@sm.sony.co.jp)
Received: from mail1.sony.co.jp (GateKeeper11.Sony.CO.JP [146.215.0.74])
	by ns5.sony.co.jp (R8/Sony) with ESMTP id g0M6kVL56762;
	Tue, 22 Jan 2002 15:46:31 +0900 (JST)
Received: from mail1.sony.co.jp (localhost [127.0.0.1])
	by mail1.sony.co.jp (R8) with ESMTP id g0M6kUl26955;
	Tue, 22 Jan 2002 15:46:31 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail1.sony.co.jp (R8) with ESMTP id g0M6kUg26937;
	Tue, 22 Jan 2002 15:46:30 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id PAA23504; Tue, 22 Jan 2002 15:51:16 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id PAA00618; Tue, 22 Jan 2002 15:46:29 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g0M6kTJ05008; Tue, 22 Jan 2002 15:46:29 +0900 (JST)
To: drepper@redhat.com
Cc: kevink@mips.com, hjl@lucon.org, libc-hacker@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
In-Reply-To: <m38zaqsxgx.fsf@myware.mynet>
References: <20020120221607T.machida@sm.sony.co.jp>
	<20020122152744C.machida@sm.sony.co.jp>
	<m38zaqsxgx.fsf@myware.mynet>
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020122154629F.machida@sm.sony.co.jp>
Date: Tue, 22 Jan 2002 15:46:29 +0900
From: Machida Hiroyuki <machida@sm.sony.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


From: Ulrich Drepper <drepper@redhat.com>
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
Date: 21 Jan 2002 22:37:02 -0800

> First, the patch as it is unacceptable.  A file with copyright Sony?
> All the code must be copyrighted by the FSF.  Sony will have to assign
> the copyright for the code to the FSF.

Please let us why. Acctually, glibc includes codes copyrighted by
SUN and gcc includes codes copryrighed by HP and SGI.

---
Hiroyuki Machida
Sony Corp.
