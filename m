Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2005 02:41:42 +0000 (GMT)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:39585 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225370AbVAVClg>; Sat, 22 Jan 2005 02:41:36 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (sccrmhc13) with ESMTP
          id <2005012202412901600ha7q4e>; Sat, 22 Jan 2005 02:41:29 +0000
Message-ID: <41F1BE9E.8070109@gentoo.org>
Date:	Fri, 21 Jan 2005 21:46:54 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
CC:	linux-mips@linux-mips.org
Subject: Re: O2 and 128Mb
References: <1105602134.10493.23.camel@localhost>	 <41E627F8.3010004@total-knowledge.com>	 <1105605285.10490.52.camel@localhost>	 <41E6CB5B.6080303@total-knowledge.com> <1106338775.4760.17.camel@localhost>	  <41F168DA.60301@total-knowledge.com> <1106342715.4757.27.camel@localhost>
In-Reply-To: <1106342715.4757.27.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Giuseppe Sacco wrote:
> 
> I think my O2 just blowed up :-(
> Actually it doesn't switch on. Even unplugging and plugging again the
> power cord, it stay off.

Pull the mainboard out, find the flash-clear jumper, cover it with a nearby 
jumper cap (this jumper and cap should be near the RTC, a Dallas chip).  Pop 
the board back into the system, and see if it powers on.  If it does, power 
back off, remove the jumper cap, and then power back up, and it should power 
up fine.

If nothing happens, you probably cooked the power supply.  O2's are apparently 
  known for blowing power supplies, though.  Replacements can be easily found 
on eBay.


> Fortunately, I have a second machine that I may use for tests, while
> I'll find the problem with the first one. The second machine is the same
> model of the first one. I just swapped disks and cable and made your
> test: nothing changed.

Drop minicom, I get nothing but trouble with it.  Use "xc", a small, simple 
dial program.  If it's not on your system, you'll have to install it via 
whatever means your working distro provides, then do this:

xc -l/dev/ttyS0

 > set bps <O2 baud rate>
 > t

After typing 't' and pressing enter, you'll be dropped to terminal mode.  Try 
powering on the O2 at this point, and see if you get any output.  If not, you 
may have the O2 rigged to still boot the graphical console.  To fix this, you 
will need to hook up a monitor, mouse, and keyboard, get into the PROM, and:

 > setenv console d1
 > setenv dbaud <desired baud rate>

Then poweroff, and remove the keyboard, mouse, and monitor (if the O2 PROM 
detects these as being attached, it may still boot graphical), and try to 
reboot again to see if you get anything on xc's terminal.

To boot the kernel, make sure you pass "console=ttyS0,<baud rate>" to it, 
cause for me, w/o it, the kernel will sometimes not pick up the serial port, 
and thus you won't see any output (but the kernel will still boot (or attempt 
to)).

If all else fails, replace the serial cable.  Sometimes they just don't work 
for whatever reason.


> Actually it is still blocked there: blinking the red led, while showing
> the "Starting 32-bit kernel" on the screen. How do I reset an O2?

The flashing red LED is implying the kernel booted, then paniced suddenly. 
Until you get the console working in whatever fashion, you won't know why.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
