Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6OL9Z603728
	for linux-mips-outgoing; Tue, 24 Jul 2001 14:09:35 -0700
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6OL9XO03725
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 14:09:33 -0700
Received: from [192.168.1.167] (192.168.1.167 [192.168.1.167]) by mail.ivivity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2448.0)
	id PJLG2CMW; Tue, 24 Jul 2001 17:09:27 -0400
Subject: Re: GCC and Modules
From: Marc Karasek <marc_karasek@ivivity.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <20010724132534.A25416@lucon.org>
References: <25369470B6F0D41194820002B328BDD27D2E@ATLOPS>
	<20010724085544.A20610@lucon.org>
	<995995907.1331.5.camel@localhost.localdomain> 
	<20010724132534.A25416@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.11 (Beta Release)
Date: 24 Jul 2001 17:09:03 -0400
Message-Id: <996008951.1387.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

 I will patch and give this a try...  prob will not be until Thursday or
Friday.. 

On 24 Jul 2001 13:25:34 -0700, H . J . Lu wrote:
> On Tue, Jul 24, 2001 at 01:31:41PM -0400, Marc Karasek wrote:
> > The way to see this bug is just try to compile the MIPS kernel (either
> > 2.4.1 or 2.4.3) as follows:
> > 
> > 1) make distclean
> > 2) copy linux/arch/mips/defconfig-malta linux/.config
> > 3) make oldconfig
> > 4) make menuconfig
> > 5) change the endianess from little to big
> > 6) make dep 
> > 7) make zImage 
> > 
> 
> That is a kernel bug. The code only works on littl endian by accident
> Here is a patch.
> 
> 
> H.J.
> --- arch/mips/mips-boards/generic/time.c.int64	Tue Jul 24 13:21:21 2001
> +++ arch/mips/mips-boards/generic/time.c	Tue Jul 24 13:22:02 2001
> @@ -275,7 +275,7 @@ void __init time_init(void)
>  
>  /* This is for machines which generate the exact clock. */
>  #define USECS_PER_JIFFY (1000000/HZ)
> -#define USECS_PER_JIFFY_FRAC (0x100000000*1000000/HZ&0xffffffff)
> +#define USECS_PER_JIFFY_FRAC ((long) (0x100000000*1000000/HZ&0xffffffff))
>  
>  /* Cycle counter value at the previous timer interrupt.. */
>  
--
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
