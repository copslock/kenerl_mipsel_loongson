Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 22:49:10 +0000 (GMT)
Received: from imap.gmx.net ([IPv6:::ffff:213.165.64.20]:25813 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225323AbUK2WtE>;
	Mon, 29 Nov 2004 22:49:04 +0000
Received: (qmail 16638 invoked by uid 65534); 29 Nov 2004 22:48:58 -0000
Received: from c190145.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.190.145)
  by mail.gmx.net (mp009) with SMTP; 29 Nov 2004 23:48:58 +0100
X-Authenticated: #947741
Message-ID: <41ABA8E2.40709@gmx.net>
Date: Mon, 29 Nov 2004 23:55:30 +0100
From: TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen P. Becker" <geoman@gentoo.org>
CC: linux-mips@linux-mips.org
Subject: Re: Cross tool chain based on gcc-3.4.x
References: <41A3CE25.7040406@gmx.net> <41A3E3E7.7020701@gentoo.org> <41A510DE.8030004@gmx.net> <41A536A5.5050508@gentoo.org>
In-Reply-To: <41A536A5.5050508@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

Stephen P. Becker wrote:

> TheNop wrote:
>
>> Stephen P. Becker wrote:
>>
>>> TheNop wrote:
>>>
>>>> Hello,
>>>>
>>>> I try to get a cross compiler based on
>>>> gcc-3.4.2
>>>> glibc-2.3.2
>>>> binutils-2.15
>>>> working;  without success.
>>>>
>>>> Is anyone using a cross compiler base on  gcc-3.4.x for a mips big 
>>>> endian target?
>>>>
>>>> Best regarts
>>>> TheNop
>>>>
>>>
>>> I've got a very recent i686->mips-unknown-linux-gnu cross-toolchain 
>>> available 
>>> at:http://dev.gentoo.org/~geoman/mips-glibc-crosstools.tar.bz2 if 
>>> you are too frustrated with building your own.
>>>
>>> It includes gcc-3.4.3, glibc-2.3.4 (20041102), and binutils 
>>> 2.15.91.0.2.
>>>
>>> Steve
>>>
>>>
>> Hi Steve,
>>
>> thanx a lot.
>> This tool chain works perfectly for me. Now I can build 2.6.x kernel.
>> In the past I tried to build a cross tool chain using crosstools. I 
>> don`t get any combination of gcc-3.4.x/glibc-2.x.x working. Only the 
>> gcc-3.4.x-glibc-2.3.3 combination I could compile without errors, but 
>> I couldn't compile a 2.6.x kernel.
>>
>> Could you please tell me, how you compile the tool chain?
>> It would be great, if you can provide me a script or a list of 
>> patches you applied for building.
>>
>> Best regards
>> TheNop
>>
>>
>
> Actually, if you just wanted to build kernels, you don't need glibc at 
> all.  Just build binutils and then a bootstrap gcc compiler, and you 
> are set.  The only reason I messed with a full toolchain at all is so 
> that I can use c++ through distcc.
>
> Steve
>
>
Hi Steve,

I also want to build a root file system for the target.
I tried to build the tool chain you described above.
I used crossdev on gentoo: "crossdev --arch=mips --vbinutils=2.15.91.0.2 
--vheaders=2.4.25 --vgcc=3.4.3 --vglibc=2.3.4.20041102"
But it fails.

mips/mips-unknown-linux-gnu/sys-include -O2  -DIN_GCC -DCROSS_COMPILE   
-W -Wall -Wwrite-strings -Wstrict-prototypes -Wmissing-prototypes 
-Wold-style-definition  -isystem ./include  -fPIC -DHAVE_SYSLOG -g  
-DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED  -D_LIBC_PROVIDES_SSP_ -I. -I. 
-I../../gcc -I../../gcc/. -I../../gcc/../include   -DL_eprintf -c 
../../gcc/libgcc2.c -o libgcc/./_eprintf.o
/var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc/xgcc 
-B/var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc/ 
-B/home/crossdev/mips/mips-unknown-linux-gnu/bin/ 
-B/home/crossdev/mips/mips-unknown-linux-gnu/lib/ -isystem 
/home/crossdev/mips/mips-unknown-linux-gnu/include -isystem 
/home/crossdev/mips/mips-unknown-linux-gnu/sys-include -O2  -DIN_GCC 
-DCROSS_COMPILE   -W -Wall -Wwrite-strings -Wstrict-prototypes 
-Wmissing-prototypes -Wold-style-definition  -isystem ./include  -fPIC 
-DHAVE_SYSLOG -g  -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED  
-D_LIBC_PROVIDES_SSP_ -I. -I. -I../../gcc -I../../gcc/. 
-I../../gcc/../include   -DL__gcc_bcmp -c ../../gcc/libgcc2.c -o 
libgcc/./__gcc_bcmp.o
../../gcc/unwind-dw2.c: In function `uw_frame_state_for':
../../gcc/unwind-dw2.c:1027: error: structure has no member named `sc_regs'
../../gcc/unwind-dw2.c:1027: error: structure has no member named `sc_pc'
make[2]: *** [libgcc/./unwind-dw2.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory 
`/var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc'
make[1]: *** [libgcc.a] Error 2
make[1]: Leaving directory 
`/var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc'
make: *** [all-gcc] Error 2

How did you build the tool chain?
What kernel headers did you use?
If I use kernel headers 2.6.8.1 (I realy need 2.6 heraders!)  the 
installation of the headers fails!

It would be great If you can tell me which paramerter I have to use with 
crossdev to get a working tool chain.

Best regards
TheNop
