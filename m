Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11KvJr18080
	for linux-mips-outgoing; Fri, 1 Feb 2002 12:57:19 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11KvFd18074
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 12:57:15 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA04454
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 11:57:05 -0800 (PST)
	mail_from (jsun@orion.mvista.com)
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id LAA18199;
	Fri, 1 Feb 2002 11:52:06 -0800
Date: Fri, 1 Feb 2002 11:52:06 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@oss.sgi.com
Subject: gcc 3.x, -ansi and "static inline"
Message-ID: <20020201115206.A18085@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


We are trying to build userland apps with the newer kernel headers.
Unexpected problems occur with the "static inline" declaration
when "-ansi" option is used.

Anybody else is having the problem?

Also, what are the reasons for us to switch to "static inline" in the
kernel header?

Here is an example I am talking about:

In 2.4.2, we have in bitops.h:

extern __inline__ unsigned long ffz(unsigned long word)

In 2.4.17, we have instead:

static inline unsigned long ffz(unsigned long word)

This problem seems only happening with gcc 3.x.  I start to wonder
whether we should fix kernel header.  In some case, the fix seems
to be not exposing to userland (by #ifdef __KERNEL__).  In others,
the fix might be using __inline__.  

However, I really like to know what was the original motivation
to do such a change.

BTW, the inclusion of "mipsregs.h" file in bitops.h seems unnecessary
and caused a bunch of similar errors.

Jun
