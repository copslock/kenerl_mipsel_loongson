Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UEFnZ24943
	for linux-mips-outgoing; Wed, 30 Jan 2002 06:15:49 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UEFkd24940
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 06:15:46 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16VuaQ-0000v0-00
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 07:15:38 -0600
Message-ID: <3C57F1FB.6C8780D9@cotw.com>
Date: Wed, 30 Jan 2002 07:15:39 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Unused R5432 cache routines...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Digging through the R5432's cache code in 'arch/mips/mm/c-r5432.c' it
appears the the first two functions:

   flush_icache_line_indexed
   flush_dcache_line_indexed

are unused. I grep'd through the entire tree and there does not appear
to be any use of them. I would like to remove them. Any objections or
comments?

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
