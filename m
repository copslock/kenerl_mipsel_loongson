Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA9IiMw14510
	for linux-mips-outgoing; Fri, 9 Nov 2001 10:44:22 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA9IiI014506;
	Fri, 9 Nov 2001 10:44:18 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA9Ii5jV013100;
	Fri, 9 Nov 2001 10:44:05 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA9Ii4wm013096;
	Fri, 9 Nov 2001 10:44:04 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 9 Nov 2001 10:44:04 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@oss.sgi.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: [Linux-mips-kernel]Re: i8259.c in big endian
In-Reply-To: <3BEC20D5.AD6ABBA6@mvista.com>
Message-ID: <Pine.LNX.4.10.10111091043230.9393-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> You are probably referring to isa_slot_offset?

Yes. I meant isa_slot_offset.

> isa_slot_offset is an obselete garbage.  Can someone do Ralf's a favor and
> send him a patch to get rid of it (as if he can't do it himself :-0) ?

Oh.
