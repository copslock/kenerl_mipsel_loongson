Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3NLIpu12579
	for linux-mips-outgoing; Mon, 23 Apr 2001 14:18:51 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3NLIlM12566;
	Mon, 23 Apr 2001 14:18:47 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id QAA03796;
	Mon, 23 Apr 2001 16:18:46 -0500
Message-ID: <3AE4B902.C81AB2B9@cotw.com>
Date: Mon, 23 Apr 2001 16:21:38 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: IRQ questions
References: <3AE081E3.434E9126@cotw.com> <20010420190017.B7282@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> > I have a 2.4.3 kernel booting. I copied the old  arch/mips/kernel/irq.c
> > to my target directory and changed
>
> One valid solution ...  Still.  We want to eleminate all this code
> duplication for no good reason.

Would Rotten_IRQ have done the same thing?

Could you name an arch in the cvs distribution that uses the new style IRQ's

Thanks,
Scott
