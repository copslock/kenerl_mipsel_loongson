Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2A6VfP18982
	for linux-mips-outgoing; Sat, 9 Mar 2002 22:31:41 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2A6Vc918979
	for <linux-mips@oss.sgi.com>; Sat, 9 Mar 2002 22:31:38 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16jvve-0005Fd-00; Sat, 09 Mar 2002 23:31:30 -0600
Message-ID: <3C8AEF8F.21DB96B9@cotw.com>
Date: Sat, 09 Mar 2002 23:30:55 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
CC: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: xfs
References: <1015611727.12994.441.camel@zeus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete Popov wrote:
> 
> I see on SGI's web site that XFS is supported only on x86 and IA64. Has
> anyone tried it on mips?
> 
Oh most definitely. I've been using it on my NEC 5432 platform for almost
a year now, little endian. Works great. I've compiled the Linux/MIPS 2.4.x
kernel with toolchains based on latest binutils, gcc-3.0.x, gcc-3.1 and
glibc-2.2.3 and glibc-2.2.5 combinations.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
