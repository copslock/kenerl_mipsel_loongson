Received:  by oss.sgi.com id <S553855AbRBIUBS>;
	Fri, 9 Feb 2001 12:01:18 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:42743 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553841AbRBIUBJ>;
	Fri, 9 Feb 2001 12:01:09 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f19JvE815916;
	Fri, 9 Feb 2001 11:57:14 -0800
Message-ID: <3A844C16.DD53E7E0@mvista.com>
Date:   Fri, 09 Feb 2001 11:59:18 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: config option vs. run-time detection (the debate continues ...)
References: <Pine.GSO.3.96.1010209123643.4645B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Maciej W. Rozycki" wrote:
> 
>  But the code that needs to know whether there is a real FPU present is
> indeed minimal (as it should be) thus the gain from removing the detection
> altogether in favour to a config option is at least questionable if not
> insane.
> 

Do you like run-time detection better because it allows a kernel to run on
CPUs both with a FPU and without a FPU?  Or there is something else to it?

Another question.  I know with mips32 and mips64 we can do run-time detection
reliably.  What about other existing processors?

Jun
