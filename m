Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1RNrHj22509
	for linux-mips-outgoing; Wed, 27 Feb 2002 15:53:17 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1RNrE922505
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 15:53:14 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g1RMoAB25236;
	Wed, 27 Feb 2002 14:50:10 -0800
Message-ID: <3C7D6353.3030001@mvista.com>
Date: Wed, 27 Feb 2002 14:53:07 -0800
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zhang Fuxin <fxzhang@ict.ac.cn>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: used_math not cleared for new processes?
References: <200202020723.g127N4d30447@oss.sgi.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Zhang Fuxin wrote:

> hi,linux-mips,
>    I find that current->used_math isn't cleared when we start a new process.Is it
> intended? I mean 'start_thread' in do_exec but not 'copy_thread' in do_fork when
> speaking 'start a new process'. We can/should? keep used_math for the latter,but for
> the former?
> 


I think it make sense to clear used_math in do_exec().  It also improvies the
 performance slightly by not loading the parent's FPU context when it uses the
FPU for the first time.

Do you have a patch for this?

Jun
