Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64IAGRw012785
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 11:10:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64IAGsc012784
	for linux-mips-outgoing; Thu, 4 Jul 2002 11:10:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64IA9Rw012774;
	Thu, 4 Jul 2002 11:10:09 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.5/8.12.5) with ESMTP id g64IE68j004040;
	Thu, 4 Jul 2002 11:14:06 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA08616;
	Thu, 4 Jul 2002 11:14:05 -0700 (PDT)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g64IE5b06807;
	Thu, 4 Jul 2002 20:14:05 +0200 (MEST)
Message-ID: <3D249181.D9147AAE@mips.com>
Date: Thu, 04 Jul 2002 20:18:41 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: LTP testing (shmat01)
References: <3D246924.542682B2@mips.com> <20020704193414.A29570@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Thu, Jul 04, 2002 at 05:26:28PM +0200, Carsten Langgaard wrote:
>
> > The LTP test shmat01 fails on MIPS, because SHMLBA is defined to 0x40000
> > (in include/asm-mips/shmparam.h).
> > For all other architectures SHMLBA is defined to PAGE_SIZE, does anyone
> > know why we are different ?
>
> Sounds like a broken test.  The value of SHMLBA is ABI mandated.  Technically
> we could use any power of 2 >= 32kB easily and with plenty of headache
> any power of 2 > PAGE_SIZE.

Ok, I see, but is there any reason for us to be different than the rest of the
world ?

>
>   Ralf
