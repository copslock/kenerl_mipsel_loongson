Received:  by oss.sgi.com id <S554263AbRASSib>;
	Fri, 19 Jan 2001 10:38:31 -0800
Received: from stereotomy.lineo.com ([64.50.107.151]:22796 "HELO
        stereotomy.lineo.com") by oss.sgi.com with SMTP id <S554260AbRASSiT>;
	Fri, 19 Jan 2001 10:38:19 -0800
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP id 664A64CB82
	for <linux-mips@oss.sgi.com>; Fri, 19 Jan 2001 11:38:17 -0700 (MST)
Message-ID: <3A688998.1080608@Lineo.COM>
Date:   Fri, 19 Jan 2001 11:38:16 -0700
From:   Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Re: Glibc-error.
References: <3A611CFF.FD28766@isratech.ro> <u8n1cvf90h.fsf@gromit.rhein-neckar.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I'm curious which version of glibc incorporated
support for syscall changes that have occured
with the 2.4.0 kernel.  Or is it all there yet
even with glibc 2.2.1?

Quinn

owner-linux-mips@oss.sgi.com wrote:

>>>>>> Nicu Popovici writes:
>>>>> 
> 
>  > Hello ,
>  > I am struggling to get glibc 2.1.3 working for mips. I have to do this
>  > so please not redirect me to another glibc. I did a diff between glibc
>  > 2.0.6 for mips and glibc 2.1.3 and now I applied the patch obtained on
>  > glibc 2.1.3 . At make I get the following error and I don't know what to
>  > do. Maybe someone will help me.
> 
> You just can't apply the patch from 2.0.6 to 2.1.3 without any changes
> - and you also want to check how I've done it for glibc 2.2.1.  To
> much has changed in between and 2.0.6 might just be a basis for you.
> 
> Andreas
