Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f860Wu303392
	for linux-mips-outgoing; Wed, 5 Sep 2001 17:32:56 -0700
Received: from dea.linux-mips.net (u-59-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.59])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f860Wqd03389
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 17:32:52 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f860WA818667;
	Thu, 6 Sep 2001 02:32:10 +0200
Date: Thu, 6 Sep 2001 02:32:10 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Steven Liu <stevenliu@psdc.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Load address of the application is not right.
Message-ID: <20010906023210.B18605@dea.linux-mips.net>
References: <84CE342693F11946B9F54B18C1AB837B0A28BC@ex2k.pcs.psdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <84CE342693F11946B9F54B18C1AB837B0A28BC@ex2k.pcs.psdc.com>; from stevenliu@psdc.com on Tue, Sep 04, 2001 at 06:34:08PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Sep 04, 2001 at 06:34:08PM -0700, Steven Liu wrote:

> My question is who assign value to register t9 (i.e. $25) and where? Why
> $gp was given 0xfc2 and then added by  -32624 ? Because $gp and $t9 gave a
> wrong address 0fc100a8, the CPU give a page fault and the OS said that the
> address is not GROWDOWN and faild to continue.  
> 
> I think it related to my glibc but I do not know the exact place. 
> 
> If you had this kind problem before, please share your knowlage with me.

Looks very much like at least one of dynamic linker or binutils is
buggy.  You may also have cache coherency issues.

  Ralf
