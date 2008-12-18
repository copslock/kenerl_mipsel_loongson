Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2008 17:34:37 +0000 (GMT)
Received: from wf-out-1314.google.com ([209.85.200.168]:58905 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S24119814AbYLRRef (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Dec 2008 17:34:35 +0000
Received: by wf-out-1314.google.com with SMTP id 27so570625wfd.21
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2008 09:34:32 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=IkRHpWIEm9l65gQnazycu8hTx3F8tFawEzxxgj+lUVM=;
        b=wdapogg50mvNWEUo31k2rcgD4gSzVpkgQknEIaFPVlIJnVvR1s1KDx7txTTvir+tCU
         E5/j42HEl4uv8t8LQ/YjLr9Owv4fQe7lDjraa66qyIsxRLg7hUVJt+A7sVDY+CQae4Eg
         FIqxiwIWHsQ/oFNYpbtWg8eJma2xNDZgWCLKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=Xe/lFAI0vQNdIPhKJvgjG45OYg9RgdSBv8iRWcpho7yvfy4JnKGa5L/16mSM6KLm+3
         GLaZFLaVODCOQ6X1DKPxT8neHDH6b1EwazU5oZARCPWBk1OmP5ehEnBO1gWpdGsBBioq
         +p62R5P9Sw501nFjkTqvjJOStpbHQTVkcIGug=
Received: by 10.143.30.10 with SMTP id h10mr900172wfj.179.1229621672703;
        Thu, 18 Dec 2008 09:34:32 -0800 (PST)
Received: by 10.143.35.18 with HTTP; Thu, 18 Dec 2008 09:34:32 -0800 (PST)
Message-ID: <f2e0c4580812180934v33a9c19fg19ecdaca1e5394bd@mail.gmail.com>
Date:	Thu, 18 Dec 2008 23:04:32 +0530
From:	Viswanath <rviswanathreddy@gmail.com>
To:	"David Daney" <ddaney@caviumnetworks.com>
Subject: Re: Gprofiling Missing gcrt1.o Object file
Cc:	linux-mips@linux-mips.org
In-Reply-To: <494A8141.2050006@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_38428_25902250.1229621672704"
References: <f2e0c4580812180606h4699be41x1128c97086ebb902@mail.gmail.com>
	 <494A8141.2050006@caviumnetworks.com>
Return-Path: <rviswanathreddy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rviswanathreddy@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_38428_25902250.1229621672704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

am planning to cross compile gcrt1.c (source files )with mips-linux-gcc.
Will let you know the output.

Thanks
--viswanath reddy

On Thu, Dec 18, 2008 at 10:28 PM, David Daney <ddaney@caviumnetworks.com>wrote:

> Viswanath wrote:
>
>> Hi,
>>          I am trying to profile (gprof profiling) my application which is
>> cross-compiled for the target Mips system [*Linux Mips 2.6.8.1]* and UCLIBC
>> *uclibc-crosstools_gcc-3.4.2_uclibc-20050502. *As far as i searched in the
>> google i could see a requirement of gcrt1.o object file for the mips linux
>> which is not available on the mips-linux.
>>
>>          I tried linking with crt1.o but i could not get accurate
>> profiling information. I came to know that gcrt1.o is required to get the
>> accurate information. Where can i get the so called gcrt1.o for Mips-linux.
>>
>>
> gcrt1.o should be part of the C library (uClibc in your case).  If it is
>  not providing it, it is a bug in uClibc.
>
> Actually I don't even know it uClibc supplies a gcrt1.o.  Our build doesn't
> seem to have one.  If you build a glibc based system, that would give you a
> working gcrt1.o
>
> David Daney
>

------=_Part_38428_25902250.1229621672704
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

am planning to cross compile gcrt1.c (source files )with mips-linux-gcc. Will let you know the output. <br><br>Thanks<br>--viswanath reddy<br><br><div class="gmail_quote">On Thu, Dec 18, 2008 at 10:28 PM, David Daney <span dir="ltr">&lt;<a href="mailto:ddaney@caviumnetworks.com">ddaney@caviumnetworks.com</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c">Viswanath wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;I am trying to profile (gprof profiling) my application which is cross-compiled for the target Mips system [*Linux Mips 2.6.8.1]* and UCLIBC *uclibc-crosstools_gcc-3.4.2_uclibc-20050502. *As far as i searched in the google i could see a requirement of gcrt1.o object file for the mips linux which is not available on the mips-linux.<br>

<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;I tried linking with crt1.o but i could not get accurate profiling information. I came to know that gcrt1.o is required to get the accurate information. Where can i get the so called gcrt1.o for Mips-linux.<br>

<br>
</blockquote>
<br></div></div>
gcrt1.o should be part of the C library (uClibc in your case). &nbsp;If it is &nbsp;not providing it, it is a bug in uClibc.<br>
<br>
Actually I don&#39;t even know it uClibc supplies a gcrt1.o. &nbsp;Our build doesn&#39;t seem to have one. &nbsp;If you build a glibc based system, that would give you a working gcrt1.o<br><font color="#888888">
<br>
David Daney<br>
</font></blockquote></div><br>

------=_Part_38428_25902250.1229621672704--
