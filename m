Received:  by oss.sgi.com id <S553909AbQLTPFL>;
	Wed, 20 Dec 2000 07:05:11 -0800
Received: from router.isratech.ro ([193.226.114.69]:58891 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553905AbQLTPFJ>;
	Wed, 20 Dec 2000 07:05:09 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eBKF41p28098;
	Wed, 20 Dec 2000 17:04:01 +0200
Message-ID: <3A4138BF.871CB6C@isratech.ro>
Date:   Wed, 20 Dec 2000 17:54:55 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     kjlin <kj.lin@viditec-netmedia.com.tw>, linux-mips@oss.sgi.com
Subject: Re: Run the cross-compiled program.
References: <053601c06a6c$ee66ca60$056aaac0@kjlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am very interested in getting the latest sources for binutils, gcc and
glibc working in cross toolchain for mips. PLease tell me from where did
you took the gcc that you use . Please give me as muche details as you
can.

Regards,
Nicu


kjlin wrote:

> Can anyone point out which step i done wrong in the process of
> cross-compiling an program with the -static option?
> I made the cross-compile toolkit by myself.
> All the source code and patches for cross-compile were downloaded from
> the SGI ftp site.
> The version is as following:
> cross-binutils = version 2.10.90
> cross-gcc = version 2.96 20000707
> cross-usable glibc = libc-2.1.90
> The cross-compile toolkits building process is ok!
> I used the cross-compiler to compile a program with the " -static "
> option in the host and then ran it on the target.
> But i got the error message:# ./a.outFATAL: kernel too old
> Aborted Where i be trapped?
> My host system is x86 running linux-2.2.14(Redhat 6.2).
> My target system is an embedded mips board running linux-2.2.14 and
> shell is the statically linked ash binary from a lib-2.6.0
> filesystem(kernel version unknown).
> By the way, i builded the cross-usable glibc-2.1.90 with configure
> "--enable-kernel=2.2.14".Thanx,KJ from kj.lin@viditec-netmedia.com.tw
