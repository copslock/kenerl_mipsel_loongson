Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f85ABuB18500
	for linux-mips-outgoing; Wed, 5 Sep 2001 03:11:56 -0700
Received: from viditec-netmedia.com.tw (61-220-240-70.HINET-IP.hinet.net [61.220.240.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f85ABrd18490
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 03:11:53 -0700
Received: from kjlin ([61.220.240.66])
	by viditec-netmedia.com.tw (8.10.0/8.10.0) with SMTP id f85CbaW19729;
	Wed, 5 Sep 2001 20:37:36 +0800
Message-ID: <00c401c135f0$509d6500$056aaac0@kjlin>
From: "kjlin" <kj.lin@viditec-netmedia.com.tw>
To: "Jean-Christophe ARNU" <jc.arnu@wanadoo.fr>
Cc: <linux-mips@oss.sgi.com>
References: <008901c135c6$87b88c60$056aaac0@kjlin> <999696461.4471.15.camel@ez>
Subject: Re: How to install the cross-compiler toolchain?
Date: Wed, 5 Sep 2001 17:51:20 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


----- Original Message -----
Subject: Re: How to install the cross-compiler toolchain?


> On 05 Sep 2001 12:52:13 +0800, kjlin wrote:
> > #rpm -ivh glibc-2.2.3-13.3.i386.rpm
> > error: failed dependencies:
> >                 glibc-common = 2.2.3-13.3 is needed by glibc-2.2.3-13.3
> >                 glibc-devel < 2.2.3 conflicts with glibc-2.2.3-13.3
> > I also tried to install glibc-common-2.2.3-13.3.i386.rpm but still
failed.
> > #rpm -ivh glibc-common-2.2.3-13.3.i386.rpm
> > error: failed dependencies:
> >                 glibc < 2.2.3 conflicts with glibc-common-2.2.3-13.3
> >
> > I am confused by the result.
>
> You should update and not install glibc.
> # rpm -uvh glibc-common-2.2.3-13.3.i386.rpm

It is the same.
Just more error messages.
# rpm -Uvh glibc-common-2.2.3-13.3.i386.rpm
error: failed dependencies:
        glibc < 2.2.3 conflicts with glibc-common-2.2.3-13.3
        glibc-common = 2.2.2-10 is needed by glibc-2.2.2-10

# rpm -Uvh glibc-2.2.3-13.3.i386.rpm
error: failed dependencies:
        glibc-common = 2.2.3-13.3 is needed by glibc-2.2.3-13.3
        glibc-devel < 2.2.3 conflicts with glibc-2.2.3-13.3
        glibc > 2.2.2 conflicts with glibc-common-2.2.2-10
        glibc = 2.2.2 is needed by glibc-devel-2.2.2-10

# rpm -Uvh glibc-devel-2.2.3-13.3.i386.rpm
error: failed dependencies:
        glibc = 2.2.3 is needed by glibc-devel-2.2.3-13.3
