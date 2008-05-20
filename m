Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2008 21:27:42 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:25845 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28575545AbYETU1j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2008 21:27:39 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4KKQls0001079;
	Tue, 20 May 2008 22:26:47 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4KKQgK3001075;
	Tue, 20 May 2008 21:26:47 +0100
Date:	Tue, 20 May 2008 21:26:42 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jean Delvare <khali@linux-fr.org>
cc:	Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 6/6] RTC: Trivially probe for an M41T80 (#2)
In-Reply-To: <20080519223718.3c89aa40@hyperion.delvare>
Message-ID: <Pine.LNX.4.55.0805202057380.31790@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805130303430.535@cliff.in.clinika.pl>
 <20080513142829.2d737424@hyperion.delvare> <Pine.LNX.4.55.0805131759580.7267@cliff.in.clinika.pl>
 <20080519223718.3c89aa40@hyperion.delvare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Jean,

> As I wrote above: the I2C device will be listed as present forever. I
> believe it's pretty confusing to have a device listed
> under /sys/bus/i2c/devices which is in fact not present on the system.

 It somehow escaped me a sysfs entry would be present even before the 
driver for this device has been loaded.  You are right, of course.

> On top of that, in case of modular setups with proper coldplug support,
> the I2C device driver will be loaded automatically when the device is
> declared, but will not be removed automatically when the probe fails,
> so this is wasted memory.

 We used to support module unloading unconditionally -- I keep forgetting
this was lifted at one point.  Personally I do not think removing the
requirement for modules to support unloading was a good decision and here
is a good example where it hurts, but obviously we have to live with
whatever consequences of that decision we have.

> The comparison with ISA devices does not hold: ISA devices are created
> by their own drivers (much like the legacy I2C device drivers.) Thus,
> when the probe fails, they can simply delete the device they created (or
> even better, they can delay the device creation until they are sure
> that the device is there.) New-style I2C device drivers do not create
> their devices, so they don't get a chance to delete them nor to delay
> their creation.

 Sometimes you may have to use a device-specific probe sequence and this
is where my comparison is right.  You cannot always escape with random
poking at the device done by the core.  For example some devices have
additional manufacturer/device ID registers -- only the respective drivers
will know which ones are acceptable.  Others may get badly hurt -- not
necessarily broken, but for example reconfigured undesirably -- as a
results of blind accesses.

 Although I agree a generic probe would work with both RTC chips under
question here.

> It could certainly be implemented in terms of i2c_new_probed_device()
> in i2c-sibyte, if it was a proper platform driver with proper platform
> data. I admit it wouldn't be necessarily very elegant, in particular if
> we have more similar cases in the future. That could still do for now,
> though. Converting i2c-sibyte to a proper platform driver is needed
> anyway.

 No question about the conversion -- it's just unlikely to happen soon.

> The flag in struct i2c_board_info would trigger the exact same probing
> mechanism as i2c_new_probed_device() does. The whole point it to test
> for the presence of the device _before_ its driver is loaded. It you
> have to let the I2C device driver decide, then it's already too late:
> the I2C device is created and it won't go even if the probe fails.

 That sounds like a limitation, although perhaps there is not enough
justification to lift it.  I can certainly imagine a flag telling the
driver: "Please check if this device is there for me [=the core] as the
complication behind that is beyond my capabilities."

> If said probing mechanism doesn't work properly for some devices, we'll
> improve it, but it has to stay in i2c-core.

 No doubt as it is good enough for many devices.

> >  Please note this change is not strictly required for the rest of the set
> > to operate correctly on with an M41T81-equipped board, so let's perhaps
> > pull this single patch out till we reach some consensus and proceed with
> > the rest independently.
> 
> Agreed.

 OK.  For now I have investigated hardware compatibility between the
M41T81 and the X1241.  The pinouts are clearly incompatible and I have had
a look at the PCB of my SWARM and it looks like there are no alternative
soldering pads nor any way to rewire the existing ones.  There is no
single dmesg archived in the Internet that would quote "swarm setup: Xicor
1241 RTC detected" either (admittedly that message got removed a short
while ago for no apparent reason, even though it proves useful here).  
Therefore I have to conclude the X1241 could only have been present on
revision 1 boards which are extremely rare and likely not supported by
Linux due to problems with GCC anymore.  Thus I have decided I will
propose to remove support for the X1241 altogether, avoiding the
complication of our I2C support with no apparent beneficiary.  

 I will follow with patch updates shortly.  If somebody who needs support
for the X1241 turns up eventually, then we can think about complications.
"Things should be kept as simple as possible, but not simpler."

  Maciej
