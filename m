Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15LOOI15252
	for linux-mips-outgoing; Tue, 5 Feb 2002 13:24:24 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15LOLA15248
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 13:24:21 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16YD4W-0000aG-00; Tue, 05 Feb 2002 15:24:12 -0600
Message-ID: <3C604D73.88F1CDCE@cotw.com>
Date: Tue, 05 Feb 2002 15:24:03 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Popov <ppopov@pacbell.net>
CC: Hartvig Ekner <hartvige@mips.com>, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
References: <200202051747.SAA21696@copsun18.mips.com> 
		<3C6044A7.13FEB2E2@cotw.com> <1012943709.10659.106.camel@zeus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete Popov wrote:
> 
> I'm not sure if it's a "little" though.  Ralf has already done the work
> for 64bit memory support on 32bit kernels, but that only works currently
> on 64bit CPUs.  I started hacking on the 64bit memory patch to get it to
> work on 32bit processors, but had to put that aside for a few weeks. I
> hope to get back to it soon.
> 
Sure, the "little" is a relative term. As far as your patch is concerned,
you are essentially trying to use a true 32-bit processor (my definition
being that it is not a 64-bit processor running in 32-bit mode), to address
address more than 4GB of physical memory. I don't see how that is possible
with just the MMU and TLB unless you are using chip selects and customm
logic.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
