Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JF44b29819
	for linux-mips-outgoing; Fri, 19 Oct 2001 08:04:04 -0700
Received: from saturn.mikemac.com (saturn.mikemac.com [216.99.199.88])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JF41D29815
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 08:04:01 -0700
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id IAA27477;
	Fri, 19 Oct 2001 08:11:40 -0700
Message-Id: <200110191511.IAA27477@saturn.mikemac.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Gerald Champagne <gerald.champagne@esstech.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Moving kernel_entry to LOADADDR 
In-Reply-To: Your message of "Fri, 19 Oct 2001 15:20:33 +0200."
             <Pine.GSO.3.96.1011019152007.1657E-100000@delta.ds2.pg.gda.pl> 
Date: Fri, 19 Oct 2001 08:11:40 -0700
From: Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>Date: Fri, 19 Oct 2001 15:20:33 +0200 (MET DST)
>From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
>To: Gerald Champagne <gerald.champagne@esstech.com>
>Subject: Re: Moving kernel_entry to LOADADDR
>
>On Thu, 18 Oct 2001, Gerald Champagne wrote:
>
>> I also removed the .fill, and now kernel_entry is always exactly LOADADDR,
>> and that makes my bootloader easier to maintain.
>> 
>> Is this worth changing in cvs, or did I miss something?
>
> How about just getting it from the ELF header?  It's trivial.

  Because a bare bones bootloader may not know anything about ELF. The
simplest solution is to just stick a "jmp start_kernel" at LOADADDR
right before the fill. Then the load address and the entry point are
the same. Once the exception vectors get loaded, they'll overwrite the
jmp, so no space is wasted and none of the LOADADDRs have to be
changed.

  Mike McDonald
  mikemac@mikemac.com
