Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f42NPvS15468
	for linux-mips-outgoing; Wed, 2 May 2001 16:25:57 -0700
Received: from mail.palmchip.com ([63.203.52.7])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f42NPuF15465
	for <linux-mips@oss.sgi.com>; Wed, 2 May 2001 16:25:56 -0700
Received: from palmchip.com (sabretooth.palmchip.com [10.1.10.110])
	by mail.palmchip.com (8.11.0/8.9.3) with ESMTP id f42NPpc28762
	for <linux-mips@oss.sgi.com>; Wed, 2 May 2001 16:25:51 -0700
Message-ID: <3AF098B7.F111B230@palmchip.com>
Date: Wed, 02 May 2001 16:31:03 -0700
From: Ian Thompson <iant@palmchip.com>
Organization: Palmchip Corporation
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Debug format problem with -ggdb flag
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,

I'm running into problems with the debug information that is generated
by the kernel compilation process.  Basically, I'm seeing that 
multiple function symbols have the same begin address in the .mdebug
section.  For example -- the init_arch and r3081_wait functions in my
build have differnet addresses as far as compilation is concerned, and
code executes correctly.  When I look into the .mdebug section, I see 
that the begin, end, stab, and external records are all correct for 
the r3081_wait function, but that the begin record for the init_arch
function is the same as that for the the r3081_wait function!  This in
turn seems to be causing the stab and external records to be incorrect,
causing symbolic problems in my debugger.  

I've traced the problem down, and it seems to be a side-effect of 
partial linking.  When the linker links multiple .o files into another
.o file (which is later used as input to another ld command), the 
debug records inside the .mdebug section are getting corrupted.  Has
anyone run into this problem before?  Any suggestions of other flags
I can pass into the partial link that may help?  I'm using the mipsel
rpm of binutils 2.9.5-3.  Or, are there any alternatives to 
partial linking that don't involve a lot of makefile manipulation?

I've tried using the -gcoff option to remove the stab records, but that
option does not allow the 2.4 kernel to compile under egcs 2.91.66.

Any ideas?  Thanks,

-ian

-- 
----------------------------------------
Ian Thompson           tel: 408.952.2023
Firmware Engineer      fax: 408.570.0910
Palmchip Corporation   www.palmchip.com
