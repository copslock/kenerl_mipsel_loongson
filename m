Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3I6ot8d021532
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Apr 2002 23:50:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3I6otog021530
	for linux-mips-outgoing; Wed, 17 Apr 2002 23:50:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3I6on8d021521
	for <linux-mips@oss.sgi.com>; Wed, 17 Apr 2002 23:50:50 -0700
Received: (qmail 25010 invoked from network); 18 Apr 2002 06:51:48 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 18 Apr 2002 06:51:48 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 3E8A93001E3; Thu, 18 Apr 2002 16:51:45 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id D76B394; Thu, 18 Apr 2002 16:51:45 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Mark Huang" <mhuang@broadcom.com>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: DBE table ordering 
In-reply-to: Your message of "17 Apr 2002 23:39:16 MST."
             <1019111956.2095.66.camel@mathom> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Apr 2002 16:51:40 +1000
Message-ID: <314.1019112700@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 17 Apr 2002 23:39:16 -0700, 
"Mark Huang" <mhuang@broadcom.com> wrote:
>From the objdump output, it looks like the exception table is in order
>at link time, but the DBE table is definitely out of order. What seems
>to be throwing it off is the dummy call to get_dbe() in traps.c. After
>sprinkling a few more calls to get_dbe() around the kernel and seeing
>what happens during link, it looks like any call to get_dbe() inside an
>__init section (or probably any explicitly located section) will throw
>off the ordering of the table. 

That is what I expected.  Various tables are built up from special
sections in each object.  The linker is correctly appending those
sections to the final table in vmlinux.  The use of multiple text
sections (init, exit, the rest) means that entries in a table for each
object are not necessarily in order, breaking the assumption that the
overall table is in order.

This is a more general problem than mips dbe, other kernel tables and
other architectures will have the same problem.  I will do a general
patch against 2.5.8 to sort these tables at init time, and backport the
general fix to 2.4.19 later.  In the meantime your patch will bypass
the problem for mips dbe.
