Received:  by oss.sgi.com id <S554032AbRAWQfl>;
	Tue, 23 Jan 2001 08:35:41 -0800
Received: from sovereign.org ([209.180.91.170]:33665 "EHLO lux.homenet")
	by oss.sgi.com with ESMTP id <S554025AbRAWQfU>;
	Tue, 23 Jan 2001 08:35:20 -0800
Received: (from jfree@localhost)
	by lux.homenet (8.11.2/8.11.2/Debian 8.11.2-1) id f0NGZN605335;
	Tue, 23 Jan 2001 09:35:23 -0700
From:   Jim Freeman <jfree@sovereign.org>
Date:   Tue, 23 Jan 2001 09:35:23 -0700
To:     linux-mips@oss.sgi.com, dhinds@zen.stanford.edu
Subject: mips vs pcmcia - which wins?
Message-ID: <20010123093523.B4972@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

The following mips kernel patchlet:

	diff -u --new-file --recursive --exclude-from diff.exclude \
		linux-2.4.0/include/linux/sched.h \
		linux-mips.cvs/include/linux/sched.h
	--- linux-2.4.0/include/linux/sched.h   Thu Jan  4 15:50:47 2001
	+++ linux-mips.cvs/include/linux/sched.h        Wed Jan 10 21:52:59 2001
	@@ -562,6 +562,8 @@
	 extern int in_group_p(gid_t);
	 extern int in_egroup_p(gid_t);

	+extern void release(struct task_struct * p);
	+
	 extern void proc_caches_init(void);
	 extern void flush_signals(struct task_struct *);
	 extern void flush_signal_handlers(struct task_struct *);



causes i386 builds to fail:

make -C pcmcia modules
make[5]: Entering directory `/autobuild/public_html/project/build/rpmdir/BUILD/linux/drivers/pcmcia'
...
cs.c:93: `release' redeclared as different kind of symbol
/autobuild/public_html/project/build/rpmdir/BUILD/linux/include/linux/sched.h:565: previous declaration of `release'
cs.c:93: warning: `release' was declared `extern' and later `static'
make[5]: *** [cs.o] Error 1
make[5]: Leaving directory `/autobuild/public_html/project/build/rpmdir/BUILD/linux/drivers/pcmcia'
make[4]: *** [_modsubdir_pcmcia] Error 2



with the following i386 config options:

	...
	CONFIG_HOTPLUG=y

	#
	# PCMCIA/CardBus support
	#
	CONFIG_PCMCIA=m
	# CONFIG_CARDBUS is not set
	# CONFIG_I82365 is not set
	# CONFIG_TCIC is not set
	...

...jfree
