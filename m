Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8AIUuL24092
	for linux-mips-outgoing; Mon, 10 Sep 2001 11:30:56 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8AIUsd24089
	for <linux-mips@oss.sgi.com>; Mon, 10 Sep 2001 11:30:54 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8AIYZA32122;
	Mon, 10 Sep 2001 11:34:36 -0700
Message-ID: <3B9D0527.5B1451BF@mvista.com>
Date: Mon, 10 Sep 2001 11:23:35 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fuxin Zhang <fxzhang@ict.ac.cn>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: kernel test & benchmark tools?
References: <200109031754.f83Hsod32239@oss.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Fuxin Zhang wrote:
> 
> hello,linux-mips
>     I have barely finished porting 2.4 kernel to Algorithmics P6032 board.Now I want
> to make it more stable and run faster,is there any well-known test or benchmark tools used
> by mips kernel group? There are too many benchmark around,I don't know which is better suit
> for kernel test. I heard that linus use lmbench?
>     Thanks in advance.
> Regards


In addition to lmbench, we have also used PCTS, a POSIX compliant test suite. 
There are some issues in cross-compiling environment, but it should be
straightforward if you do a native build.

http://www.itl.nist.gov/div897/ctg/posix_form.htm

Jun
