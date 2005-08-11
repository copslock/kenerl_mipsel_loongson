Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2005 18:15:25 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.200]:22129 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8225322AbVHKRPD>;
	Thu, 11 Aug 2005 18:15:03 +0100
Received: by zproxy.gmail.com with SMTP id 13so317901nzn
        for <linux-mips@linux-mips.org>; Thu, 11 Aug 2005 10:19:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=dtZXvtFAuDyN753Kx6znIxkMEdouRFnSAh/U0kZA+a0zOSxrMhy8L0DXQoRuNKiHJ9+e2pOBDAp3H5sgKvu7x21T5+F41y28VOO3fFMB0I5Q94LF1kxlbsusQKL+/Rat58AcufMN+9o4KuIivRqFnxAlaZes5mmv/G/+LKdqHk0=
Received: by 10.36.75.13 with SMTP id x13mr1638372nza;
        Thu, 11 Aug 2005 10:19:08 -0700 (PDT)
Received: by 10.36.65.8 with HTTP; Thu, 11 Aug 2005 10:19:08 -0700 (PDT)
Message-ID: <1634a4f105081110194fe8603d@mail.gmail.com>
Date:	Thu, 11 Aug 2005 12:19:08 -0500
From:	Danny Home Educator <dannyhsdad@gmail.com>
To:	linux-mips@linux-mips.org
Subject: QEMU and mips linux
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1028_20557494.1123780748244"
Return-Path: <dannyhsdad@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dannyhsdad@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_1028_20557494.1123780748244
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I've gotten the binutils and gcc per chain tools directions (except for=20
mips-unknown-linux-gnu i.e., 32 bit version of the compiler, etc.) and buil=
t=20
my own mips cross compiler (I'm on Linux/x86). Then I got the kernel source=
=20
from CVS and in the make menuconfig, all I did was change the machine=20
selection to be QEMU and CPU selection to be R4x00.

Then I hand edited the .config to enable CONFIG_CROSSCOMPILE and then I=20
built the kernel:

make CROSS_COMPILE=3Dmips-unknown-linux-gnu-

And then I got compile failure with:

LD init/built-in.o
LD .tmp_vmlinux1
arch/mips/kernel/built-in.o: In function `show_cpuinfo':
proc.c:(.text+0x9c88): undefined reference to `get_system_type'
proc.c:(.text+0x9c88): relocation truncated to fit: R_MIPS_26 against=20
`get_system_type'
make: *** [.tmp_vmlinux1] Error 1


I then edited arch/mips/qemu/q-setup.c to add:

9,14d8
< const char *get_system_type(void)
< {
< return "QEMU MIPS";
< }
<
<

And I was able to build vmlinux. I've gotten qemu-0.7.1, created blank=20
bios.bin file and when I try to run it, I get:

% qemu-system-mips -kernel vmlinux -m 16 -nographic
(qemu) mips_r4k_init: start
mips_r4k_init: load BIOS '/usr/local/share/qemu/mips_bios.bin' size 131072

And hangs there.

Has anyone else tried qemu with the latest mips linux? Thanks.

------=_Part_1028_20557494.1123780748244
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I've gotten the binutils and gcc per chain tools directions (except for
mips-unknown-linux-gnu i.e., 32 bit version of the compiler, etc.) and
built my own mips cross compiler (I'm on Linux/x86).&nbsp; Then I got
the kernel source from CVS and in the make menuconfig, all I did was
change the machine selection to be QEMU and CPU selection to be R4x00.<br>
<br>
Then I hand edited the .config to enable CONFIG_CROSSCOMPILE and then I bui=
lt the kernel:<br>
<br>
make CROSS_COMPILE=3Dmips-unknown-linux-gnu-<br>
<br>
And then I got compile failure with:<br>
<br>
&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init/built-in.o<br>
&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tmp_vmlinux1<br>
arch/mips/kernel/built-in.o: In function `show_cpuinfo':<br>
proc.c:(.text+0x9c88): undefined reference to `get_system_type'<br>
proc.c:(.text+0x9c88): relocation truncated to fit: R_MIPS_26 against `get_=
system_type'<br>
make: *** [.tmp_vmlinux1] Error 1<br>
<br>
<br>
I then edited arch/mips/qemu/q-setup.c to add:<br>
<br>
9,14d8<br>
&lt; const char *get_system_type(void)<br>
&lt; {<br>
&lt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;QEMU MIPS&quot;;<br>
&lt; }<br>
&lt;<br>
&lt;<br>
<br>
And I was able to build vmlinux.&nbsp; I've gotten qemu-0.7.1, created blan=
k bios.bin file and when I try to run it, I get:<br>
<br>
% qemu-system-mips -kernel vmlinux -m 16 -nographic<br>
(qemu) mips_r4k_init: start<br>
mips_r4k_init: load BIOS '/usr/local/share/qemu/mips_bios.bin' size 131072<=
br>
<br>
And hangs there.<br>
<br>
Has anyone else tried qemu with the latest mips linux?&nbsp; Thanks.<br>

------=_Part_1028_20557494.1123780748244--
