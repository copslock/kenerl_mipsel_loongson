Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2JKCeq05731
	for linux-mips-outgoing; Tue, 19 Mar 2002 12:12:40 -0800
Received: from sentinel.sanera.net (ns1.sanera.net [208.253.254.10] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2JKCa905728
	for <linux-mips@oss.sgi.com>; Tue, 19 Mar 2002 12:12:36 -0800
Received: from icarus.sanera.net (icarus [192.168.254.11])
	by sentinel.sanera.net (8.11.2/8.11.2) with ESMTP id g2JKE0u24088
	for <linux-mips@oss.sgi.com>; Tue, 19 Mar 2002 12:14:00 -0800
Received: from exceed2.sanera.net (exceed2.sanera.net [172.16.2.39])
	by icarus.sanera.net (8.11.6/8.11.6) with SMTP id g2JKDsD02409
	for <linux-mips@oss.sgi.com>; Tue, 19 Mar 2002 12:13:54 -0800
Message-Id: <200203192013.g2JKDsD02409@icarus.sanera.net>
Date: Tue, 19 Mar 2002 12:13:54 -0800 (PST)
From: Krishna Kondaka <krishna@Sanera.net>
Reply-To: Krishna Kondaka <krishna@Sanera.net>
Subject: Application stack trace facility
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: NeM/JmlDGwX0VzgiIr57eA==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.2 SunOS 5.8 sun4u sparc 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
	I would like to know if there is a system call/library function 
	available in linux which prints the current stack trace of the 
	application.
	
	For ex., 
	If main() calls a() which calls b() which in turn calls c() and if
	c() is defined as
	
	c()
	{
		....
		if (condition)
			dump_stack_trac();
		....
	}
	
	the dump_stack_trace() should print if the "condition" is true -
	
	c(...)
	b(...)
	a(...)
	main(..)
	
	Is there such "dump_stack_trace" library function/system call available?
	I know that if I make the program dump core in the dump_stack_trace 
	function then I can get the stack trace from the core dump but I would
	like to know if I can do this without forcing the core dump.

TIA
Krishna Kondaka
Sanera Systems
