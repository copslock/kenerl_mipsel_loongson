Received:  by oss.sgi.com id <S553704AbQLVHyf>;
	Thu, 21 Dec 2000 23:54:35 -0800
Received: from [210.241.238.126] ([210.241.238.126]:46344 "EHLO
        viditec-netmedia.com.tw") by oss.sgi.com with ESMTP
	id <S553669AbQLVHyY>; Thu, 21 Dec 2000 23:54:24 -0800
Received: from kjlin ([210.241.238.122])
	by viditec-netmedia.com.tw (8.9.3/8.8.7) with SMTP id QAA02694;
	Fri, 22 Dec 2000 16:01:23 +0800
Message-ID: <062f01c06be1$d1ca8ce0$056aaac0@kjlin>
From:   "kjlin" <kj.lin@viditec-netmedia.com.tw>
To:     "Keith M Wesolowski" <wesolows@chem.unr.edu>
Cc:     <linux-mips@oss.sgi.com>
References: <053601c06a6c$ee66ca60$056aaac0@kjlin> <20001220183938.A20077@chem.unr.edu>
Subject: Re: Run the cross-compiled program.
Date:   Fri, 22 Dec 2000 14:38:38 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


----- Original Message -----
> I guess I don't quite understand why you would want to use kernel 2.2
> with glibc 2.2.  For embedded purposes, glibc 2.0 will save you a lot
> of space; if you just want the newest stuff unconditionally, use
> kernel 2.4.  The specific libc you are using is rather dated anyway.
> While it worked for most purposes it is hardly bug-free.  Consider
> using CVS glibc, or the glibc from Florian's Debian build environment.
>
> --
The original system of my embedded mips board is the kernel 2.2 with the
libc-2.0.4.
But the libc-2.0.4 seems not to support POSIX 1003.1c, which cause my
program to fail.
That's the reasion why i want to upgrade the library.
In fact, i prefer to upgrade to libc-2.0.6, but i am not sure whether it
supports POSIX 1003.1c.
On the other hand, i can not find the cross-usable libc-2.0.6 source and
patches or binary tarball for my cross-compiler.
Any suggestions ?

Thanks,
KJ
