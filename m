Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3NK4jh08872
	for linux-mips-outgoing; Mon, 23 Apr 2001 13:04:45 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3NK4gM08868
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 13:04:43 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3NK4Pn05866;
	Mon, 23 Apr 2001 17:04:25 -0300
Date: Mon, 23 Apr 2001 17:04:25 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Fabrice Bellard <bellard@email.enst.fr>
Cc: linux-mips@oss.sgi.com
Subject: Re: gdb single step ?
Message-ID: <20010423170425.F4623@bacchus.dhis.org>
References: <3AE44D0A.9080003@jungo.com> <Pine.GSO.4.02.10104231829020.19846-100000@chimene.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.02.10104231829020.19846-100000@chimene.enst.fr>; from bellard@email.enst.fr on Mon, Apr 23, 2001 at 06:31:20PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 23, 2001 at 06:31:20PM +0200, Fabrice Bellard wrote:

> Did someone make a patch so that gdb can do single step on mips-linux ? If
> not, do you prefer a patch to gdb or a patch in the kernel to support the
> PTRACE_SINGLESTEP command ?

Last I used GDB single stepping has been working fine for me, so I wonder
what is broken?

  Ralf
