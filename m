Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15GoY427163
	for linux-mips-outgoing; Tue, 5 Feb 2002 08:50:34 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15GoWA27156
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 08:50:32 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16Y8na-0000JQ-00
	for <linux-mips@oss.sgi.com>; Tue, 05 Feb 2002 10:50:26 -0600
Message-ID: <3C600D4C.43CBA784@cotw.com>
Date: Tue, 05 Feb 2002 10:50:20 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: What is the maximum physical RAM for a 32bit MIPS core?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am just trying to fill in some more MIPS knowledge here. With a 32-bit
MIPS processor, we are forever limited to a userspace of 2GB in size thanks
to the kuser region. kseg0/1 map the same 512MB of physical memory. kseg2
is 1GB in size and hence it could address another 1GB of RAM. So, is the
maximum amount of RAM for a 32bit MIPS core:

   1) 1.5GB = 0.5GB kseg0/1 + 1.0GB kseg2

   2) 4.0GB = largest 32-bit address

   3) Something larger than 4.0GB by adding fancy external HW logic

Also, for choice #3, while it would be a hit in performance, could you use
the fp registers for 64-bit pointers to address larger than 4.0GB?

Thanks in advance.

-Steve
      
-- 
 Steven J. Hill - Embedded SW Engineer
