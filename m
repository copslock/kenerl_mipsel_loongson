Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2U7gfZ08342
	for linux-mips-outgoing; Fri, 29 Mar 2002 23:42:41 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g2U7gdv08339
	for <linux-mips@oss.sgi.com>; Fri, 29 Mar 2002 23:42:39 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g2U7g0J31332;
	Fri, 29 Mar 2002 23:42:00 -0800
Date: Fri, 29 Mar 2002 23:42:00 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Gopakumar.C.E" <gopkumar@cisco.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Documentation
Message-ID: <20020329234200.B31160@dea.linux-mips.net>
References: <0203222102032M.00789@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0203222102032M.00789@localhost>; from gopkumar@cisco.com on Fri, Mar 22, 2002 at 09:02:03PM +0530
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Mar 22, 2002 at 09:02:03PM +0530, Gopakumar.C.E wrote:

> Is there any good documentation on how the Linux/Unix code is designed for 
> the MIPS processors ? (like how they handle paging, protection etc?)

The whole VM code is largely generic code sprinkled with a few architecture
specific bits all over include/asm-mips and arch/mips.  The MIPS specific
bits primarily deal with very low level details of memory managment (TLB,
caches) which the actual paging stuff is in the mm/ directory.

I've not document the MIPS-specific parts of memory managment very well
(standard reason - so much work to do, so little time to do it ...) so
feel free to ask me.  The generic Linux memory managment is fairly well
documented in various online resources or a variety of technical books
from your favorite CS bookstore ...

  Ralf
