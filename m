Received:  by oss.sgi.com id <S553712AbRAZSg5>;
	Fri, 26 Jan 2001 10:36:57 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:34542 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553660AbRAZSgr>;
	Fri, 26 Jan 2001 10:36:47 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0QIXXI21211;
	Fri, 26 Jan 2001 10:33:33 -0800
Message-ID: <3A71C3CF.A179113@mvista.com>
Date:   Fri, 26 Jan 2001 10:37:03 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Mike McDonald <mikemac@mikemac.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
References: <200101261815.KAA08917@saturn.mikemac.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Mike McDonald wrote:
> 
>   Can anyone point me to some references of techniques for cross
> compiling RPMs? I want to build some packages for my little endian
> MIPS but I haven't found any info on cross compiling RPMs in the RPM
> docs nor "Maximum RPM". Any pointers would be appreciated. (I'm
> particularly interested in how to specify the tool chain.)

To start with, you'll need a cross tool chain setup properly with the
headers and libraries.  One option is
ftp.mvista.com:/pub/Area51/mips_fp_le. You can grab everything (the
entire root fs) or just the tools: binutils, gcc, kernel headers,
glibc.  Others might have similar toolchains they can point you at. 
Another option is native builds, which I personally don't like.

Pete
