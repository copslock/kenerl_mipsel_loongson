Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 04:31:10 +0000 (GMT)
Received: from webmail29.rediffmail.com ([IPv6:::ffff:203.199.83.39]:60383
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8225194AbTA1EbJ>; Tue, 28 Jan 2003 04:31:09 +0000
Received: (qmail 13487 invoked by uid 510); 28 Jan 2003 04:38:05 -0000
Date: 28 Jan 2003 04:38:05 -0000
Message-ID: <20030128043805.13486.qmail@webmail29.rediffmail.com>
Received: from unknown (194.175.117.86) by rediffmail.com via HTTP; 28 jan 2003 04:38:05 -0000
MIME-Version: 1.0
From: "santosh kumar gowda" <ipv6_san@rediffmail.com>
Reply-To: "santosh kumar gowda" <ipv6_san@rediffmail.com>
To: cwu@deltartp.com
Cc: linux-mips@linux-mips.org
Subject: Re: mips cross-compiler
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <ipv6_san@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ipv6_san@rediffmail.com
Precedence: bulk
X-list: linux-mips

Upgrade your glibc to a recent version.
And installing the binutils-mips-linux-2.8.1-1
to a specific path, may result in problems.
I would suggest to compile at the given default
location and then move the executables to
/usr/bin. U will be able to access them everywhere.
Give it a try.

-Santosh
-----------------------------------
On Tue, 28 Jan 2003 Chien-Lung Wu wrote :
>Hi,
>I am trying to install a mips-linux cross compiler on my linux 
>box with
> 	target=mips-linux
> 	host=i686-linux
>
>  I download the rpm files
> 	binutils-mips-linux-2.8.1-1-i386.rpm
> 	egcs-mips-linux-1.0.3a-2.i386.rpm
> 	glibc-2.1.95.1.mips.rpm
> from ftp://oss.sgi.com/pub/linux/mips
>
>When I use rpm comand to install binutils and egcs, they work 
>fine.
> 	rpm -i binutils-mips-linux-2.8.1-1-i386.rpm
> 	rpm -i egcs-mips-linux-1.0.3a-2.i386.rpm
>
>However, as I intsall the glibc with the rpm command:
> 	rpm -i glibc-2.1.95.1.mips.rpm
>
>I got a confliction with glibc-common-2.2.4-13, since my native 
>glibc is
>2.2.4-13. Thus I cannot install glibc.
>
>Can anybody show me how to install the cross-compiler correctly? 
>(what is
>the correct rpm command?)
>
>More questions:
>If I have native glibc, can I install another glibc for 
>cross-compiler?
>Can I install the binutils-mips-linux-2.8.1-1 to a specific path?  
>How?
>( when I install them with rpm -i command, the executable files 
>will go to
>/usr/bin as default. Can I change that?)
>
>Thanks for your help.
>
>Chien-Lung
>
