Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id CAA28226
	for <pstadt@stud.fh-heilbronn.de>; Fri, 23 Jul 1999 02:14:29 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA6905149; Thu, 22 Jul 1999 17:12:16 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA83652
	for linux-list;
	Thu, 22 Jul 1999 17:04:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA46402
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 22 Jul 1999 17:04:26 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA06318
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jul 1999 17:04:24 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-8.uni-koblenz.de [141.26.131.8])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA21455
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jul 1999 02:04:21 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id CAA23770;
	Fri, 23 Jul 1999 02:04:03 +0200
Date: Fri, 23 Jul 1999 02:04:03 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Masami Komiya <mkomiya@crossnet.co.jp>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: glibc cross-compile error
Message-ID: <19990723020403.Z14367@uni-koblenz.de>
References: <37946628.F2D5BA61@crossnet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <37946628.F2D5BA61@crossnet.co.jp>; from Masami Komiya on Tue, Jul 20, 1999 at 09:06:00PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jul 20, 1999 at 09:06:00PM +0900, Masami Komiya wrote:

> I could not cross-compile glibc using Linux/MIPS-2.2.10 sources
> because of asm-mips/timex.h.

> *** timex.h.org	Fri Jun 11 11:18:29 1999
> --- timex.h	Tue Jul 20 20:34:59 1999
> ***************
> *** 31,36 ****
> --- 31,40 ----
>   typedef unsigned int cycles_t;
>   extern cycles_t cacheflush_time;
>   
> + #ifndef __ASM_MIPS_MIPSREGS_H
> + #include <asm/mipsregs.h>
> + #endif
> + 
>   static inline cycles_t get_cycles (void)
>   {
>   	return read_32bit_cp0_register(CP0_COUNT);
> 
> I afraid this workarround will be the cause of the another.
> Does anyone has the better solution ?

Wrap all the C-code in that file with #ifdef __KERNEL__ ... #endif.

It's fixed in my development sources.

  Ralf
