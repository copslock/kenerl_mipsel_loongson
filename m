Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3I3sr8d011452
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Apr 2002 20:54:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3I3sr8q011451
	for linux-mips-outgoing; Wed, 17 Apr 2002 20:54:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3I3sk8d011439
	for <linux-mips@oss.sgi.com>; Wed, 17 Apr 2002 20:54:48 -0700
Received: (qmail 23279 invoked from network); 18 Apr 2002 03:55:44 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 18 Apr 2002 03:55:44 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id E2BEE3001E3; Thu, 18 Apr 2002 13:55:40 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id ACE4F94; Thu, 18 Apr 2002 13:55:40 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Mark Huang" <mhuang@broadcom.com>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: DBE table ordering 
In-reply-to: Your message of "Wed, 17 Apr 2002 15:21:56 MST."
             <E1EBEF4633DBD3118AD1009027E2FFA0023FB64D@mail.sv.broadcom.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Apr 2002 13:55:35 +1000
Message-ID: <30922.1019102135@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 17 Apr 2002 15:21:56 -0700, 
"Mark Huang" <mhuang@broadcom.com> wrote:
>search_one_table() in arch/mips/kernel/traps.c does a binary search for the
>erring instruction address in the DBE table. What guarantee is there that
>the table is in order by instruction address? It looks like the code hasn't
>changed in a long time and it has worked for me since at least 2.4.3.
>However, a top of tree (2.5.1) kernel crashes on me as soon as a get_dbe()
>fails, because the table is out of order at link time---possibly run time if
>there's some code that I missed that is reordering the table at __init. Any
>ideas?

The kernel relies on several tables being correctly ordered by the
linker, including the initialization vectors, so it is a fair bet that
the linker is correctly appended these tables as the kernel is built.
What is more likely is that one of the exception table entries was
created out of order.  Please send the following output to me, not the
list.

objdump -h vmlinux
objdump -s -j __ex_table vmlinux
nm -a vmlinux
