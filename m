Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f836Lit17231
	for linux-mips-outgoing; Sun, 2 Sep 2001 23:21:44 -0700
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f836Lfd17228
	for <linux-mips@oss.sgi.com>; Sun, 2 Sep 2001 23:21:41 -0700
Received: from murphy.dk (brian [10.0.0.2])
        by ubik.localnet (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f836LXr6024505
        for <linux-mips@oss.sgi.com>; Mon, 3 Sep 2001 08:21:33 +0200
Message-ID: <3B932159.AA9C2C71@murphy.dk>
Date: Mon, 03 Sep 2001 08:21:13 +0200
From: Brian Murphy <brian@murphy.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-mips@oss.sgi.com
Subject: Re: compile C++ code
References: <02b801c13203$f52ad440$056aaac0@kjlin> <999283122.29395.45.camel@ez> <02e701c13418$7f51a0c0$056aaac0@kjlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

kjlin wrote:

> > > #mips-linux-gcc test.C
> > > /usr/lib/gcc-lib/mips-linux/egcs-2.91.66/libgcc.a(frame.o): In function
> `decode_uleb128':
> > >
> /usr/src/redhat/BUILD/egcs-1.1.2/target-mips-linux/gcc/../../gcc/frame.c(.da
> ta+0x0): undefined reference to `pthread_create'
> > > /usr/mips-linux/bin/ld: bfd assertion fail ../../bfd/elf32-mips.c:5123
> > > mips-linux-gcc: Internal compiler error: program ld got fatal signal 11
> > > #mips-linux-g++ test.C
> > > /usr/mips-linux/lib/libstdc++.so: undefined reference to
> `pthread_create'
> > > /usr/mips-linux/lib/libstdc++.so: undefined reference to
> `pthread_getspecific'
> > > /usr/mips-linux/lib/libstdc++.so: undefined reference to `pthread_once'
> > > /usr/mips-linux/lib/libstdc++.so: undefined reference to
> `pthread_key_create'
> > > /usr/mips-linux/lib/libstdc++.so: undefined reference to
> `pthread_setspecific'
> > >
> > It seems you should link with pthread lib :
> > #mips-linux-g++ test.C -lpthread
> >
> > I think the libgcc.a should be linked with it ... Can anyone tell us
> > further on that subject?
>
> Yes, if i link with "-lpthread" , the error is solved.
> But i am confused that when i compile the same code with native gcc/g++, it
> is needless to link with that option.
> Why?

The problem is that your old toolchain (ld) cannot handle weak symbols.

/Brian
