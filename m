Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6G3KmRw018389
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 20:20:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6G3KmUK018388
	for linux-mips-outgoing; Mon, 15 Jul 2002 20:20:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from freemail.com.au (sysofm01.freemail.com.au [210.11.38.241])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6G3KZRw018379
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 20:20:36 -0700
Date: Mon, 15 Jul 2002 20:20:35 -0700
Message-Id: <200207160320.g6G3KZRw018379@oss.sgi.com>
Content-type: multipart/mixed; boundary="----------APMIME1"
Subject: Re: mips32 cross compiler on X86 linux
From: Guo-Rong Koh <grk@freemail.com.au>
To: linux-mips@oss.sgi.com
X-FreemailID: 14281835
MIME-Version: 1.0
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multipart message in MIME format.
------------APMIME1
Content-type: text/plain

Try this:

http://www.ltc.com/~brad/mips/mips-cross-toolchain/

Guo-Rong

At Mon, 15 Jul 2002 19:32:52 -0700 (PDT), 
Long Li (long21st@yahoo.com) wrote:
> Hi, 
> 
> I am a newbie to the cross compiler. I read some
> documents online and started to build a gcc cross
> compiler for MIPS4Kc(32-bit isa) on X86 linux. Here is
> what I did:
> 
> 1. I built binutils-2.11.2 with the following
> configurations:
> 
> configure --prefix=/home/lli/my-bin
> --target=mips32-linux --with-cpu=mips32-4kc
> 
> 2. The binutils was built successfully. Then I built
> the gcc-3.0.4
> with the configurations:
> 
>   --prefix=/home/lli/my-bin --target=mips32-linux
> --with-cpu=mips32-4kc
>   --with-gnu-as --with-gnu-ld 
>   --enable-languages="c c++"
> 
> I got the error messages:
>  
>   /home/lli/my-bin/mips32-linux/bin/ld:
> /home/lli/my-bin/mips32-linux/lib/crti.o: Relocations
> in generic ELF (EM: 3)
> /home/lli/my-bin/mips32-linux/lib/crti.o: could not
> read symbols: File in
> wrong format
> collect2: ld returned 1 exit status
> make[2]: *** [libgcc_s.so] Error 1
> make[2]: Leaving directory `/home/lli/objdir/gcc'
> make[1]: *** [libgcc.a] Error 2
> make[1]: Leaving directory `/home/lli/objdir/gcc'
> make: *** [all-gcc] Error 2
> 
> 
> Is my configuration correct to build a MIPS32-4kc
> cross compiler on Linux? If not, how should I do?
> Could you give me some help?
> 
> Thank you very much. I really appreciate it.
> 
> 
> Best,
> 
> 
> Long Li
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Autos - Get free new car price quotes
> http://autos.yahoo.com



--------------------------------------------------------

Looking for a free email account?
Get one now at http://www.freemail.com.au/

--------------------------------------------------------
------------APMIME1--
