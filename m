Received:  by oss.sgi.com id <S553927AbQKHTru>;
	Wed, 8 Nov 2000 11:47:50 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:43769 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553715AbQKHTrk>;
	Wed, 8 Nov 2000 11:47:40 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eA8JjP322263;
	Wed, 8 Nov 2000 11:45:25 -0800
Message-ID: <3A09ADDB.EA2A6246@mvista.com>
Date:   Wed, 08 Nov 2000 11:47:39 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: Cross_compiler!
References: <3A09DE18.E55FA70F@isratech.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Nicu Popovici wrote:
> 
> Hello  you all,
> 
> I have a development board ( ATLAS + QED 5261 processor ).
> 
> Does anyone from you did cross compiled a kernel for mips on a i686
> machine ? I am struggling for three weeks now to do that and nothing
> works. Mr. Weselows said  some days ago  to get the Linux_2_2 form CVS
> and indeed I could cross compile that kernel  but after that I found out
> that  the kernel  does not have support for ATLAS board.
> 
> I tried the following kernel versions
> 1. linux.2.2.12 from the Atlas board CD
> 2. linux 2.2.13 from lineo.com
> 3. linux 2.2.14 from oss.sgi.com( linux2_2 from CVS site )
> 4. linux 2.2.17
> 
> Best Regards,
> Nicu

Nicu,

You can get the cross-compile tool chains from the monta vista ftp
site.  These tools are considered stable and recommeded - at least
before Ralf shows his latest toys. :-0

1. binutils 2.8.1
2. egcs 1.0.3a
3. glibc 2.0.6

The ftp site is 

ftp.mvsiat.com:/pub/Area51/ddb-5476/

Hopefully before the end of this weekend, there will a little more
updated release with a new name prefix, some bug fixes and for both
little endiand and big endian.  The current one is for little endian. 
If you know how to use rpm, you can create your own big-endian tools
pretty easily.

Jun
