Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 23:11:26 +0000 (GMT)
Received: from pop.gmx.de ([IPv6:::ffff:213.165.64.20]:58241 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225321AbUK2XLV>;
	Mon, 29 Nov 2004 23:11:21 +0000
Received: (qmail 20737 invoked by uid 65534); 29 Nov 2004 23:11:15 -0000
Received: from c190145.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.190.145)
  by mail.gmx.net (mp001) with SMTP; 30 Nov 2004 00:11:15 +0100
X-Authenticated: #947741
Message-ID: <41ABAE1C.5020809@gmx.net>
Date: Tue, 30 Nov 2004 00:17:48 +0100
From: TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen P. Becker" <geoman@gentoo.org>
CC: linux-mips@linux-mips.org
Subject: Re: Cross tool chain based on gcc-3.4.x
References: <41A3CE25.7040406@gmx.net> <41A3E3E7.7020701@gentoo.org> <41A510DE.8030004@gmx.net> <41A536A5.5050508@gentoo.org> <41ABA8E2.40709@gmx.net> <41ABAA4F.6030403@gentoo.org>
In-Reply-To: <41ABAA4F.6030403@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

Stephen P. Becker wrote:

>> Hi Steve,
>>
>> I also want to build a root file system for the target.
>> I tried to build the tool chain you described above.
>> I used crossdev on gentoo: "crossdev --arch=mips 
>> --vbinutils=2.15.91.0.2 --vheaders=2.4.25 --vgcc=3.4.3 
>> --vglibc=2.3.4.20041102"
>> But it fails.
>>
>> mips/mips-unknown-linux-gnu/sys-include -O2  -DIN_GCC 
>> -DCROSS_COMPILE   -W -Wall -Wwrite-strings -Wstrict-prototypes 
>> -Wmissing-prototypes -Wold-style-definition  -isystem ./include  
>> -fPIC -DHAVE_SYSLOG -g  -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED  
>> -D_LIBC_PROVIDES_SSP_ -I. -I. -I../../gcc -I../../gcc/. 
>> -I../../gcc/../include   -DL_eprintf -c ../../gcc/libgcc2.c -o 
>> libgcc/./_eprintf.o
>> /var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc/xgcc 
>> -B/var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc/ 
>> -B/home/crossdev/mips/mips-unknown-linux-gnu/bin/ 
>> -B/home/crossdev/mips/mips-unknown-linux-gnu/lib/ -isystem 
>> /home/crossdev/mips/mips-unknown-linux-gnu/include -isystem 
>> /home/crossdev/mips/mips-unknown-linux-gnu/sys-include -O2  -DIN_GCC 
>> -DCROSS_COMPILE   -W -Wall -Wwrite-strings -Wstrict-prototypes 
>> -Wmissing-prototypes -Wold-style-definition  -isystem ./include  
>> -fPIC -DHAVE_SYSLOG -g  -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED  
>> -D_LIBC_PROVIDES_SSP_ -I. -I. -I../../gcc -I../../gcc/. 
>> -I../../gcc/../include   -DL__gcc_bcmp -c ../../gcc/libgcc2.c -o 
>> libgcc/./__gcc_bcmp.o
>> ../../gcc/unwind-dw2.c: In function `uw_frame_state_for':
>> ../../gcc/unwind-dw2.c:1027: error: structure has no member named 
>> `sc_regs'
>> ../../gcc/unwind-dw2.c:1027: error: structure has no member named 
>> `sc_pc'
>> make[2]: *** [libgcc/./unwind-dw2.o] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>> make[2]: Leaving directory 
>> `/var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc'
>> make[1]: *** [libgcc.a] Error 2
>> make[1]: Leaving directory 
>> `/var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc'
>> make: *** [all-gcc] Error 2
>>
>> How did you build the tool chain?
>> What kernel headers did you use?
>> If I use kernel headers 2.6.8.1 (I realy need 2.6 heraders!)  the 
>> installation of the headers fails!
>>
>> It would be great If you can tell me which paramerter I have to use 
>> with crossdev to get a working tool chain.
>>
>> Best regards
>> TheNop
>
>
> Well, this really is more of a question for the gentoo-mips mailing 
> list.  But anyway, 2.4 headers newer than our 2.4.22-r1 ebuild are 
> broken (I can't remember exactly how at the moment), and we *really* 
> don't support 2.6 headers at all.  In fact, building against them 
> breaks glibc on o32 userland.  The only reason we have them in portage 
> at all right now is for our n32 userland (which is broken in other 
> ways because of the headers).  Eventually we'll have a sanitized 2.6 
> headers package that should work, but it may not be anytime soon.
>
> Anyway to answer your question, I used crossdev to build a bootstrap C 
> compiler (crossdev -k), then I did the rest by hand.  You might also 
> need to get kumba's latest version of the crossdev script from 
> gentoo's viewcvs under gentoo/users/kumba/crossdev/ just to get past 
> the first part.
>
> Why do you *need* 2.6 headers anyhow?  You can still run a 2.6 kernel 
> with a userland compiled with 2.4 headers.
>
> Steve
>
>
Hi Steve,

I thought that I have to use 2.6 headers if I want to run a 2.6 kernel. 
If not, I'm happy with a working tool chain compiled with 2.4 headers :-).

Best regards
TheNop
