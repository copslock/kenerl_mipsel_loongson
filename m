Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1Q6NdL02577
	for linux-mips-outgoing; Mon, 25 Feb 2002 22:23:39 -0800
Received: from chmls06.mediaone.net (chmls06.ne.ipsvc.net [24.147.1.144])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1Q6NV902571;
	Mon, 25 Feb 2002 22:23:31 -0800
Received: from localhost (h00a0cc39f081.ne.mediaone.net [65.96.250.215])
	by chmls06.mediaone.net (8.11.1/8.11.1) with ESMTP id g1Q5OYr11951;
	Tue, 26 Feb 2002 00:24:34 -0500 (EST)
Date: Tue, 26 Feb 2002 00:23:12 -0500
Subject: Re: Problems compiling . soft-float
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: Jay Carlson <nop@nop.com>, Ralf Baechle <ralf@oss.sgi.com>,
   mad-dev@lists.mars.org, Carlo Agostini <carlo.agostini@yacme.com>,
   linux-mips@oss.sgi.com
To: Daniel Jacobowitz <dan@debian.org>
From: Jay Carlson <nop@nop.com>
In-Reply-To: <20020226001016.A3303@nevyn.them.org>
Message-Id: <ED8D3BD0-2A78-11D6-AB38-0030658AB11E@nop.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.481)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Tuesday, February 26, 2002, at 12:10 AM, Daniel Jacobowitz wrote:

> On Tue, Feb 26, 2002 at 06:02:37AM +0100, Ralf Baechle wrote:
>> On Mon, Feb 25, 2002 at 11:47:44PM -0500, Jay Carlson wrote:
>>
>>> Ralf is right that the kernel emulator is the supported route.  But if
>>> you're willing to go to the trouble of building everything from 
>>> scratch,
>>> this does work.
>>
>> It's really a major pain.  Softfp isn't defined in the ABI which 
>> assumes
>> an FPU is available.  As the result there is no provision for mixing
>> softfp and fp-less code.
>>
>> Something for the binutils to-do list - ld should make mixing hard-fp
>> and soft-fp binaries impossible.
>
> Or we could see if it is possible to define the ABIs in such a way that
> they can call each other... I don't immediately see a problem.  The
> only code that will clobber FP registers is FP code.

Oh, they can intercall without any error until you call sin(1.0), at 
which point one side's calling convention places 1.0 in integer 
registers and the other places it in fp registers.  Lots of fun to debug 
this one, especially once you have a kernel emulator that won't SIGILL 
for the hardfp ops :-)  Seriously, this was a common screwup in the 
Agenda world until the snow specs file.

Jay
