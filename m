Received:  by oss.sgi.com id <S553706AbRAZT2G>;
	Fri, 26 Jan 2001 11:28:06 -0800
Received: from saturn.mikemac.com ([216.99.199.88]:64775 "EHLO
        saturn.mikemac.com") by oss.sgi.com with ESMTP id <S553653AbRAZT1u>;
	Fri, 26 Jan 2001 11:27:50 -0800
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id LAA09872;
	Fri, 26 Jan 2001 11:27:48 -0800
Message-Id: <200101261927.LAA09872@saturn.mikemac.com>
To:     Pete Popov <ppopov@mvista.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs 
In-Reply-To: Your message of "Fri, 26 Jan 2001 10:37:03 PST."
             <3A71C3CF.A179113@mvista.com> 
Date:   Fri, 26 Jan 2001 11:27:48 -0800
From:   Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


>Date: Fri, 26 Jan 2001 10:37:03 -0800
>From: Pete Popov <ppopov@mvista.com>
>To: Mike McDonald <mikemac@mikemac.com>
>Subject: Re: Cross compiling RPMs

>To start with, you'll need a cross tool chain setup properly with the
>headers and libraries.  One option is
>ftp.mvista.com:/pub/Area51/mips_fp_le. You can grab everything (the
>entire root fs) or just the tools: binutils, gcc, kernel headers,
>glibc.  Others might have similar toolchains they can point you at. 
>Another option is native builds, which I personally don't like.
>
>Pete

  I have a working tool chain that I use to cross compile a kernel
with sources from. How do I convince rpm to use that chain?

  Mike McDonald
  mikemac@mikemac.com
