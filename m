Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PJLca26951
	for linux-mips-outgoing; Mon, 25 Feb 2002 11:21:38 -0800
Received: from ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PJLX926936
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 11:21:33 -0800
Received: from [192.168.1.5] (IDENT:root@localhost.localdomain [127.0.0.1])
	by  ayrnetworks.com (8.11.6/8.11.2) with ESMTP id g1PIKKe03336;
	Mon, 25 Feb 2002 10:20:20 -0800
Mime-Version: 1.0
X-Sender: kph@127.0.0.1
Message-Id: <a05100301b8a02f9aefa3@[192.168.1.5]>
In-Reply-To: <20020223123037.A8314@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIMELICFAA.mdharm@momenco.com>
 <a05100300b89cfbd22145@[192.168.1.5]> <20020223123037.A8314@momenco.com>
Date: Mon, 25 Feb 2002 10:21:24 -0800
To: Matthew Dharm <mdharm@momenco.com>
From: Kevin Paul Herbert <kph@ayrnetworks.com>
Subject: Re: Anyone have the e1000.o driver working?
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

At 12:30 PM -0800 2/23/02, Matthew Dharm wrote:
>Well, I finally got the latest version running (see my other message to
>this list... where did that go, anyway?).  The problem was that the code to
>deal with CONFIG_PROC_FS is causing a crash... and it looks like it might
>be a toolchain bug.
I'm building with CONFIG_PROC_FS, and it works fine for me. It seems 
that your problem may be with ld or insmod; it seems that your .data 
section is getting placed at zero. Does the address for objects in 
.data seem reasonable when you get a map from insmod?

Here is my gcc command line to build e1000_main.o for a RM7000.

/opt/local/mips-ayr-linux-gnu/bin//gcc -Wall  -DLINUX -D__KERNEL__ 
-DMODULE -DEXPORT_SYMTAB -O2 -pipe -I../../../linux-2.4.2/include -I. 
-DMODVERSIONS -include 
../../../linux-2.4.2/include/linux/modversions.h -mno-abicalls 
-fno-pic -mcpu=r8000 -mips2 -Wa,--trap -mlong-calls 
-fomit-frame-pointer -fno-strict-aliasing -G 0   -c  e1000_main.c


>
>What toolchain are you using?
gcc --version reports 2.97. We got our tools from MonteVista Hard Hat 
Linux... I'm not sure about the actual toolchain version, but I can 
ask around here if you need.

I'm running the 3.5.19 driver and the only modifications that I made 
are due to our hardware (we use the i82543 but in our own board, so 
the usage of the software defined I/O pins is different than intel), 
and we don't use an intel  format serial eeprom for mac address and 
setup.

I also had 3.0.<whatever> working without problems.

Our hardware is RM7000, big endian.

I hope this helps... good luck with your bringup.

Kevin
-- 
