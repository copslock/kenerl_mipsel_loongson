Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3I9mj8d003721
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 02:48:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3I9mjog003720
	for linux-mips-outgoing; Thu, 18 Apr 2002 02:48:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3I9mf8d003714
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 02:48:42 -0700
Received: (qmail 26043 invoked from network); 18 Apr 2002 09:49:42 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 18 Apr 2002 09:49:42 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 43F703001E3; Thu, 18 Apr 2002 19:49:40 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 2647994; Thu, 18 Apr 2002 19:49:40 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: DBE table ordering 
In-reply-to: Your message of "Thu, 18 Apr 2002 13:37:14 +0400."
             <3CBE93CA.EB27DB1A@niisi.msk.ru> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Apr 2002 19:49:35 +1000
Message-ID: <1661.1019123375@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 18 Apr 2002 13:37:14 +0400, 
"Gleb O. Raiko" <raiko@niisi.msk.ru> wrote:
>If you really hate this behaviour and want to change it, I guess just
>linear serach is OK.

Performance matters for these tables.  It is worth doing one sort at
boot time to let the kernel run faster all the time.  For some tables
(ia64 unwind) the API mandates that the table be in ascending order.

I just sent a general sort routine to l-k for comments before I do the
rest of the work.
