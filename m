Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA6196O31757
	for linux-mips-outgoing; Mon, 5 Nov 2001 17:09:06 -0800
Received: from mail.matriplex.com (ns1.matriplex.com [208.131.42.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA6194031753
	for <linux-mips@oss.sgi.com>; Mon, 5 Nov 2001 17:09:04 -0800
Received: from mail.matriplex.com (mail.matriplex.com [208.131.42.9])
	by mail.matriplex.com (8.9.2/8.9.2) with ESMTP id RAA01276
	for <linux-mips@oss.sgi.com>; Mon, 5 Nov 2001 17:09:01 -0800 (PST)
	(envelope-from rh@matriplex.com)
Date: Mon, 5 Nov 2001 17:09:01 -0800 (PST)
From: Richard Hodges <rh@matriplex.com>
To: linux-mips@oss.sgi.com
Subject: Arguments for kernel_entry?
Message-ID: <Pine.BSF.4.10.10111051659510.600-100000@mail.matriplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Would anyone be able to provide information on the arguments
to kernel_entry (in head.S)?

The first two look pretty straightforward, argument count and
string vectors.  I assume that argument zero is actually the
first argument, and not "vmlinux"?

What are the third (ulong) and fourth (int *) arguments?  I have
read head.S and searched for days trying to find this info :-(

I thought PMON would be a decent reference, but run_target() only
seems to set $4 and $5, before calling _go().

Thanks!

-Richard
