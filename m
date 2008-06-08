Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Jun 2008 20:52:20 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:40354 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20026418AbYFHTwS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Jun 2008 20:52:18 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m58JooQY005872;
	Sun, 8 Jun 2008 12:50:51 -0700 (PDT)
Received: from [127.0.0.1] (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m58Jpe4h003247;
	Sun, 8 Jun 2008 12:51:40 -0700 (PDT)
Message-ID: <484C38A6.7080503@mips.com>
Date:	Sun, 08 Jun 2008 21:53:10 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	Luke -Jr <luke@dashjr.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
Subject: Re: bcm33xx port
References: <200806072113.26433.luke@dashjr.org> <200806072332.06460.luke@dashjr.org> <Pine.LNX.4.55.0806081332560.15673@cliff.in.clinika.pl> <200806081357.02601.luke@dashjr.org>
In-Reply-To: <200806081357.02601.luke@dashjr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Luke -Jr wrote:
> On Sunday 08 June 2008, Kevin D. Kissell wrote:
>   
>> and (b) control being transferred to a block of memory that isn't actually
>> code, as can happen if exception vectors or global pointers-to-functions
>> aren't set up correctly, or if the kernel stack is being corrupted.   When
>> you say "the instruction in question is a store word", how do you know that? 
>>     
>
> The RI error spits out a bunch of info, including epc which presumably points 
> to the instruction causing the problem: ac85ffc0; this is 'sw a1,-64(a0)'
>   
But unless the processor itself is actually defective, there is no way that
a  SW instruction can cause an RI exception.  Sometimes a kernel crash
is so violent that the kernel stack frame cannot be reliably decoded by
the crash dump code, and this would appear to be one of those cases.
I find the address of 0xac85ffc0 to be a bit suspicious, myself.  That's
a kseg1 (non-cacheable identity map) address for physical address
0x0c85ffc0, which would be legitimate (though suspicious) if you had
256MB of RAM, but the boot log quote you posted earlier suggests
that you've only got 16M.  Is there really memory of some kind at
that address?  Are you calling routines in a boot ROM from Linux?

Debugging Linux kernel crashes is probably not the best way to learn
the MIPS privileged resource architecture.  I'd strongly recommend
http://www.amazon.com/See-MIPS-Second-Dominic-Sweetman/dp/0120884216/

          Regards,

          Kevin K.
