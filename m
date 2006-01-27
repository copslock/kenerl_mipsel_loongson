Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 08:59:11 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.206]:61859 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3458493AbWA0I6w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 08:58:52 +0000
Received: by zproxy.gmail.com with SMTP id l8so571655nzf
        for <linux-mips@linux-mips.org>; Fri, 27 Jan 2006 01:03:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b2bs/vFdWMXeFXCvP+jU/gi319N3bRGn54Vz69AnPpwyXWccXNEX1voqs7k2ybis6rD81VI6iVbHMhO/koUd/EWsO+xPVyK+pTROtbNQrd+54qTqkeetiYhFqgkvFxMdlInQGqpRWbjMxRKDO8XWwqcvI1SEv8HfzgkR/4haj1M=
Received: by 10.36.115.2 with SMTP id n2mr2265094nzc;
        Fri, 27 Jan 2006 01:03:26 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Fri, 27 Jan 2006 01:03:25 -0800 (PST)
Message-ID: <cda58cb80601270103t1419117cq@mail.gmail.com>
Date:	Fri, 27 Jan 2006 10:03:25 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Nigel Stephens <nigel@mips.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <43D93025.9040800@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <cda58cb80601251003m6ba4379w@mail.gmail.com>
	 <43D7C050.5090607@mips.com>
	 <cda58cb80601260702wf781e70l@mail.gmail.com>
	 <005101c6228c$6ebfb0a0$10eca8c0@grendel> <43D8F000.9010106@mips.com>
	 <cda58cb80601260831i61167787g@mail.gmail.com>
	 <43D8FF16.40107@mips.com>
	 <cda58cb80601261002w6eb02249k@mail.gmail.com>
	 <43D93025.9040800@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/26, Nigel Stephens <nigel@mips.com>:
>
> You could, but why not stick with -march=4ksd if that's your CPU of
> choice? It appears to result in  marginally smaller code even when using
> -Os, and should have (slightly) better performance than a generic
> mips32r2 kernel?
>

Just to avoid a new CPU_4KSD definition in the kernel code as
suggested by Kevin. Basically all mips32r2 specific code is the same
as 4ksd specific code (except the code that deals with SmartMIPS
extension). So it can use CONFIG_CPU_MIPS32_R2 macro. But I was not
aware of -march=4ksd and -march=mips32r2 differences. Maybe now it is
needed to have a new CPU_4KSD definition ?

Thanks
--
               Franck
