Received:  by oss.sgi.com id <S554027AbRBWRXI>;
	Fri, 23 Feb 2001 09:23:08 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:55802 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553878AbRBWRW5>;
	Fri, 23 Feb 2001 09:22:57 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f1NHIf805371;
	Fri, 23 Feb 2001 09:18:41 -0800
Message-ID: <3A969BDD.C6A41060@mvista.com>
Date:   Fri, 23 Feb 2001 09:20:29 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Tom Appermont <tea@sonycom.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: ELF header kernel module wrong?
References: <20010223151355.A9091@ginger.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Tom Appermont wrote:
> 
> Greetings,
> 
> I'm trying to get modules to work on my R5000 little endian
> target, linux 2.4.1 + modutils 2.4.2 .
> 
> When I insmod a module, I get error messages like:
> 

Tom,

This is a well-known problem which also exists in the old toolchain.  If you
can search the archive, you can see a string of discussions a few months
back.  (I don't know if we have any mailing archive?)

> 
> I use egcs 1.2.1 + binutils 2.9.5. Is this a problem with my
> binutils?
> 

Essentially it is caused by the different symbols sorting used in binutial and
modutils.  I was trying to fix it but it was beyond my ken.

Jun
