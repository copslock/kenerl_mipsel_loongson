Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA1MZYY23357
	for linux-mips-outgoing; Thu, 1 Nov 2001 14:35:34 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA1MZU023354
	for <linux-mips@oss.sgi.com>; Thu, 1 Nov 2001 14:35:31 -0800
Received: from dsl73.cedar-rapids.net ([208.242.241.39] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 15zQQf-0003wp-00; Thu, 01 Nov 2001 16:35:17 -0600
Message-ID: <3BE1C8F4.ECEDC840@cotw.com>
Date: Thu, 01 Nov 2001 17:13:08 -0500
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-xfs-1.0.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@oss.sgi.com
Subject: Re: [Fwd: Kernel panic: Caught reserved exception - should not happen.]
References: <3BE15781.73CE64DD@cotw.com> <20011101093158.C26148@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:

> Try the following patch.  It is outdated, and it may not apply cleanly.
> But you should get an idea about the intention of the fix.
> 
> Please let me know the result.

It looks like a winner to me. I applied the patch compiled, ran and
cleaned up the ltp tests twice. I was getting between 2-6 (exception
errors) for each cycle I did not have a single failure.

You wouldn't happen to have knowledge of some patches that fix pthreads? 

Thanks very much!

-- 
Scott A. McConnell
