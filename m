Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7EINOe16399
	for linux-mips-outgoing; Tue, 14 Aug 2001 11:23:24 -0700
Received: from ex2k.pcs.psdc.com ([209.125.203.85])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7EINHj16391
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 11:23:18 -0700
content-class: urn:content-classes:message
Subject: RE: Could not find the source code for "/sbin/init".
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 14 Aug 2001 11:21:01 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65
Message-ID: <84CE342693F11946B9F54B18C1AB837B0A2431@ex2k.pcs.psdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Could not find the source code for "/sbin/init".
Thread-Index: AcEfcZ4IsRIyq7ZrSqeBkRbieS/W7AFejhow
From: "Steven Liu" <stevenliu@psdc.com>
To: "Pete Popov" <ppopov@pacbell.net>
Cc: <linux-mips@oss.sgi.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f7EINIj16393
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, Pete:

Thank you very much for your help.

After several tries, I realized that you are right. My MMU may have
problem.

Because my mips CPU is not the standard one and I do not have a R3000
application 
program such as "date", "arch", or "init", I built an application as
following.

liu.c is: 

void main(void)
{

}

Makefile is:

ARCH = mips

.EXPORT_ALL_VARIABLES:


CROSS_COMPILE 	=mips-linux-

AS	=$(CROSS_COMPILE)as
LD	=$(CROSS_COMPILE)ld
CC	=$(CROSS_COMPILE)gcc  -D__mips__ 
CPP	=$(CC) -E
AR	=$(CROSS_COMPILE)ar
NM	=$(CROSS_COMPILE)nm
STRIP	=$(CROSS_COMPILE)strip
OBJCOPY	=$(CROSS_COMPILE)objcopy
OBJDUMP	=$(CROSS_COMPILE)objdump
MAKE	=make
GENKSYMS=/sbin/genksyms


CFLAGS = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -mips1
-mcpu=r3000 -mmemcpy

CFLAGS += $(shell if $(CC) -fno-strict-aliasing -S -o /dev/null -xc
/dev/null >/dev/null 2>&1; then echo "-fno-strict-aliasing"; fi)

# egcs-1.0.2 compiler for MIPS has a problem for which this is a
work-around
CFLAGS += $(shell if $(CC) -mno-split-addresses -S -o /dev/null -xc
/dev/null >/dev/null 2>&1; then echo "-mno-split-addresses"; fi)



.S.s:
	$(CC) -D__ASSEMBLY__  -traditional -E -o $*.s $<
.S.o:
	$(CC) -D__ASSEMBLY__  -traditional -c -o $*.o $<



liu: $(CONFIGURATION) liu.o
	$(LD) $(LINKFLAGS) $(HEAD) liu.o  \
		-o liu
	$(NM) liu | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aU]
\)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map


liu.o: liu.c 
	$(CC) $(CFLAGS) $(PROFILING) -c -o $*.o $<


When I ran the program, it crushed.

Could you build this application and run it on your R3000 system? If it
works, send me your executable so that I can test my system.

Regards,

Steven Liu

-----Original Message-----
From: Pete Popov [mailto:ppopov@pacbell.net]
Sent: Tuesday, August 07, 2001 11:53 AM
To: Steven Liu
Subject: Re: Could not find the source code for "/sbin/init".


Steven Liu wrote:
> Hi, Pete:
> 
> Thank you for your help.
> 
> Could you tell me what are sash,static bash, and dynamically 
> linked bash? 
> 
> Sorry for the trival question because I am new in Linux kernel.

sash is a "stand alone shell". It's very small and is completely
statically 
linked.  The commands are bit different -- for example, "ls" is "-ls" --
ie, the 
commands start with a "-".  If you can load sash instead of /sbin/init,
it gives 
you some confidence that your kernel is actually able to switch to
userland.


Static and dynamic bash refers to how the libraries that bash is using a
linked. 
With a statically linked bash, all of the libraries are linked as part
of the 
bash binary. That way there is no dynamic library loading when you start
bash.

Dynamically linked bash means that when you start bash, different
libraries that 
bash is using will be loaded dynamically.


Pete

> 
> Regards,
> 
> Steven Liu
> 
> -----Original Message-----
> From: Pete Popov [mailto:ppopov@pacbell.net]
> Sent: Tuesday, August 07, 2001 10:49 AM
> To: Steven Liu
> Cc: linux-mips@oss.sgi.com
> Subject: Re: Could not find the source code for "/sbin/init".
> 
> 
> Steven Liu wrote:
> 
>>Hi ALL:
>>
>>As we know, the function init( ) in main.c is 
>>
>>static int init(void * unused)
>>{
>>	lock_kernel();
>>	do_basic_setup();
>>	free_initmem();
>>	unlock_kernel();
>>
>>	if (open("/dev/console", O_RDWR, 0) < 0)
>>		printk("Warning: unable to open an initial console.\n");
>>
>>	(void) dup(0);
>>	(void) dup(0);
>>	
>>
>>	if (execute_command)
>>		execve(execute_command,argv_init,envp_init);
>>
>>	execve("/sbin/init",argv_init,envp_init);    //<--- problem
>>
>>	execve("/etc/init",argv_init,envp_init);
>>	execve("/bin/init",argv_init,envp_init);
>>	execve("/bin/sh",argv_init,envp_init);
>>	panic("No init found.  Try passing init= option to kernel.");
>>} 
>>
>>The system call execve("/sbin/init",argv_init,envp_init) will start a
>>background process.
>>In my case, it could not start the process, that is, system hangs
>>
> there
> 
>>and 
>>execve("/etc/init",argv_init,envp_init) could not be executed.
>>
>>
>>Could you tell me where could I find the source code for the
>>
> executable
> 
>>/sbin/init? 
>>
>>Thank you very much for your help.
>>
> 
> /sbin/init is part of the SysVInit package.
> 
> Your problem is most likely NOT with /sbin/init itself. I would start
by
> loading 
> sash first; if that works, try a static bash; if that works, try a
> dynamically 
> linked bash.
> 
> Pete
> 
> 
> 
> 
