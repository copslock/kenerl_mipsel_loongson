Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QFuAv23737
	for linux-mips-outgoing; Tue, 26 Feb 2002 07:56:10 -0800
Received: from chmls16.mediaone.net (chmls16.ne.ipsvc.net [24.147.1.151])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QFu2923733;
	Tue, 26 Feb 2002 07:56:03 -0800
Received: from localhost (h00a0cc39f081.ne.mediaone.net [65.96.250.215])
	by chmls16.mediaone.net (8.11.1/8.11.1) with ESMTP id g1QEtdP28335;
	Tue, 26 Feb 2002 09:55:39 -0500 (EST)
Date: Tue, 26 Feb 2002 09:55:30 -0500
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: Jay Carlson <nop@nop.com>, Hartvig Ekner <hartvige@mips.com>,
   linux-mips@oss.sgi.com
To: Ralf Baechle <ralf@oss.sgi.com>
From: Jay Carlson <nop@nop.com>
In-Reply-To: <20020226125532.B7497@dea.linux-mips.net>
Message-Id: <E0CB6130-2AC8-11D6-AB38-0030658AB11E@nop.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.481)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Tuesday, February 26, 2002, at 06:55 AM, Ralf Baechle wrote:

> On Tue, Feb 26, 2002 at 12:10:50AM -0500, Jay Carlson wrote:
>
>> By default non-PIC code *does* use $gp due to the brain damage in gas;
>> gas defaults to -G 8 unless told otherwise (-KPIC implies -G0 so we
>> don't see this in PIC code.)  gcc won't know anything about this, of
>> course.
>>
>> What I'm doing in SUBTARGET_ASM_SPEC is to write something like
>> "%{fno-pic: %{!G: -G0}}"--if we're not in PIC mode, pass -G0 to gas by
>> default.
>>
>> Anyway, once that's straightened out, -G8 does appear to work the way
>> you'd expect, with the code that Hartvig pasted above---I had written a
>> byte-for-byte identical patch :-)
>
> I agree on that one except that 64kB of small data no longer seem to be
> sufficient for every common application in the world.  So I'd vote for a
> more defensive choice of the -G value, that is 0.

Right.  In my ideal world, here's how it would work:

cc1 defaults to -G0.  I think we have that now.

gas defaults to -G0.  Messing with SUBTARGET_ASM_SPEC has that effect 
for people who use the gcc driver, but anybody invoking gas directly 
will still hit this problem, but too bad.

So I think the primary constituency for gas defaulting to -G8 are 
existing cygnuhhhh I mean redhat embedded MIPS customers, outside of 
Linux; that's who we should check with before we change the default.

Jay
