Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MF8CP11931
	for linux-mips-outgoing; Fri, 22 Feb 2002 07:08:12 -0800
Received: from dea.linux-mips.net (a1as04-p242.stg.tli.de [195.252.186.242])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MF88911928
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 07:08:09 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1ME7jv28928;
	Fri, 22 Feb 2002 15:07:45 +0100
Date: Fri, 22 Feb 2002 15:07:45 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Venkatesh M R <venkatesh@multitech.co.in>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: How To Remove Write Protection
Message-ID: <20020222150745.A28918@dea.linux-mips.net>
References: <3C763244.5030206@multitech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C763244.5030206@multitech.co.in>; from venkatesh@multitech.co.in on Fri, Feb 22, 2002 at 05:27:56PM +0530
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 22, 2002 at 05:27:56PM +0530, Venkatesh M R wrote:

>    I am presently porting RTLinux to MIPS Atlas board ( with 4Kc core ).
> Can you please tell me how to remove the write protection of the Linux 
> kernel (2.4.3) .
> Because I am getting the page fault when i am trying to insert the 
> Rtlinux module.

Modules aren't write protected.

  Ralf
