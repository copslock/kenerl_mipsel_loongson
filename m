Received:  by oss.sgi.com id <S553783AbRBZKWh>;
	Mon, 26 Feb 2001 02:22:37 -0800
Received: from [210.241.238.126] ([210.241.238.126]:60168 "EHLO
        viditec-netmedia.com.tw") by oss.sgi.com with ESMTP
	id <S553775AbRBZKWO>; Mon, 26 Feb 2001 02:22:14 -0800
Received: from kjlin ([210.241.238.122])
	by viditec-netmedia.com.tw (8.9.3/8.8.7) with SMTP id TAA09319;
	Mon, 26 Feb 2001 19:02:36 +0800
Message-ID: <037601c09fd4$e81ef540$056aaac0@kjlin>
From:   "kjlin" <kj.lin@viditec-netmedia.com.tw>
To:     "Joe deBlaquiere" <jadb@redhat.com>
Cc:     <linux-mips@oss.sgi.com>
References: <Pine.GSO.4.10.10102220752430.13615-100000@escobaria.sonytel.be> <3A95F83D.9030600@redhat.com>
Subject: Re: Does linux support for microprocessor without MMU?
Date:   Mon, 26 Feb 2001 17:17:13 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Is the uClibc/uC-glibc platform dependent??
Can we use the "normal linux  glibc" instead of uClibc/uC-glibc when running
uClinux??
As to object file format, is it real necessary to modify the elf2flt
program?
On the other hand, there is an isssue which confuses me.
That is, i had already got a cross-compiler for compiling the "normal linux"
kernel used.
Should i need to remake a cross-compiler to compile the uClinux kernel and
applications?

Thanks.


----- Original Message -----
From: "Joe deBlaquiere" <jadb@redhat.com>
To: "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Cc: "Crossfire" <xfire@xware.cx>; "kjlin" <kj.lin@viditec-netmedia.com.tw>;
<linux-mips@oss.sgi.com>
Sent: Friday, February 23, 2001 1:42 PM
Subject: Re: Does linux support for microprocessor without MMU?


> Geert Uytterhoeven wrote:
>
> > On Wed, 21 Feb 2001, Joe deBlaquiere wrote:
> >
> >>
> >> There isn't (yet) support for MIPS on uClinux.
> >
> >
> > But it can't be that hard to add support for it...
> >
> Porting the kernel isn't much worse than any other architectural port.
> Of course that's only a part of the story, since you'll need to port the
> C library (uClibc/uC-glibc) and you will have to play around with the
> object file format to make it work with FLAT binaries... If you're
> serious about doing uClinux you can find a somewhat cryptic article on
> porting to uClinux at:
>
> http://www.redhat.com/embedded/technologies/resources
>
> --
> Joe
