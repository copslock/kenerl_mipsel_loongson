Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7GBOhRw021814
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 16 Aug 2002 04:24:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7GBOhhv021813
	for linux-mips-outgoing; Fri, 16 Aug 2002 04:24:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from webmail24.rediffmail.com (webmail24.rediffmail.com [203.199.83.146] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7GBOZRw021804
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 04:24:36 -0700
Received: (qmail 1293 invoked by uid 510); 16 Aug 2002 11:26:24 -0000
Date: 16 Aug 2002 11:26:24 -0000
Message-ID: <20020816112624.1292.qmail@webmail24.rediffmail.com>
Received: from unknown (203.197.186.246) by rediffmail.com via HTTP; 16 Aug 2002 11:26:24 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@oss.sgi.com
Subject: boot hangs in execeving the shell
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
X-Spam-Status: No, hits=1.3 required=5.0 tests=MAY_BE_FORGED version=2.20
X-Spam-Level: *
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello All,

I have been able to boot linux on mips idt cpu , but it gets 
hanged while execving the "/bin/sh" in init/main.c.

it hangs after "submit_bh(READ...)" called from 
block_read_full_page (fs/buffer.c).

also if i use debugging functions like show_trace() or
show_stack() it reports

unable to handle kernel paging request at virtual address
000000c8
and then oops process name it reports is "swapper".

this virtual address 000000c8 is quite strange.
as kernel starts from 0x80000000 onwards.

can initrd be faulty someway to cause this?

i have taken initrd from some other source which i amn't sure 
whether it is was compiled little or big endian.

my kernel is compiled with "mips-linux-" the big endian toolchain 
set.

anybody can share source for minimal rootfilesystem
so that i can compile appropiately and check.

Best Regards,

__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
