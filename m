Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g156KXp13939
	for linux-mips-outgoing; Mon, 4 Feb 2002 22:20:33 -0800
Received: from chmls18.ne.ipsvc.net (chmls18.ne.ipsvc.net [24.147.1.153])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g156KRA13936
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 22:20:27 -0800
Received: from localhost (h00a0cc39f081.ne.mediaone.net [65.96.250.215])
	by chmls18.ne.ipsvc.net (8.11.6/8.11.6) with ESMTP id g156GlG19456;
	Tue, 5 Feb 2002 01:16:47 -0500 (EST)
Date: Tue, 5 Feb 2002 01:16:46 -0500
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: Jay Carlson <nop@nop.com>, Hiroyuki Machida <machida@sm.sony.co.jp>,
   hjl@lucon.org, linux-mips@oss.sgi.com
To: Dominic Sweetman <dom@algor.co.uk>
From: Jay Carlson <nop@nop.com>
In-Reply-To: <15454.21812.39310.478616@gladsmuir.algor.co.uk>
Message-Id: <EEAA28A0-19FF-11D6-927F-0030658AB11E@nop.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.480)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Monday, February 4, 2002, at 04:32 AM, Dominic Sweetman wrote:

>
> Hiroyuki Machida (machida@sm.sony.co.jp) writes:
>
>> I think we can assume CPU has branch-likely insns, if CPU has MIPS
>> ISA 2 or greater ISA..
>
> "MIPS II" is officially the instruction set introduced for the long
> lost R6000 CPU.
>
> But "MIPS II" is now used to mean "the 32-bit subset of MIPS III"
> (which is extremely close to the same thing, but I'm never quite sure
> about the last details of the R6000 - Kevin would remember better,
> probably).
>
> OK: branch-likely is definitely part of MIPS II and MIPS32.  There are
> still MIPS CPUs in regular use which are based on MIPS I and don't
> provide them.  Generally the advantages of MIPS II are slight, so if
> you want to build a kernel which will not require instruction-set
> variants, it's no big deal to restrict it to MIPS I.

There's load interlocks, which you can depend on starting with MIPS II.  
They're also present on the TX39 and VR41xx.

For non-PIC code, I see around a 5-7% reduction in userland code size by 
compiling with -Wa,-mips2, which afaict just eliminates the generation 
of nops after loads.  The compiler is still generating code anticipating 
the delays, which is good.

For PIC code, I remember the benefits being in the same range.  And 
you're fighting gas, which will generate load-delay nops in the middle 
of la/lw/sw macro expansions in PIC mode regardless of what mips 
architecture you're building for.  I made some patches against an older 
binutils to eliminate those nops for mips2 and up, and got ANOTHER 5-7%, 
of course depending on actual instruction mix.

Given that I tossed out the SVR4 ABI in search of code density in snow, 
I'm probably a little abnormal in these concerns.  But other people on 
small platforms may care.

Jay
