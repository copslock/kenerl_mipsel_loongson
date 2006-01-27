Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 14:50:39 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.202]:26611 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133421AbWA0OuW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 14:50:22 +0000
Received: by zproxy.gmail.com with SMTP id l8so626795nzf
        for <linux-mips@linux-mips.org>; Fri, 27 Jan 2006 06:54:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TkXQk6Hfx8C3Gh7YP/jnpv8DzHgcp5CeowSXyV6clUa3eyEVgt5y6PfXK4MZS3ds7zPQjCa9x9ezSb3NRwg/nIm9ACEbEJf/Sdbw8ufl41pgPChXId3Hs4r7j2cwcpLn5edqIQanQrfNWR/rC2uO3BKTYCZ3uRnuB/iUFV/bdWg=
Received: by 10.37.21.36 with SMTP id y36mr2488464nzi;
        Fri, 27 Jan 2006 06:54:58 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Fri, 27 Jan 2006 06:54:58 -0800 (PST)
Message-ID: <cda58cb80601270654jf779622w@mail.gmail.com>
Date:	Fri, 27 Jan 2006 15:54:58 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Nigel Stephens <nigel@mips.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <43DA240F.5070301@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <cda58cb80601260702wf781e70l@mail.gmail.com>
	 <005101c6228c$6ebfb0a0$10eca8c0@grendel> <43D8F000.9010106@mips.com>
	 <cda58cb80601260831i61167787g@mail.gmail.com>
	 <43D8FF16.40107@mips.com>
	 <cda58cb80601261002w6eb02249k@mail.gmail.com>
	 <43D93025.9040800@mips.com>
	 <cda58cb80601270103t1419117cq@mail.gmail.com>
	 <43DA240F.5070301@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/27, Nigel Stephens <nigel@mips.com>:
>
> Not that I'm a Linux hacker, but aren't those separate things? Can't you
> compile with -march=4ksd to get the CPU-specific compiler optimisations,
> but then use the more generic CONFIG_CPU_MIPSR2 and/or
> CONFIG_CPU_SMARTMIPS to select the appropriate code inside the kernel
> source (i.e. no need for CONFIG_CPU_4KSD)?
>

To use -march=4ksd, you need to tell to the building process that
you're using a 4KSD cpu. The only way to do that is to define a new
CPU_4KSD. But, if I understood mips configuration script, you cannot
define CPU_4KSD _and_ CPU_MIPS32R2 at the same time; at least easily.

Thanks
--
               Franck
