Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5JKbKnC021553
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 13:37:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5JKbKJt021552
	for linux-mips-outgoing; Wed, 19 Jun 2002 13:37:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5JKbBnC021549;
	Wed, 19 Jun 2002 13:37:11 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA07751; Wed, 19 Jun 2002 13:40:09 -0700 (PDT)
	mail_from (pj@engr.sgi.com)
Received: from turbo-linux.engr.sgi.com (turbo-linux.engr.sgi.com [163.154.6.103])
	by cthulhu.engr.sgi.com (SGI-8.9.3/8.9.3) with ESMTP id NAA96108;
	Wed, 19 Jun 2002 13:38:52 -0700 (PDT)
Received: by turbo-linux.engr.sgi.com (Postfix, from userid 2324)
	id 95A461014E10; Wed, 19 Jun 2002 13:38:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by turbo-linux.engr.sgi.com (Postfix) with ESMTP
	id 905B81C000AA; Wed, 19 Jun 2002 13:38:52 -0700 (PDT)
Date: Wed, 19 Jun 2002 13:38:52 -0700 (PDT)
From: Paul Jackson <pj@engr.sgi.com>
To: William Jhun <wjhun@ayrnetworks.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, <linux-mips@oss.sgi.com>
Subject: Re: [PATCH] include/asm-mips/pci.h
In-Reply-To: <20020619112207.B6057@ayrnetworks.com>
Message-ID: <Pine.LNX.4.44.0206191326560.18638-100000@turbo-linux.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 19 Jun 2002, William Jhun wrote:
> Note that without the #ifdefs, you may get warnings like:
>
> ../../../ayr/linux/include/asm/pci.h: In function `prep_buffer':
> ../../../ayr/linux/include/asm/pci.h:89: warning: statement with no effect
> ...
>
> So are we still sure we want to leave them out?


Yes - leave them out (speaking out of context here - hopefully still
useful).

Remove the warnings instead.

I've gotten in the habit of having the following form to
optional code logic:

In some header file foobar.h:

    #if CONFIG_FOOBAR
    #define init_foobar(x) do {		\
	    int f = 2 * (x);		\
	    foobar_initialize(f);	\
	| while (0)
    #else
    #define init_foobar(x) do {} while (0)
    #endif

I don't see any warnings from this, and it provides just
the right sort of syntax wrapper on the macro init_foobar(),
forcing it to be a single statement, regardless of context,
while providing a nested block context for any local variables.


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
