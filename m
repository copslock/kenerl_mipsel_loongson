Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6K2YYT07661
	for linux-mips-outgoing; Thu, 19 Jul 2001 19:34:34 -0700
Received: from cool.coventive.com (cool.coventive.com [211.79.9.188])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6K2YWV07654
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 19:34:32 -0700
Received: from jefflee (jungle.coventive.com [211.79.9.189])
	by cool.coventive.com (8.10.2/8.10.2) with SMTP id f6K2XqR15865;
	Fri, 20 Jul 2001 10:33:56 +0800
Message-ID: <008101c110c4$de161c70$9400a8c0@jefflee>
From: "jeff_lee" <jeff_lee@coventive.com>
To: <ppopov@pacbell.net>, <linux-mips-kernel@lists.sourceforge.net>,
   <linux-mips@oss.sgi.com>
References: <3B572EFC.9090903@pacbell.net>
Subject: Re: hard hat linux 2.0
Date: Fri, 20 Jul 2001 10:37:02 +0800
Organization: hardware
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi ,
    How can I ftp the site ??
Do I need the user name or passward ?? 
Or how is the port number ??

Thanks !!!
----- Original Message ----- 
From: "Pete Popov" <ppopov@pacbell.net>
To: <linux-mips-kernel@lists.sourceforge.net>; <linux-mips@oss.sgi.com>
Sent: Friday, July 20, 2001 3:03 AM
Subject: hard hat linux 2.0


> Looks like ftp.mvista.com was updated last night to include the mips 
> journeyman edition. The images of interest would be 
> ftp.mvista.com:/pub/Journeyman/cdimages/{je-d1-hhl2.0.cdimage, 
> je-src-hhl2.0.cdimage}.  They are rather large so it takes a while to 
> download them.
> 
> In addition to the userland packages, there is an up to date cross 
> toolchain which can build the kernel as well as useland apps. There is 
> also a native toolchain.  The toolchain is 2.95.3 based; glibc is 2.2.3. 
>   Since there was some perl interest recently, perl is included. 
> Rebuilding any of the userland packages, for those interested in doing 
> that, is pretty trivial (cross based building!).
> 
> This is an embedded linux distribution so it's not as large as a RedHat 
> desktop system. For embedded work though, I think it's more than 
> sufficient.  One note, to anyone trying it.  A number of binaries are 
> linked with pthreads, so you'll need either the new sysmips fix that 
> Ralf is working on, when he completes it, or the patch from Florian. 
> Otherwise binaries like ls, tar, and many others will seg fault.
> 
> Pete
