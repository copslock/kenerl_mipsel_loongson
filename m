Received:  by oss.sgi.com id <S554039AbRAWRKV>;
	Tue, 23 Jan 2001 09:10:21 -0800
Received: from sgigate.SGI.COM ([204.94.209.1]:49532 "EHLO
        gate-sgigate.sgi.com") by oss.sgi.com with ESMTP id <S554035AbRAWRKQ>;
	Tue, 23 Jan 2001 09:10:16 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870753AbRAWRH5>; Tue, 23 Jan 2001 09:07:57 -0800
Date:	Tue, 23 Jan 2001 09:07:56 -0800
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Jim Freeman <jfree@sovereign.org>
Cc:	linux-mips@oss.sgi.com, dhinds@zen.stanford.edu
Subject: Re: mips vs pcmcia - which wins?
Message-ID: <20010123090756.C945@bacchus.dhis.org>
References: <20010123093523.B4972@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010123093523.B4972@sovereign.org>; from jfree@sovereign.org on Tue, Jan 23, 2001 at 09:35:23AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 23, 2001 at 09:35:23AM -0700, Jim Freeman wrote:
> From: Jim Freeman <jfree@sovereign.org>
> Date:   Tue, 23 Jan 2001 09:35:23 -0700
> To: linux-mips@oss.sgi.com, dhinds@zen.stanford.edu
> Subject: mips vs pcmcia - which wins?
> 
> The following mips kernel patchlet:
> 
> 	diff -u --new-file --recursive --exclude-from diff.exclude \
> 		linux-2.4.0/include/linux/sched.h \
> 		linux-mips.cvs/include/linux/sched.h
> 	--- linux-2.4.0/include/linux/sched.h   Thu Jan  4 15:50:47 2001
> 	+++ linux-mips.cvs/include/linux/sched.h        Wed Jan 10 21:52:59 2001
> 	@@ -562,6 +562,8 @@
> 	 extern int in_group_p(gid_t);
> 	 extern int in_egroup_p(gid_t);
> 
> 	+extern void release(struct task_struct * p);
> 	+

The function getting exported here changed it's name to release_task in
2.4; I've adjusted above declaration accordingly.

  Ralf
