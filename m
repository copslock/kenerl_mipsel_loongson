Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5QHKanC012198
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 26 Jun 2002 10:20:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5QHKaoX012197
	for linux-mips-outgoing; Wed, 26 Jun 2002 10:20:36 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5QHKRnC012180
	for <linux-mips@oss.sgi.com>; Wed, 26 Jun 2002 10:20:28 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA05290;
	Wed, 26 Jun 2002 10:23:31 -0700
Message-ID: <3D19F728.7020903@mvista.com>
Date: Wed, 26 Jun 2002 10:17:28 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ladislav Michl <ladis@psi.cz>, Ralf Baechle <ralf@uni-koblenz.de>,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: DBE/IBE handling rewrite
References: <Pine.GSO.3.96.1020626121553.23599A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I suggest we have a function pointer called board_bus_error_init, which is 
initialized to a NULL function.  Any board that wishes to override it can do 
so in <board>_setup() routine.

With more amd more MIPS boards poping up, the more friendly board interface is 
the better.

Jun

Maciej W. Rozycki wrote:

> On Tue, 25 Jun 2002, Maciej W. Rozycki wrote:
> 
> 
>> This way, the fixup search is invoked first and a system-specific handler
>>can judge whether to let the fixup be invoked or a serious failure
>>happened and the system should act appropriately.  The handler can do
>>whatever actions are needed (e.g. clear error status data in system
>>registers, report ECC syndromes, etc.) for the system for both cases.
>>
> 
>  OK, here is the code.  I wrote it a bit differently from what I
> considered yesterday, as fixup doesn't seem useful for a system-specific
> handler.  With the following code only a boolean flag is passed informing
> whether a fixup is available and the handler can decide how to treat an
> error, based on the state passed as arguments and possibly additional one
> obtained from system-specific resources.  Both MIPS and MIPS64 are handled
> in the same way.  For MIPS64 it means a removal of duplicated similar code
> as well.  I adjusted some SGI-specific code appropriately, but platform
> maintainers will have to check if bus_error_init() stubs are OK for them.
> 
>  Ralf, OK to apply?
> 
>   Maciej
> 
> 
