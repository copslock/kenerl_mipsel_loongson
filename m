Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2RL1fV17907
	for linux-mips-outgoing; Wed, 27 Mar 2002 13:01:41 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2RL1Zq17903
	for <linux-mips@oss.sgi.com>; Wed, 27 Mar 2002 13:01:36 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16qKaE-00023w-00; Wed, 27 Mar 2002 15:03:51 -0600
Message-ID: <3CA233B6.58DB8B08@cotw.com>
Date: Wed, 27 Mar 2002 15:03:50 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: binutils@sources.redhat.com, linux-mips@oss.sgi.com, uclibc@uclibc.org
Subject: Linux/MIPS and ELF dynamic linker/loader questions...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings.

I am working on a MIPS dynamic linker/loader for uClibc and
would appreciate some clarification on the finer points of
ELF and the Linux kernel interface. Forgive the cross post.

The first problem I have discovered is that the value of
argc passed back to the userspace process from the Linux
kernel is always zero. The argv, environment and auxillary
vectors come through just fine. I have to loop through the
stack manually to count the number of argument vectors in
order to get argc:

#if defined(__mips__)
    argc = 0;
    aux_dat = sp + 1;
    while (*aux_dat++)
        argc++;
#endif

This code snippet is the first code to execute in the dynamic
linker, so no trashing of argc should have had a chance to
happen. Any insight?

The second question has to do with printing string constants
to stderr like so:

     static inline _syscall3(unsigned long, _dl_write, int, fd,
            const void *, buf, unsigned long, count);
     #define SEND_STDERR(X) _dl_write(2, X, _dl_strlen(X));

     SEND_STDERR("ELF header =");

The problem as I understand it is that string constants for
MIPS are accessed using the GOT (since the dynamic linker is
all PIC code). Since I haven't bootstrapped and relocated the
dynamic linker yet, the above SEND_STDERR call causes a SEGFAULT
as the address is invalid. Also, it appears that the constants
are stored in the .rodata section. Is there a quick hack to get
a hold of the string constants? Flames, help, etc. appreciated.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
