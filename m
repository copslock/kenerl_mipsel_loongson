Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UKLwnC001830
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 13:21:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UKLwIg001829
	for linux-mips-outgoing; Thu, 30 May 2002 13:21:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pop3.inreach.com (pop3.inreach.com [209.142.2.35])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UKLsnC001826
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 13:21:54 -0700
Received: (qmail 28417 invoked from network); 30 May 2002 20:23:22 -0000
Received: from unknown (HELO w2k30g) (209.142.39.228)
  by pop3.inreach.com with SMTP; 30 May 2002 20:23:22 -0000
Message-ID: <007401c20817$f2277f60$0b01a8c0@w2k30g>
From: "David Christensen" <dpchrist@holgerdanske.com>
To: <linux-mips@oss.sgi.com>
Cc: "Hartvig Ekner" <hartvige@mips.com>
References: <200205301936.g4UJaBG04915@coplin09.mips.com>
Subject: Re: cross-compiler for MIPS_RedHat7.1_Release-01.00 on Atlas/4Kc using RH7.3-i386 host
Date: Thu, 30 May 2002 13:06:43 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

linux-mips@oss.sgi.com & Hartvig:

Hartvig Ekner wrote:
> Note that you can install the Release-02.00 (with all the latest RPMs
> from H.J.) as well on an Atlas, you'll just have to use the 2.4.3
> install kernel from the 01.00 CD image you downloaded, and everything
> else from the new release.

I'll keep that in mind for my next install.


> For kernel cross compilation we use the following binary RPM's (LE
> shown only):
>
>        binutils-mipsel-linux-2.9.5-3
>        egcs-mipsel-linux-1.1.2-4

I'll try what I've already installed and see what happens.  If it fails,
I'll upgrade binutils and try again.


Thank you for your help.  :-)


David
