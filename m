Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1Q6BHN02371
	for linux-mips-outgoing; Mon, 25 Feb 2002 22:11:17 -0800
Received: from chmls20.mediaone.net (chmls20.ne.ipsvc.net [24.147.1.156])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1Q6BA902368;
	Mon, 25 Feb 2002 22:11:10 -0800
Received: from localhost (h00a0cc39f081.ne.mediaone.net [65.96.250.215])
	by chmls20.mediaone.net (8.11.1/8.11.1) with ESMTP id g1Q5DCx07363;
	Tue, 26 Feb 2002 00:13:12 -0500 (EST)
Date: Tue, 26 Feb 2002 00:10:50 -0500
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: Jay Carlson <nop@nop.com>, Hartvig Ekner <hartvige@mips.com>,
   linux-mips@oss.sgi.com
To: Ralf Baechle <ralf@oss.sgi.com>
From: Jay Carlson <nop@nop.com>
In-Reply-To: <20020225173433.B3680@dea.linux-mips.net>
Message-Id: <334839BA-2A77-11D6-AB38-0030658AB11E@nop.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.481)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Monday, February 25, 2002, at 11:34 AM, Ralf Baechle wrote:

> On Mon, Feb 25, 2002 at 04:16:20PM +0100, Hartvig Ekner wrote:
>
>>         .globl ENTRY_POINT
>>         .type ENTRY_POINT,@function
>> ENTRY_POINT:
>> #ifdef __PIC__
>>         SET_GP
>> #else
>>         la  $28, _gp
>> #endif
>>
>> Makes things work (this code ends in crt1.o). Is this the right place 
>> to
>> fix it?
>
> Non-PIC code doesn't use $gp, so any reference to $gp is a bug.  Note
> that we don't support global data optimization for ELF either that is,
> -G 0 is the default.

By default non-PIC code *does* use $gp due to the brain damage in gas; 
gas defaults to -G 8 unless told otherwise (-KPIC implies -G0 so we 
don't see this in PIC code.)  gcc won't know anything about this, of 
course.

What I'm doing in SUBTARGET_ASM_SPEC is to write something like 
"%{fno-pic: %{!G: -G0}}"--if we're not in PIC mode, pass -G0 to gas by 
default.

Anyway, once that's straightened out, -G8 does appear to work the way 
you'd expect, with the code that Hartvig pasted above---I had written a 
byte-for-byte identical patch :-)

Jay
