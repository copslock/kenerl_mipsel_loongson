Received:  by oss.sgi.com id <S553734AbQKHJuS>;
	Wed, 8 Nov 2000 01:50:18 -0800
Received: from mx.mips.com ([206.31.31.226]:23518 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553726AbQKHJuB>;
	Wed, 8 Nov 2000 01:50:01 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA20575;
	Wed, 8 Nov 2000 01:49:38 -0800 (PST)
Received: from Ulysses (sfr-tgn-sfp-vty3.as.wcom.net [216.192.35.3])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA13374;
	Wed, 8 Nov 2000 01:49:53 -0800 (PST)
Message-ID: <004101c04969$b744b160$0323c0d8@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Nicu Popovici" <octavp@isratech.ro>, <linux-mips@oss.sgi.com>
References: <3A09753F.DB2457EE@isratech.ro>
Subject: Re: MIPS kernel!
Date:   Wed, 8 Nov 2000 10:53:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> I tried to cross compile the kernel from ftp.embedix.com, meaning that
> I found that this embedix Linux is made to work on any platform . I have
> an Atlas board and a QED processsor (  a mips one ) and I fail in trying
> to cross compile the linux-2.2.13. I get the following errors.
...
[errors snipped] 
...
> Another weird thing . When I received my Atlas board I gqt a CD with the
> kernel sources and binaries. I installed the binaries on the Atlas board
> and it works fine but when I tried to cross compile the kernel I get
> some stupid errors like the one above. I realy do not understand
> anything , does anyone cross compiled a kernele for MIPS processors and
> Atlas boards ? The version is linux 2.2.12.( the Hard Hat Linux ).

In general, at MIPS, we generally build native or semi-native
(mipsel on mipseb machines and vice versa).  In cross-builds
of other components, however, I have observed that problems
such as those you describe can result from include files
on the host platform being erroneously pulled in to the cross-build.
Cross-gcc and the makefiles have been known to be set up such
that, if the needed include file can be found neither in the explicitly
requested directories nor in the cross-compiler's default includes, 
it will silently search the host /usr/include directories.

One quick-and-dirty way to test this would be to temporarily rename
/usr/include on your host platform to /usr/include.native or whatever,
and then make your  /usr/include a symbolic link to the include 
directory of your MIPS Linux tree.  This should either let you build
correctly or give you a more useful error message telling you which
include file is missing from your cross-environment or MIPS kernel 
distribution. Just don't forget to put things back the way they were! 

            Regards,

            Kevin K.
