Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7FL2LT01113
	for linux-mips-outgoing; Wed, 15 Aug 2001 14:02:21 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7FL25j01060
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 14:02:19 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7FL63A29810;
	Wed, 15 Aug 2001 14:06:43 -0700
Message-ID: <3B7AE3FE.1070103@pacbell.net>
Date: Wed, 15 Aug 2001 14:05:02 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Steven Liu <stevenliu@psdc.com>
CC: linux-mips@oss.sgi.com
Subject: Re: glibc
References: <84CE342693F11946B9F54B18C1AB837B0A248C@ex2k.pcs.psdc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Steven Liu wrote:
> Hi, ALL:
> 
> I am porting Linux version 2.2.12 to Mips R3000 and need to build glibc
> but I could not find the following files:
> 
> 	glibc-2.0.6.tar.gz
>             glibc-crypt-2.0.6.tar.gz
>             glibc-localedata-2.0.6.tar.gz
>  	glibc-linuxthreads-2.0.6.tar.gz
> 	glibc-2.0.6-mips.patch
> 
> If anyone know the place I caould get the files and let me know, I would
> be greatly appreciated.

Why are you porting 2.2.12? 2.4 is much more easy to port and there's already 
pretty good support for a number of different boards. The tools and glibc 
(2.2.3) are ready and available from a few places. And, you are much more likely 
to get help from someone with the 2.4 kernel, since that's what everyone seems 
to be using. As soon as your 2.2.12 port is done, it will be dead. Who are you 
going to submit it to? Just my 2c anyway.


Pete
