Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g38IPt8d032488
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Apr 2002 11:25:55 -0700
Received: (from mail@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g38IPtNZ032487
	for linux-mips-outgoing; Mon, 8 Apr 2002 11:25:55 -0700
X-Authentication-Warning: oss.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g38IPp8d032481
	for <linux-mips@oss.sgi.com>; Mon, 8 Apr 2002 11:25:51 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id TAA22017;
	Mon, 8 Apr 2002 19:36:03 -0700
Message-ID: <3CB1E0B2.8020707@mvista.com>
Date: Mon, 08 Apr 2002 11:25:54 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: New style IRQs for DECstation
References: <Pine.GSO.3.96.1020408195036.26107N-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej W. Rozycki wrote:

> On Mon, 8 Apr 2002, Jun Sun wrote:
> 
> 
>>What is the intention of introducing MIPS_CPU_FPUEX?  It seems an overkill if 
>>it is just needed by DecStation.  How many CPUs really need this?
>>
> 
>  It's needed by any system using a (logically) external FPU.  If set it
> means there is no need to install a special FPU exception handler using a
> general-purpose interrupt line.  It's a generic flag. 
> 
>  Even if it's only of limited use now, it is not an excuse for not writing
> clean code.  I'm afraid the current mess within the MIPS port is a result
> of people trying to think locally and I'm trying to avoid it.  Are there
> any trade-offs of this flags you see and I don't?  I'm willing to change
> the code if there really are. 
> 


Generally interrupt dispatching belongs to machine/board-specific code.  So I 
think FPU exeption through an interrupt is probably best handled within DEC's 
code, instead of being generalized to the common code.

In addition, conceptional you might have a system where FPU exception is 
handled through an interrupt and yet CPU has FPU exception.

Of course abstraction and generalization can happen later when it becomes 
obvious.  It is just not obvious, at least to me.

Jun
