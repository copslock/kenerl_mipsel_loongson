Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 13:51:22 +0100 (BST)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:60891 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225197AbTDCMvT>;
	Thu, 3 Apr 2003 13:51:19 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h33Cp7Ue013586;
	Thu, 3 Apr 2003 04:51:07 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA26900;
	Thu, 3 Apr 2003 04:51:08 -0800 (PST)
Message-ID: <013101c2f9e0$bc582900$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Mike K." <linux_linux_2003@hotmail.com>,
	<linux-mips@linux-mips.org>
References: <BAY2-F148jSQU0d0uub000985dc@hotmail.com>
Subject: Re: __asm__  C code in mips-Linux
Date: Thu, 3 Apr 2003 14:58:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> extern __inline__ void atomic_add(int i, atomic_t * v)
> {
> unsigned long temp;
> 
> __asm__ __volatile__(
> "1:   ll      %0, %1      # atomic_add\n"
> "     addu    %0, %2                  \n"
> "     sc      %0, %1                  \n"
> "     beqz    %0, 1b                  \n"
> : "=&r" (temp), "=m" (v->counter)
> : "Ir" (i), "m" (v->counter));
> }
> 
> 
> Beginner questions on the above code...

See http://gcc.gnu.org/onlinedocs/gcc-2.95.3/gcc_4.html#SEC93
or any of a number of other on-line copies of the gcc documentation.
Gcc has a very powerful and cool means of binding C variables to
assembly-language operands.  The syntax can be painful, but you
can do amazing things with it - in this case, an in-line atomic add
for C.
