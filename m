Received:  by oss.sgi.com id <S553801AbRBWFlD>;
	Thu, 22 Feb 2001 21:41:03 -0800
Received: from [208.170.106.25] ([208.170.106.25]:9744 "EHLO
        blackdog.wirespeed.com") by oss.sgi.com with ESMTP
	id <S553739AbRBWFkm>; Thu, 22 Feb 2001 21:40:42 -0800
Received: from redhat.com (IDENT:joe@dhcp-242.hsv.redhat.com [172.16.17.242] (may be forged))
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id XAA12094;
	Thu, 22 Feb 2001 23:33:39 -0600
Message-ID: <3A95F83D.9030600@redhat.com>
Date:   Thu, 22 Feb 2001 23:42:21 -0600
From:   Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; 0.8) Gecko/20010217
X-Accept-Language: en
MIME-Version: 1.0
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC:     Crossfire <xfire@xware.cx>, kjlin <kj.lin@viditec-netmedia.com.tw>,
        linux-mips@oss.sgi.com
Subject: Re: Does linux support for microprocessor without MMU?
References: <Pine.GSO.4.10.10102220752430.13615-100000@escobaria.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Geert Uytterhoeven wrote:

> On Wed, 21 Feb 2001, Joe deBlaquiere wrote:
> 
>> 
>> There isn't (yet) support for MIPS on uClinux.
> 
> 
> But it can't be that hard to add support for it...
> 
Porting the kernel isn't much worse than any other architectural port. 
Of course that's only a part of the story, since you'll need to port the 
C library (uClibc/uC-glibc) and you will have to play around with the 
object file format to make it work with FLAT binaries... If you're 
serious about doing uClinux you can find a somewhat cryptic article on 
porting to uClinux at:

http://www.redhat.com/embedded/technologies/resources

-- 
Joe
