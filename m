Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g229bCF21666
	for linux-mips-outgoing; Sat, 2 Mar 2002 01:37:12 -0800
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g229b5921660
	for <linux-mips@oss.sgi.com>; Sat, 2 Mar 2002 01:37:05 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id AAA24009;
	Sat, 2 Mar 2002 00:36:51 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA28165;
	Sat, 2 Mar 2002 00:36:54 -0800 (PST)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g228aJA17572;
	Sat, 2 Mar 2002 09:36:20 +0100 (MET)
Message-ID: <3C808F91.D9B5DC6D@mips.com>
Date: Sat, 02 Mar 2002 09:38:41 +0100
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Muthukumar Ratty <muthur@paul.rutgers.edu>
CC: linux-mips@oss.sgi.com
Subject: Re: Cross toolchain problem??
References: <Pine.SOL.4.10.10203012316030.9292-100000@paul.rutgers.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Muthukumar Ratty wrote:

> To add to my previous mail:
> The same code when I build with Algorithmics tool chain builds "jal
> gt64120" properly, I mean it doesnt use _gp.
>
> But I cannot stick with Algorithmics tool chain because when I build the
> kernel 2.4.3 it complains that "my Algorithmics toolchain is old and it
> builds buggy kernel."

Just remove the check from the kernel.

>
> I am really stuck here for a while and any help would be appreciated.
> Thanks a lot,
> Muthu
>
> On Fri, 1 Mar 2002, Muthukumar Ratty wrote:
>
> >
> > Hi,
> >
> > My toolchain information
> > Host : redhat linux 7.1 in a i386 PC
> >
> > Tool chains built as per Brad LaRonde's writeup.
> >  (Building a Modern MIPS Cross-Toolchain for Linux)
> > gcc: version 3.0.3
> > binutils : version 2.11.92.0.7 20011016
> > glibc: version 2.2.3 with linux threads patch and mips-base-addr patch
> >       from Brad.
> >
> > I was able to build kernel 2.4.3, I got from oss.sgi.com and it works fine
> > (thanks to everyone). So I assumed my toolchain is working fine. Next I
> > modified the yamon startup code (just used reset.S, gt64120.S, link.xn and
> > did some cleaning to get it compiled). When I tried to run srecconv.pl
> > util, I got error message "Out of memory!" (I wanto convert it into flash
> > format to download. The strange thing is, I have an Algorithmics toolchain
> > version egcs-2.90.23 980102, GNU ld 2.9.1/sde-4.0.3, and the srec I got
> > from it doesnt havethis problem)
> >
> > I tried to trace down and found that the srec generated has load
> > address 0x80001000 for data and 0xbfc00000 for the startup code (this is
> > because the link.xn is defined this way). So when an associative array is
> > used in perl script srecconv.pl, it runs out of memory.  I dont know perl
> > and I am stuck here. Can somebody point me how to proceed? thanks a lot.
> > (i really want to have the data loaded at 0x80001000 but it should be
> > initially in flash).
> >
> > So I changed the data load address to 0xbfc01000 and now the srecconv
> > works fine and I got a .fl image. But my "jal gt64120_init" is assembled
> > to use _gp and I dont think I set the _gp properly ( I am still in the
> > process of reading Dominics book:). so the code is not at all entering in
> > to the gt64120_init function. but when I change it to "j gt64120_init"
> > it works fine. (Cant I use "jal" here?)
> >
> > Any help would be appreciated and sorry for this long mail,
> > Thanks,
> > Muthu
> >
> >
> >
