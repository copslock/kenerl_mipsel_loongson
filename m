Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f736BaJ27981
	for linux-mips-outgoing; Thu, 2 Aug 2001 23:11:36 -0700
Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f736BaV27978
	for <linux-mips@oss.sgi.com>; Thu, 2 Aug 2001 23:11:36 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via SMTP id XAA03764
	for <linux-mips@oss.sgi.com>; Thu, 2 Aug 2001 23:09:24 -0700 (PDT)
	mail_from (kaos@ocs.com.au)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id QAA14871; Fri, 3 Aug 2001 16:10:06 +1000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@oss.sgi.com
Subject: Re: ksymoops changes for mips 
In-reply-to: Your message of "Thu, 28 Jun 2001 16:32:51 +0200."
             <20010628163250.D28583@rembrandt.csv.ica.uni-stuttgart.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Aug 2001 16:10:06 +1000
Message-ID: <17478.996819006@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Resend, no response.

On Thu, 28 Jun 2001 16:32:51 +0200, 
Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> wrote:
>Keith Owens wrote:
>[snip]
>> >The best option is for a mips64 kernel to indicate that it is 64 bit
>> >and its endianess.  Instead of printing
>
>The appended patch introduces the new format in mips64. Maybe this speeds
>up agreement about it. :-)

I am updating ksymoops now and need some information.  Could somebody
tell me what this produces on mips?

# objdump -x ksymoops | head -8
# objdump -x mips64-lsb-vmlinux | head -8
# objdump -x mips64-msb-vmlinux | head -8

where mips64-[lm]sb-vmlinux are kernels compiled for 64 bit with LSB
and MSB.
