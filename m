Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2008 17:07:23 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:28284 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207341AbYLRRHU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Dec 2008 17:07:20 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494a83410000>; Thu, 18 Dec 2008 12:07:13 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Dec 2008 08:58:41 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Dec 2008 08:58:41 -0800
Message-ID: <494A8141.2050006@caviumnetworks.com>
Date:	Thu, 18 Dec 2008 08:58:41 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	Viswanath <rviswanathreddy@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Gprofiling Missing gcrt1.o Object file
References: <f2e0c4580812180606h4699be41x1128c97086ebb902@mail.gmail.com>
In-Reply-To: <f2e0c4580812180606h4699be41x1128c97086ebb902@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2008 16:58:41.0465 (UTC) FILETIME=[E11A2A90:01C96131]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Viswanath wrote:
> Hi,
>           I am trying to profile (gprof profiling) my application which 
> is cross-compiled for the target Mips system [*Linux Mips 2.6.8.1]* and 
> UCLIBC *uclibc-crosstools_gcc-3.4.2_uclibc-20050502. *As far as i 
> searched in the google i could see a requirement of gcrt1.o object file 
> for the mips linux which is not available on the mips-linux.
> 
>           I tried linking with crt1.o but i could not get accurate 
> profiling information. I came to know that gcrt1.o is required to get 
> the accurate information. Where can i get the so called gcrt1.o for 
> Mips-linux.
> 

gcrt1.o should be part of the C library (uClibc in your case).  If it is 
  not providing it, it is a bug in uClibc.

Actually I don't even know it uClibc supplies a gcrt1.o.  Our build 
doesn't seem to have one.  If you build a glibc based system, that would 
give you a working gcrt1.o

David Daney
