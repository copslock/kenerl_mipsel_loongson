Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2006 11:31:10 +0000 (GMT)
Received: from webmail.ict.ac.cn ([159.226.39.7]:15321 "HELO ict.ac.cn")
	by ftp.linux-mips.org with SMTP id S8133790AbWCVLbA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Mar 2006 11:31:00 +0000
Received: (qmail 30512 invoked by uid 507); 22 Mar 2006 10:55:07 -0000
Received: from unknown (HELO ?192.168.2.202?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 22 Mar 2006 10:55:07 -0000
Message-ID: <442137B6.60705@ict.ac.cn>
Date:	Wed, 22 Mar 2006 19:40:38 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Srinivas Kommu <kommu@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: how to get a process backtrace from kernel gdb?
References: <4420940B.9030605@hotmail.com> <20060322105026.GA3129@linux-mips.org> <442130DA.8060407@ict.ac.cn> <20060322113203.GA4544@linux-mips.org>
In-Reply-To: <20060322113203.GA4544@linux-mips.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

> 
>  a) Analyze the code with a simple frame unwinder along the lines of the
>     get_wchan implementation.  Simple but possibly fragile as compilers
>     continue to improve.
>  b) Bite the bullet and use the DWARD 2 frame unwind info and code.  More
>     complicated but will be a solid and correct solution albeit larger so
>     not acceptable for small embedded devices.
> 
> I fear we may have to do both, 2) as the prefered solution and 1) as the
> fallback solution.
OK, thanks. I will have a look at IA64's implementation and port it if
possible.
> 
>   Ralf
> 
> 
> 
