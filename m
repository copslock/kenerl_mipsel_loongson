Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2005 08:22:49 +0100 (BST)
Received: from ns.innomedia.soft.net ([IPv6:::ffff:164.164.79.130]:26858 "EHLO
	gateway.innomedia.soft.net") by linux-mips.org with ESMTP
	id <S8226438AbVGPHWa>; Sat, 16 Jul 2005 08:22:30 +0100
Received: from [192.168.52.8] ([192.168.52.8])
	(authenticated bits=0)
	by gateway.innomedia.soft.net (8.12.11/8.12.11) with ESMTP id j6G7NqAY023599
	for <linux-mips@linux-mips.org>; Sat, 16 Jul 2005 12:53:52 +0530
Message-ID: <42D8B608.4020600@innomedia.soft.net>
Date:	Sat, 16 Jul 2005 12:53:52 +0530
From:	kanhu <kanhu@innomedia.soft.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Problem with loadable module
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.80/970/Wed Jul  6 21:30:45 2005
	clamav-milter version 0.80j
	on 127.0.0.1
X-Virus-Status:	Clean
Return-Path: <kanhu@innomedia.soft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kanhu@innomedia.soft.net
Precedence: bulk
X-list: linux-mips

Hi all,

I am using uClinux(uClinux-dist-20030305) on ARCH=mipsnommu and the 
CROSS_COMPILE=mipseb-linux- .I have installed the toolchain 
mipseb-linux-3.2.2-0.8.0.i386.rpm
I have written a simple loadable hello module and compiled it, It has 
been compiled successfully and when I try to load it by

/>insmod /lib/modules/hello
 It gives the following  error
======================
Using /lib/modules/hello
insmod: unresolved symbol _gp_disp
pid 25: failed 256
 =======================
What might be the problem ?

My Makefile looks like this
============================
TARGET = hello
OBJS =  hello.o
                                                                        
                                                 
CFLAGS = -DMODULE -D__KERNEL__ -Wl,-elf2flt -Dlinux -D__linux__ -Dunix 
-D__uClinux__ -DEMBED -DLINUX
CFLAGS += -I../../linux-2.4.x/include -I../../linux-2.4.x/include/linux
CFLAGS += -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common
CFLAGS += -fno-common -pipe -fno-builtin -D__linux__ -DNO_MM
CFLAGS += -nostdinc -msoft-float
CFLAGS += 
-I/opt/uClinux/toolchain/mipseb/3.2.2/lib/gcc-lib/mipseb-linux/3.2.2/include
CFLAGS += -DNDEBUG
                                                                        
                                                 
all: $(TARGET)
                                                                        
                                                 
$(TARGET): $(OBJS)
        $(LD) -r $(OBJS) -o $(TARGET)
                                                                        
                                                 
romfs:
        $(ROMFSINST) /lib/modules/$(TARGET)
                                                                        
                                                 
clean:
        -rm -f $(TARGET) *.elf *.gdb *.o
=======================================

Any idea to proceed with is welcome.



With Thanks & Regards
          Kanhu
