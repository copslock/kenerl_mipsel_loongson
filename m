Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f831vro13629
	for linux-mips-outgoing; Sun, 2 Sep 2001 18:57:53 -0700
Received: from viditec-netmedia.com.tw (61-220-240-70.HINET-IP.hinet.net [61.220.240.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f831vod13626
	for <linux-mips@oss.sgi.com>; Sun, 2 Sep 2001 18:57:50 -0700
Received: from kjlin ([61.220.240.66])
	by viditec-netmedia.com.tw (8.10.0/8.10.0) with SMTP id f834OnW11270
	for <linux-mips@oss.sgi.com>; Mon, 3 Sep 2001 12:24:49 +0800
Message-ID: <02e701c13418$7f51a0c0$056aaac0@kjlin>
From: "kjlin" <kj.lin@viditec-netmedia.com.tw>
To: <linux-mips@oss.sgi.com>
References: <02b801c13203$f52ad440$056aaac0@kjlin> <999283122.29395.45.camel@ez>
Subject: Re: compile C++ code
Date: Mon, 3 Sep 2001 09:33:56 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > #mips-linux-gcc test.C
> > /usr/lib/gcc-lib/mips-linux/egcs-2.91.66/libgcc.a(frame.o): In function
`decode_uleb128':
> >
/usr/src/redhat/BUILD/egcs-1.1.2/target-mips-linux/gcc/../../gcc/frame.c(.da
ta+0x0): undefined reference to `pthread_create'
> > /usr/mips-linux/bin/ld: bfd assertion fail ../../bfd/elf32-mips.c:5123
> > mips-linux-gcc: Internal compiler error: program ld got fatal signal 11
> > #mips-linux-g++ test.C
> > /usr/mips-linux/lib/libstdc++.so: undefined reference to
`pthread_create'
> > /usr/mips-linux/lib/libstdc++.so: undefined reference to
`pthread_getspecific'
> > /usr/mips-linux/lib/libstdc++.so: undefined reference to `pthread_once'
> > /usr/mips-linux/lib/libstdc++.so: undefined reference to
`pthread_key_create'
> > /usr/mips-linux/lib/libstdc++.so: undefined reference to
`pthread_setspecific'
> >
> It seems you should link with pthread lib :
> #mips-linux-g++ test.C -lpthread
>
> I think the libgcc.a should be linked with it ... Can anyone tell us
> further on that subject?

Yes, if i link with "-lpthread" , the error is solved.
But i am confused that when i compile the same code with native gcc/g++, it
is needless to link with that option.
Why?
