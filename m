Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2004 11:19:21 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:35282 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8225334AbUJHKTQ>; Fri, 8 Oct 2004 11:19:16 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i98AF5GG025445
	for <linux-mips@linux-mips.org>; Fri, 8 Oct 2004 15:45:05 +0530
Message-ID: <4166685E.7030001@procsys.com>
Date: Fri, 08 Oct 2004 15:43:50 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - linker errors
References: <41665DEA.3090307@procsys.com> <416663B2.5010006@procsys.com>
In-Reply-To: <416663B2.5010006@procsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

T. P. Saravanan wrote:

> ar -d lib_pic.a strtold.os
>
> got me be beyond this point. (If somebody knows that this is not the 
> way to do it - let me know.)
>
> -Sa.
>
Further liker errors:

sara@eyeore: [over] ~/build/glibc/objdir6$ make
make -r PARALLELMFLAGS="" CVSOPTS="" -C ../glibc-2.3.3 objdir=`pwd` all
make[1]: Entering directory `/home/sara/build/glibc/glibc-2.3.3'
make  -C csu subdir_lib
.
.
.
make[4]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/time'
make[3]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/elf'
make[2]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/elf'
gcc -mabi=32   -nostdlib -nostartfiles -r -o 
/home/sara/build/glibc/objdir6/libc_pic.os \
 -Wl,-d -Wl,--whole-archive /home/sara/build/glibc/objdir6/libc_pic.a
gcc -mabi=32   -shared -Wl,-O1 \
  -nostdlib -nostartfiles \
   -Wl,-dynamic-linker=/home/sara/usr/local/lib/ld.so.1  \
  -Wl,--verbose 2>&1 | \
  sed > /home/sara/build/glibc/objdir6/shlib.ldsT \
      -e '/^=========/,/^=========/!d;/^=========/d' \
      -e 's/^.*\.hash[     ]*:.*$/  .note.ABI-tag : { *(.note.ABI-tag) } 
&/' \
      -e 's/^.*\*(\.dynbss).*$/& \
     PROVIDE(__start___libc_freeres_ptrs = .); \
     *(__libc_freeres_ptrs) \
     PROVIDE(__stop___libc_freeres_ptrs = .);/'
mv -f /home/sara/build/glibc/objdir6/shlib.ldsT 
/home/sara/build/glibc/objdir6/shlib.lds
gcc -mabi=32   -shared -static-libgcc -Wl,-O1  -Wl,-z,defs 
-Wl,-dynamic-linker=/home/sara/usr/local/lib/ld.so.1  
-B/home/sara/build/glibc/objdir6/csu/  
-Wl,--version-script=/home/sara/build/glibc/objdir6/libc.map 
-Wl,-soname=libc.so.6  -nostdlib -nostartfiles -e __libc_main 
-L/home/sara/build/glibc/objdir6 -L/home/sara/build/glibc/objdir6/math 
-L/home/sara/build/glibc/objdir6/elf 
-L/home/sara/build/glibc/objdir6/dlfcn 
-L/home/sara/build/glibc/objdir6/nss 
-L/home/sara/build/glibc/objdir6/nis -L/home/sara/build/glibc/objdir6/rt 
-L/home/sara/build/glibc/objdir6/resolv 
-L/home/sara/build/glibc/objdir6/crypt 
-L/home/sara/build/glibc/objdir6/linuxthreads 
-Wl,-rpath-link=/home/sara/build/glibc/objdir6:/home/sara/build/glibc/objdir6/math:/home/sara/build/glibc/objdir6/elf:/home/sara/build/glibc/objdir6/dlfcn:/home/sara/build/glibc/objdir6/nss:/home/sara/build/glibc/objdir6/nis:/home/sara/build/glibc/objdir6/rt:/home/sara/build/glibc/objdir6/resolv:/home/sara/build/glibc/objdir6/crypt:/home/sara/build/glibc/objdir6/linuxthreads 
-o /home/sara/build/glibc/objdir6/libc.so -T 
/home/sara/build/glibc/objdir6/shlib.lds 
/home/sara/build/glibc/objdir6/csu/abi-note.o 
/home/sara/build/glibc/objdir6/elf/soinit.os 
/home/sara/build/glibc/objdir6/libc_pic.os 
/home/sara/build/glibc/objdir6/elf/sofini.os 
/home/sara/build/glibc/objdir6/elf/interp.os 
/home/sara/build/glibc/objdir6/elf/ld.so -lgcc -lgcc_eh
/home/sara/build/glibc/objdir6/libc_pic.os(.text+0x88f3c): In function 
`round_and_return':
../stdlib/strtod.c:296: undefined reference to `__mpn_construct_long_double'
/home/sara/build/glibc/objdir6/libc_pic.os(.text+0x920bc):../stdlib/strtod.c:296: 
undefined reference to `__mpn_construct_long_double'
collect2: ld returned 1 exit status
make[1]: *** [/home/sara/build/glibc/objdir6/libc.so] Error 1
make[1]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3'
make: *** [all] Error 2

Anybody knows how to fix this?

-Sa.
