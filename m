Received:  by oss.sgi.com id <S305162AbQBUCVm>;
	Sun, 20 Feb 2000 18:21:42 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:40016 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQBUCV0>;
	Sun, 20 Feb 2000 18:21:26 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA16545; Sun, 20 Feb 2000 18:16:54 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id SAA23092; Sun, 20 Feb 2000 18:20:55 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA63764
	for linux-list;
	Sun, 20 Feb 2000 18:05:20 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA97409
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 20 Feb 2000 18:05:16 -0800 (PST)
	mail_from (machida@sm.sony.co.jp)
Received: from ns4.sony.co.jp (ns4.Sony.CO.JP [202.238.80.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA09366
	for <linux@cthulhu.engr.sgi.com>; Sun, 20 Feb 2000 18:05:20 -0800 (PST)
	mail_from (machida@sm.sony.co.jp)
Received: from mail2.sony.co.jp (gatekeeper7.Sony.CO.JP [202.238.80.21])
	by ns4.sony.co.jp (02/04/00) with ESMTP id LAA12748;
	Mon, 21 Feb 2000 11:05:07 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (3.7W99040614b) with ESMTP id LAA10466;
	Mon, 21 Feb 2000 11:05:07 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.27.209.5]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id LAA27511; Mon, 21 Feb 2000 11:05:08 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.27.210.135]) by imail.sm.sony.co.jp (8.8.8/3.7W) with ESMTP id LAA13613; Mon, 21 Feb 2000 11:04:36 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.8.8/FreeBSD) with ESMTP id LAA26908; Mon, 21 Feb 2000 11:04:36 +0900 (JST)
To:     ralf@oss.sgi.com
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Question about copy_from_user()
In-Reply-To: <20000218121957.G5234@uni-koblenz.de>
References: <20000216183429L.machida@sm.sony.co.jp>
	<20000218121957.G5234@uni-koblenz.de>
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20000221110436M.machida@sm.sony.co.jp>
Date:   Mon, 21 Feb 2000 11:04:36 +0900
From:   Hiroyuki Machida <machida@sm.sony.co.jp>
X-Dispatcher: imput version 990905(IM130)
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


From: Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Question about copy_from_user()
Date: Fri, 18 Feb 2000 12:19:57 +0100

> As you say $at is being used for the exception handling, so it obviously
> isn't redundant as you say.  Or do I missunderstand what you were trying
> to express?

Thanks, Ralf.

I had miss-understood. I understood that $AT at the
copy_from_user is still meaningful. 

---
Hiroyuki Machida
