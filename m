Received:  by oss.sgi.com id <S553712AbQJSRJf>;
	Thu, 19 Oct 2000 10:09:35 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:30506 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553696AbQJSRJY>;
	Thu, 19 Oct 2000 10:09:24 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id KAA00232
	for <linux-mips@oss.sgi.com>; Thu, 19 Oct 2000 10:01:33 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA27985; Thu, 19 Oct 2000 14:08:29 -0300
Date:   Thu, 19 Oct 2000 14:08:29 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Guido Guenther <guido.guenther@gmx.net>
cc:     Dave Garnier <dgarnier@openport.com>,
        SGI news group <linux-mips@oss.sgi.com>
Subject: Re: Indigo2 setup
In-Reply-To: <20001019184922.A29608@bilbo.physik.uni-konstanz.de>
Message-ID: <Pine.SGI.4.10.10010191407090.27937-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I knew some people were working on that, but I must have missed the
latest news updates.  Thanks for the info.

--

J. Scott Kasten
Email: jsk AT tetracon-eng DOT net

"In most cases, all an argument proves
 is that two people were present......"

On Thu, 19 Oct 2000, Guido Guenther wrote:

> On Thu, Oct 19, 2000 at 11:48:47AM -0300, J. Scott Kasten wrote:
> > 
> > The issue is slightly more complicated than yes or no.
> > 
> > It is possible to install and run linux on an SGI without any Irix
> > assistance at all.  But you will be stuck netbooting the kernel from a
> > bootp/tftp server and then mounting the local disk after receiving the
> > kernel from another machine over the network.
> Not true anymore. You can partition with a patched fdisk(from Keith) and
> put the kernel into the volume-header with a patched dvhtool(patch posted
> a few days ago on this list) + a small kernel-patch to parse the
> OSLoadPartition prom-variable. See
> 	http://honk.physik.uni-konstanz.de/~agx/mipslinux/dvhtool/
> I could only test this on an Indy since I don't have a hd in my I2. On
> the Indy I put 4 kernels into the volume header and could choose freely
> between them by using the OSLoader-option in the prom.
> Regards,
>  -- Guido
> 
