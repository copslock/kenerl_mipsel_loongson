Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7KJk0E29298
	for linux-mips-outgoing; Mon, 20 Aug 2001 12:46:00 -0700
Received: from smtp (smtp.psdc.com [209.125.203.83])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7KJjt929295
	for <linux-mips@oss.sgi.com>; Mon, 20 Aug 2001 12:45:55 -0700
Received: from ex2k.pcs.psdc.com ([172.19.1.1])
 by smtp (NAVIEG 2.1 bld 63) with SMTP id M2001082012464116031
 for <linux-mips@oss.sgi.com>; Mon, 20 Aug 2001 12:46:41 -0700
content-class: urn:content-classes:message
Subject: The printf() function in libc of glibc-2.0.6 can print nothing.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65
Date: Mon, 20 Aug 2001 12:43:23 -0700
Message-ID: <84CE342693F11946B9F54B18C1AB837B0A254B@ex2k.pcs.psdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The printf() function in libc of glibc-2.0.6 can print nothing.
Thread-Index: AcEpsF7MA2c/rm7GQwGSJUOMbvImuQ==
From: "Steven Liu" <stevenliu@psdc.com>
To: <linux-mips@oss.sgi.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f7KJju929296
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, ALL:

I have successfully built linux kernel 2.2.12 on mips and glibc-2.0.6
with the following steps and options: 

Under glibc-2.0.6/build, run

CFLAGS="-mips2 -mcpu=r6000 -mmemcpy -O2 -D__MIPSEB__ " CC=mips-linux-gcc
BUILD_CC=gcc AR=mips-linux-ar RANLIB=mips-linux-ranlib ../configure
--prefix=/usr --host=mips-linux
--enable-add-ons=crypt,linuxthreads,localedata --disable-profile
--with-headers=/home/wenbo/linux/include

In file config.make, change CC = gcc into CC = mips-linux-gcc.

Then run make.

The build looks OK.

I also built an aplication as following:

liu.c:

#include <stdio.h>

void main()
{
  printf("My program is running\n");
}

Makefile:

ARCH = mips

.EXPORT_ALL_VARIABLES:


CROSS_COMPILE 	=mips-linux-

AS	=$(CROSS_COMPILE)as
LD	=$(CROSS_COMPILE)ld
CC	=$(CROSS_COMPILE)gcc  -D__mips__
-I/home/sliu/mips_lib/usr/include  
CPP	=$(CC) -E
AR	=$(CROSS_COMPILE)ar
NM	=$(CROSS_COMPILE)nm
STRIP	=$(CROSS_COMPILE)strip
OBJCOPY	=$(CROSS_COMPILE)objcopy
OBJDUMP	=$(CROSS_COMPILE)objdump
MAKE	=make
GENKSYMS=/sbin/genksyms

LINKFLAGS = -static
LIBS =/home/sliu/mips_lib/usr/lib/libc.a
CFLAGS = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -mips2
-mcpu=r6000 -mmemcpy
#CFLAGS = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -mmemcpy

# use '-fno-strict-aliasing', but only if the compiler can take it
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
          $(LIBS)  \
	  -o liu
	$(NM) liu | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aU]
\)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map


liu.o: liu.c 
	$(CC) $(CFLAGS) $(PROFILING) -c -o $*.o $<

clean:
	rm -f *.o liu



------------------------------------------------------ Problem
-----------------------------------------------------------

The printf could not print the string "My program is running" on the
screen.

Any suggessions are greatly appreciated.

Regards and thanks.


Steven Liu
