Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 23:22:50 +0000 (GMT)
Received: from 69-149-250-3.ded.swbell.net ([IPv6:::ffff:69.149.250.3]:43923
	"EHLO optic.calpha.com") by linux-mips.org with ESMTP
	id <S8225257AbVAaXWd>; Mon, 31 Jan 2005 23:22:33 +0000
Received: from mail.okerson.com (optic [127.0.0.1])
	by optic.calpha.com (8.12.11/8.12.11) with ESMTP id j0VNNZK9032020;
	Mon, 31 Jan 2005 17:23:35 -0600
Received: from 66.93.44.28 (proxying for 127.0.0.1)
        (SquirrelMail authenticated user ed);
        by mail.okerson.com with HTTP;
        Mon, 31 Jan 2005 15:23:36 -0800 (PST)
Message-ID: <43690.66.93.44.28.1107213816.squirrel@66.93.44.28>
In-Reply-To: <BBB228F72FF00E4390479AC295FF4B350DE864@FOOTHILL.iad.idealab.com>
References: <BBB228F72FF00E4390479AC295FF4B350DE864@FOOTHILL.iad.idealab.com>
Date:	Mon, 31 Jan 2005 15:23:36 -0800 (PST)
Subject: RE: initial bootstrap and jtag
From:	"Ed Okerson" <ed@okerson.com>
To:	"Joseph Chiu" <joseph@omnilux.net>
Cc:	"Ed Okerson" <ed@okerson.com>,
	"Clem Taylor" <clem.taylor@gmail.com>, linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <ed@okerson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ed@okerson.com
Precedence: bulk
X-list: linux-mips

Joseph,

The AU series processors had some strange behavior relating to the
IDE/PCMCIA/CF interfaces.  Even though the processor was operating in LE
mode, those interfaces remained in BE mode, or something like that.  The
net result was that a CF card written in one mode could not be read in the
other.  The patches were to make the interfaces consistent with the
specifications.  The patches were submitted about a year ago, and as far
as I know were accepted.  I also submitted patches to support CFI flash
detection in LE mode around the same time.

Ed Okerson

> Hi Ed,
> What kinds of patching did you have to do in the source code except for
> the MIPS endian-registers?  I've made such changes plus little-endian-fied
> the build scripts/linker scripts/makefile/etc. but haven't yet had u-boot
> working.  I'm assuming that outside of the bootstrapping, the code is
> endian-independant.  Am I wrong?
> Thanks!
> Joseph
>
>> -----Original Message-----
>> From: linux-mips-bounce@linux-mips.org
>> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Ed Okerson
>> Sent: Monday, January 31, 2005 1:15 PM
>> To: Clem Taylor
>> Cc: linux-mips@linux-mips.org
>> Subject: Re: initial bootstrap and jtag
>>
>>
>> I use the BDI-2000 for an AU1500 based board.  For the boot
>> loader I found
>> u-boot to be very functional.  It did require a bit of
>> patching to handle
>> the Au1500 in little endian mode, but since that is now done
>> everything
>> works great.
>>
>> Ed Okerson
>>
>> > We are finishing up the design of our new Au1550 based board. I was
>> > wondering if someone could recommend an ejtag wiggler. I need
>> > something that has full linux host support, is good enough
>> to flash a
>> > bootloader and do some minimal debug while getting the board support
>> > working. Looking over the list some people seem to be using the
>> > Abatron BDI 2000 and others are using the Macraigor mpDemon. What do
>> > you guys recommend?
>> >
>> > This is my first time doing embedded linux, but I've done
>> quite a bit
>> > with DSPs (written bootloaders, flash programmers, etc). I was
>> > wondering how people go about bootstrapping new Au1xxx
>> systems. Who is
>> > responsible for configuring the PLL or SDRAM enough to allow code to
>> > be loaded into SDRAM? Are bootloaders like YAMON position
>> independent
>> > to run out of SDRAM?
>> >
>> >                                      Thanks,
>> >                                      Clem
>> >
>>
>>
>>
>>
>
