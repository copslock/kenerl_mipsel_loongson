Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2006 17:07:02 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:48745 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037712AbWIKQHA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Sep 2006 17:07:00 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1394619nfc
        for <linux-mips@linux-mips.org>; Mon, 11 Sep 2006 09:06:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=ScE+XpczxooQutcmTSD/5hE5fneQI5MXj1kPI3l8iUqZw9HPfp/dUsBaFxTfVNf8BXIOlDdZDcqQ0vnjtFf9+uns8uWlilf6uCQD52IZvtEgD0djvBL1TLM3GaZTZREQwgt0+r9dYZEQOeYKbW2v2t3yfRFM5lyoitDl0vlVD5k=
Received: by 10.48.242.19 with SMTP id p19mr8303147nfh;
        Mon, 11 Sep 2006 09:06:59 -0700 (PDT)
Received: from ?192.168.178.25? ( [195.4.50.88])
        by mx.gmail.com with ESMTP id 38sm4580123hua.2006.09.11.09.06.58;
        Mon, 11 Sep 2006 09:06:59 -0700 (PDT)
Message-ID: <450589A6.5040808@gmail.com>
Date:	Mon, 11 Sep 2006 18:07:02 +0200
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: QEMU MIPS user space emulation issue
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From:	Dirk Behme <dirk.behme@googlemail.com>
Return-Path: <dirk.behme@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dirk.behme@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi,

we have an issue using QEMUs MIPS user space emulation 
running programs compiled with mipsel glibc based 
crosscompiler [1]. Because I'm not sure if it's a QEMU or 
toolchain (or anything else?) issue, I'd like to ask the 
experts here.

Up to now, the conclusion from [1] is that QEMUs mipsel user 
space emulation fails executing a simple hello world program 
if compiled with glibc based mipsel toolchain build with 
crosstool and linked dynamically. Compiled with toolchain 
using uClib or same program linked statically (-static) is okay.

For example, hello world compiled with mipsel toolchain 
build with crosstool-0.42 configuration

cat mipsel.dat gcc-3.4.1-glibc-2.3.2.dat

fails if dynamically linked. As mentioned above, using 
-static is okay.

If failing, debug output shows that code

...
0x401fa00c:  lw t9,-32600(gp)
0x401fa010:  addiu      a0,a0,30820
0x401fa014:  addiu      a1,a1,29452
0x401fa018:  addiu      a3,a3,25856
0x401fa01c:  jalr       t9
0x401fa020:  li a2,161
...

fails because it seems that it gets a wrong jump address in t9:

pc=0x00012a2c HI=0x00000000 LO=0x00000000 ds 0003 00000000 0
GPR00: r0 00000000 at 00000000 v0 401f60d4 v1 00000008
GPR04: a0 00017864 a1 0001730c a2 000000a1 a3 00016500
GPR08: t0 90000000 t1 401f6000 t2 40000000 t3 6fffffff
GPR12: t4 70000053 t5 401f3c20 t6 401f3f20 t7 00000063
GPR16: s0 6fffff72 s1 00000000 s2 00000000 s3 00000000
GPR20: s4 00000000 s5 00000000 s6 00000000 s7 00000000
GPR24: t8 6ffffdff t9 00012a2c k0 00000000 k1 00000000
GPR28: gp 40257020 sp 401f3c08 s8 00000000 ra 401fa024
CP0 Status 0x30400014 Cause 0x00000000 EPC 0x00000000
Config0 0x80000082 Config1 0x1e190c8b LLAddr 0x00000000
CP1 FCR0 0x00000110 FCR31 0x00000000 SR.FR 0
...
cpu_mips_handle_mmu_fault pc 00012a2c ad 00012a2c rw 0 
is_user 1 smmu 0

Any ideas or hints where to search?

Many thanks

Dirk

[1] Thread "MIPS little endian user space emulation" on QEMU 
devel mailinglist
http://lists.gnu.org/archive/html/qemu-devel/2006-09/msg00090.html
