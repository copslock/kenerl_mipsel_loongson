Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4PJghnC004576
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 25 May 2002 12:42:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4PJgg9L004575
	for linux-mips-outgoing; Sat, 25 May 2002 12:42:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4PJgenC004572
	for <linux-mips@oss.sgi.com>; Sat, 25 May 2002 12:42:40 -0700
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 17BhS0-0004wE-00; Sat, 25 May 2002 14:43:40 -0500
Message-ID: <3CEFE954.9090303@realitydiluted.com>
Date: Sat, 25 May 2002 14:43:16 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020520 Debian/1.0rc2-3
MIME-Version: 1.0
To: Robert Rusek <robru@teknuts.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Executing IRIX binary ?
References: <000701c20420$cc5ce5e0$0a01a8c0@sohotower>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Robert Rusek wrote:
> 
> Thamk you for your reply, but I meant if I did not have the original
> source.  Is there anyway to tell from the binary?
> 
If your kernel hasn't been stripped, you could use 'nm' or 'readelf'
and look for 'irix' symbols. The second option is to try a SGI
system call number and see if the kernel tells you if that is a
valid system call or not.

-S
