Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2005 14:08:34 +0000 (GMT)
Received: from xizor.is.scarlet.be ([IPv6:::ffff:193.74.71.21]:7105 "EHLO
	xizor.is.scarlet.be") by linux-mips.org with ESMTP
	id <S8225256AbVAMOI1> convert rfc822-to-8bit; Thu, 13 Jan 2005 14:08:27 +0000
Received: from (fuji.is.scarlet.be [193.74.71.41]) 
	by xizor.is.scarlet.be  with ESMTP id j0DE8OC17533 
	for <linux-mips@linux-mips.org>; 
	Thu, 13 Jan 2005 15:08:24 +0100
Date: Thu, 13 Jan 2005 15:08:24 +0100
Message-Id: <IA9DY0$DCC07516FD959EE0729448D36856A324@scarlet.be>
Subject: unresolved (soft)float symbols
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "Philippe De Swert" <philippedeswert@scarlet.be>
To: "linux-mips" <linux-mips@linux-mips.org>
X-XaM3-API-Version: 4.1 (B54)
X-type: 0
X-SenderIP: 195.144.76.34
Return-Path: <philippedeswert@scarlet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: <IA9DY0$DCC07516FD959EE0729448D36856A324
Envelope-Id: <IA9DY0$DCC07516FD959EE0729448D36856A324
X-archive-position: 6899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippedeswert@scarlet.be
Precedence: bulk
X-list: linux-mips

Hello people,

I have a custom build module with some float operations in it. I build a
2.4.17 kernel for a mips32 core (BCM6348 chip). It boots up fine, busybox
works nicely, also some other apps like dropbear and thttpd do what they are
expected to do.

I build everything with soft-floats using a uclibc toolchain (kernel +
filesystem). This is the configuration of my toolchain.

~#mips-linux-gcc -v
Reading specs from
/vobs/linux/tools/3pp-build/gcc/../../mips/gcc/lib/gcc-lib/mips-linux-uclibc/3.3.4/specs
Configured with:
/vobs/linux/tools/3pp-build/gcc/toolchain_build_mips_nofpu/gcc-3.3.4/configure
--prefix=/vobs/linux/tools/3pp-build/gcc/../../mips/gcc
--build=i386-pc-linux-gnu --host=i386-pc-linux-gnu --target=mips-linux-uclibc
--enable-languages=c,c++ --enable-shared --disable-__cxa_atexit
--enable-target-optspace --with-gnu-ld --disable-nls --enable-multilib
--without-float --enable-sjlj-exceptions
Thread model: posix
gcc driver version 3.3.4 executing gcc version 3.3.3

The module builds fine also, but when insmodding I get the following error.

insmod: unresolved symbol __fixdfsi
insmod: unresolved symbol __floatsidf
insmod: unresolved symbol __muldf3
insmod: unresolved symbol __adddf3

As these are all float operations I am wondering about the following things:

1.why they are in there? I have a soft-float toolchain....
2.Is there float support in the kernel? While googling for it I found a few
things talking about FP point in the kernel. Does it have something to do with
the Algorithmics/MIPS FPU emulator. (Although it does not work emulator or
not. Which I expected because it should only be used by apps which emit FPU
calls, and this should not happen because I use a softfloat toolchain). So I
expect it does not really have something to do with this.
3.I took care of using the same compiler options as the kernel compilation
uses. I guess this is the correct way, and the problems are thus not related
to this.

Any pointers to a solution would be helpful. I am trying woth a hard-float
toolchain now (it only takes a while to compile everything). I could also not
dig up anything similar in the archives.

Thank you,

Philippe 

| Philippe De Swert -GNU/linux - uClinux freak-      
|      
| Stag developer http://stag.mind.be/  
| Emdebian developer: http://www.emdebian.org  
|   
| Please do not send me documents in a closed format. (*.doc,*.xls,*.ppt)    
| Use the open alternatives. (*.pdf,*.ps,*.html,*.txt)    
| Why? http://pallieter.is-a-geek.org:7832/~johan/word/english/    

-------------------------------------------------------
NOTE! My email address is changing to ... @scarlet.be
Please make the necessary changes in your address book. 
