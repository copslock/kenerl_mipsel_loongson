Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g48IH4wJ004345
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 8 May 2002 11:17:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g48IH4Bl004344
	for linux-mips-outgoing; Wed, 8 May 2002 11:17:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g48IGwwJ004341
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 11:16:58 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA13302;
	Wed, 8 May 2002 11:17:54 -0700
Message-ID: <3CD96B76.5090506@mvista.com>
Date: Wed, 08 May 2002 11:16:22 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Geoffrey Espin <espin@idiom.com>,
   "Siders, Keith" <keith_siders@toshibatv.com>,
   "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: Debugging of embedded target applications
References: <7DF7BFDC95ECD411B4010090278A44CA379AA1@ATVX> <20020507221512.GA22326@nevyn.them.org> <20020507154427.D12509@idiom.com> <20020508014314.GA30243@nevyn.them.org> <20020507192523.A73748@idiom.com> <20020508023236.GA31840@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:

> On Tue, May 07, 2002 at 07:25:23PM -0700, Geoffrey Espin wrote:
> 
>>On Tue, May 07, 2002 at 09:43:14PM -0400, Daniel Jacobowitz wrote:
>>
>>>>Does work it for kernel type debugging over *Ethernet*?
>>>>I see some docs saying "TCP/IP" connection... but does that
>>>>mean a special kind of network driver?  Or a gdbstub/agent
>>>>outside the kernel in a special monitor?
>>>>
>>>What do you mean by kernel type debugging?  It's not a kernel stub.  It
>>>can debug user programs over TCP/IP or a serial line.
>>>
>>In traditional embedded RTOS land, "system-level debugging".
>>In the olden days one had to have BDM/JTAG hardware assist
>>to step thru truly arbitary bits of code, like interrupt handlers,
>>scheduler.
>>
>>The original question was about using using a hardware debugger.
>>Clearly using gdb/gdbserver is for apps only, AFAIK.  Does one
>>bother with a h/w debugger for apps?  Using kgdb with some kind
>>
> 
> Actually, yes, you can.  I believe at least the Abatron BDI can do
> this.  Could be wrong, though.
> 


I have used kgdb over JTAG.

Jun
