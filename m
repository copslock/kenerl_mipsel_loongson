Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f64B8VR12521
	for linux-mips-outgoing; Wed, 4 Jul 2001 04:08:31 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f64B8UV12518
	for <linux-mips@oss.sgi.com>; Wed, 4 Jul 2001 04:08:30 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA06569
	for <linux-mips@oss.sgi.com>; Wed, 4 Jul 2001 03:23:33 -0700 (PDT)
	mail_from (ica2_ts@csv.ica.uni-stuttgart.de)
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id MAA148363
	for <linux-mips@oss.sgi.com>; Wed, 4 Jul 2001 12:23:31 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15Hjof-00084W-00
	for <linux-mips@oss.sgi.com>; Wed, 04 Jul 2001 12:23:29 +0200
Date: Wed, 4 Jul 2001 12:23:29 +0200
To: linux-mips@oss.sgi.com
Subject: Re: sti() does not work.
Message-ID: <20010704122329.B30713@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84CE342693F11946B9F54B18C1AB837B05CE09@ex2k.pcs.psdc.com>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Steven Liu wrote:
> Hi All:
> 
> I am working on the porting Linux to mips R3000 and  have a problem
> about sti( ) which is called in start_kernel( ).
> 
> As we know, sti() is defined as __sti( ) in the
> include/asm-mips/system.h:
>  
> extern __inline__ void  __sti(void)
> {
> 	__asm__ __volatile__(
> 		".set\tnoreorder\n\t"
> 		".set\tnoat\n\t"
> 		"mfc0\t$1,$12\n\t"
> 		"ori\t$1,0x1f\n\t"
> 		"xori\t$1,0x1e\n\t"
> 		"mtc0\t$1,$12\n\t"               /* <----- problem  here
> ! */

Here should follow some nop's on a MIPS I system to make sure $12
is written (why is noreorder used here?).

> 		".set\tat\n\t"
> 		".set\treorder"
> 		: /* no outputs */
> 		: /* no inputs */
> 		: "$1", "memory");
> }

HTH,
Thiemo
