Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GKbYw27537
	for linux-mips-outgoing; Mon, 16 Jul 2001 13:37:34 -0700
Received: from mimi.clarku.edu (mimi.clarku.edu [140.232.1.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GKbXV27534
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 13:37:33 -0700
Received: from localhost ([140.232.202.11]) by CLARKU.EDU (PMDF V5.2-27 #30607)
 with ESMTP id <01K607H86ZGY935IZ1@CLARKU.EDU> for linux-mips@oss.sgi.com; Mon,
 16 Jul 2001 16:36:58 EST
Received: from gjohnson by localhost with local (Exim 3.22 #1 (Debian))
	id 15MF7A-0003DH-00	for <linux-mips@oss.sgi.com>; Mon,
 16 Jul 2001 16:37:12 -0400
Date: Mon, 16 Jul 2001 16:37:12 -0400
From: Greg Johnson <gjohnson@superweasel.com>
Subject: Linux on a 100MHz r4000 indy?
To: linux-mips@oss.sgi.com
Message-id: <20010716163712.B12104@superweasel.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have tried recently to get Debian installed on a 100MHz r4000 indy.
I got it to install and boot the base system, but when I upgrade to the
more recent libc6, I get Bus Errors when I run things like "ls".  I
understand that this is related to the MIPS_ATOMIC/ll/sc stuff that has
been discussed here lately.  So, I tried the fast-sysmips patch.  This
changed the Bus Errors to Segfaults.  

I also have another indy with a 175MHz r4400.  This machine seems to
work fine even without the fast-sysmips patch.  

So what's the deal?  Are the r4000 and r4400 that different?  It's my
understanding that both the r4000 and the r4400 support the ll/sc
instructions.  Should I expect bad/broken hardware on the r4000 machine?  

Thanks,

Greg
