Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7EIYaP16765
	for linux-mips-outgoing; Tue, 14 Aug 2001 11:34:36 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7EIYOj16762
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 11:34:33 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7EIdCA03105;
	Tue, 14 Aug 2001 11:39:12 -0700
Message-ID: <3B797004.4030503@pacbell.net>
Date: Tue, 14 Aug 2001 11:37:56 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Steven Liu <stevenliu@psdc.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Could not find the source code for "/sbin/init".
References: <84CE342693F11946B9F54B18C1AB837B0A2431@ex2k.pcs.psdc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Steven Liu wrote:
> Hi, Pete:
> 
> Thank you very much for your help.
> 
> After several tries, I realized that you are right. My MMU may have
> problem.
> 
> Because my mips CPU is not the standard one and I do not have a R3000
> application 
> program such as "date", "arch", or "init", I built an application as
> following.
> 
> liu.c is: 
> 
> void main(void)
> {
> 
> }
> 
> Makefile is:
> 
> ARCH = mips
> 
> .EXPORT_ALL_VARIABLES:
> 
> 
> CROSS_COMPILE 	=mips-linux-
> 
> AS	=$(CROSS_COMPILE)as
> LD	=$(CROSS_COMPILE)ld
> CC	=$(CROSS_COMPILE)gcc  -D__mips__ 
> CPP	=$(CC) -E
> AR	=$(CROSS_COMPILE)ar
> NM	=$(CROSS_COMPILE)nm
> STRIP	=$(CROSS_COMPILE)strip
> OBJCOPY	=$(CROSS_COMPILE)objcopy
> OBJDUMP	=$(CROSS_COMPILE)objdump
> MAKE	=make
> GENKSYMS=/sbin/genksyms
> 
> 
> CFLAGS = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -mips1
> -mcpu=r3000 -mmemcpy
> 
> CFLAGS += $(shell if $(CC) -fno-strict-aliasing -S -o /dev/null -xc
> /dev/null >/dev/null 2>&1; then echo "-fno-strict-aliasing"; fi)
> 
> # egcs-1.0.2 compiler for MIPS has a problem for which this is a
> work-around
> CFLAGS += $(shell if $(CC) -mno-split-addresses -S -o /dev/null -xc
> /dev/null >/dev/null 2>&1; then echo "-mno-split-addresses"; fi)
> 
> 
> 
> .S.s:
> 	$(CC) -D__ASSEMBLY__  -traditional -E -o $*.s $<
> .S.o:
> 	$(CC) -D__ASSEMBLY__  -traditional -c -o $*.o $<
> 
> 
> 
> liu: $(CONFIGURATION) liu.o
> 	$(LD) $(LINKFLAGS) $(HEAD) liu.o  \
> 		-o liu
> 	$(NM) liu | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aU]
> \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
> 
> 
> liu.o: liu.c 
> 	$(CC) $(CFLAGS) $(PROFILING) -c -o $*.o $<
> 
> 
> When I ran the program, it crushed.
> 
> Could you build this application and run it on your R3000 system? If it
> works, send me your executable so that I can test my system.

How do you run the program?  Do you use it instead of /sbin/init?  If so, what 
should happen is that the program should "run" and then just return. If you put 
printks before and after your program is run, you should see the program being 
executed and then returning. If it's crashing, it sounds like your kernel can't 
run *any* userland app, probably because the mmu is not setup correctly.

Unfortunately I don't have any R3000 based boards so I can't test anything.

Pete
