Received:  by oss.sgi.com id <S553790AbQJPSgN>;
	Mon, 16 Oct 2000 11:36:13 -0700
Received: from mx.mips.com ([206.31.31.226]:6835 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553765AbQJPSgD>;
	Mon, 16 Oct 2000 11:36:03 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id LAA02001;
	Mon, 16 Oct 2000 11:35:43 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id LAA07397;
	Mon, 16 Oct 2000 11:35:47 -0700 (PDT)
Message-ID: <009601c037a0$5f324940$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Pete Popov" <ppopov@mvista.com>, <linux-mips@oss.sgi.com>
References: <39EB41B0.101F0123@mvista.com>
Subject: Re: IDT 32334 processor
Date:   Mon, 16 Oct 2000 20:38:44 +0200
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

No, but from the specs I've seen for the part, it should run a
"MIPS32" kernel with little or no modification.  That's the port
that we did at MIPS for the 4KC.  You can download the kernel
sources from MIPS at ftp://ftp.mips.com/pub/linux/mips.   Some
of the work has been merged into the 2.2 stream at SGI, but not
all of it.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Pete Popov" <ppopov@mvista.com>
To: <linux-mips@oss.sgi.com>
Sent: Monday, October 16, 2000 7:58 PM
Subject: IDT 32334 processor


> 
> Has anyone done (or heard of) any work with linux and the IDT 32334 mips
> processor?
> 
> Pete
