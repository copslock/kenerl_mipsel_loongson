Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0SCSTW23140
	for linux-mips-outgoing; Mon, 28 Jan 2002 04:28:29 -0800
Received: from intotoinc.com (sdsl-66-80-10-146.dsl.sca.megapath.net [66.80.10.146])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0SCSMP23127
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 04:28:22 -0800
Received: from localhost (rajeshbv@localhost)
	by intotoinc.com (8.11.0/8.11.0) with ESMTP id g0SBRUu03495;
	Mon, 28 Jan 2002 03:27:30 -0800
Date: Mon, 28 Jan 2002 03:27:30 -0800 (PST)
From: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
To: linux-mips@oss.sgi.com
cc: rajeshbv@intotoinc.com
Subject: INSMOD failing on MIPS
Message-ID: <Pine.LNX.4.21.0201280304300.3163-100000@intotoinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All,
 
I encountered a strange problem when i tried  to insert a module on MIPS
79S334A board with linux kernel version 2.4.3
 
When a single test file "temp.c" is compiled as
 
mipsel-linux-gcc -I /home/idt/linux/include/asm/gcc -D__KERNEL__
-I/home/idt/linux/include -Wall -Wstrict-prototypes -O2
-fno-strict-aliasing -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
-mcpu=r4600 -mips2 -Wa,--trap -pipe -DMODULE -mlong-calls -o temp.o -c
temp.c
 
and i try to insmod the output 'temp.o' file, insmod is working fine.
 
But when i link two '.o' files with ld as
"mipsel-linux-ld -r -o temp.o temp.o temp1.o"
and insert the output 'temp.o' it is crashing.
 
While debugging i came to know that the Global Variable is allocated
memory at an address 0x4 which is an invalid memory in MIPS.
The error displayed on console is
>Unable to handle kernel paging request at virtual address 00000004, epc
== c00000b4, ra == 80216e54
>Oops in fault.c:do_page_fault, line 172
 
If i declare the variable as "static" the memory allocation is in proper
memory map as it will go into DATA section.
This means some problem is coming for the relocatable symbols while
linking.
Please suggest any more options to be added/deleted while
compiling/linking the module or any other missing thing.
 
The C file content is :
 
#include <linux/kernel.h>
#ifdef MODULE
#include <linux/module.h>
#else
# include <linux/init.h>
#endif
 
int MyGlobalVar;
 
int init_module (void)
{
 
  printk("<1>My Test Module Inserted\n");
  printk("<1>MyGlobalVar Address : %x\n", &MyGlobalVar);
 
  MyGlobalVar = NULL;
  return 0;
}
 
void cleanup_module()
{
  printk("<1>My Test Module Removed\n");
}
 
Thanks and Regards,
--Rajesh
