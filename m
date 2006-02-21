Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 14:17:07 +0000 (GMT)
Received: from lennier.cc.vt.edu ([198.82.162.213]:64663 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S8133422AbWBUOQ6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 14:16:58 +0000
Received: from steiner.cc.vt.edu (IDENT:mirapoint@evil-steiner.cc.vt.edu [10.1.1.14])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id k1LENKgC006333;
	Tue, 21 Feb 2006 09:23:20 -0500
Received: from [192.168.1.2] (blacksburg-bsr1-69-170-32-128.chvlva.adelphia.net [69.170.32.128])
	by steiner.cc.vt.edu (MOS 3.7.3a-GA)
	with ESMTP id EZM66178 (AUTH spbecker);
	Tue, 21 Feb 2006 09:23:14 -0500 (EST)
Message-ID: <43FB2252.8030204@gentoo.org>
Date:	Tue, 21 Feb 2006 09:23:14 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060214)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Martin Michlmayr <tbm@cyrius.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060219165245.GD21416@linux-mips.org> <20060220181227.GA17439@deprecation.cyrius.com> <20060221135901.GA30024@networkno.de>
In-Reply-To: <20060221135901.GA30024@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> On Mon, Feb 20, 2006 at 06:12:27PM +0000, Martin Michlmayr wrote:
>> * Ralf Baechle <ralf@linux-mips.org> [2006-02-19 16:52]:
>>>> beginning, the light on the Indy is green but after about 20 seconds
>>>> it turns red.  Nothing happens on the console and the machine doesn't
>>>> turn off.  Seen on Indy and Indigo2.
>>>> Anyone got a fix?
>>> No.  Do you know when this problems started?
>> A long time ago, it seems.  I can trace it back to 2.6.9;
>> unfortunately I don't get any older kernel to run/compile, possibily
>> because my toolchain isn't old enough (I even installed the SDE that's
>> based on 3.3).
> 
> ISTR my 2.6.12 works for Indy shutdown (That's with gcc-4.0).

Now is that with newport or serial console?  I was only able to 
reproduce this when using serial console...and even that is hit or miss. 
  The last time I pulled out my r4400 indy to do some kernel testing, 
this was a major pain in my ass.

Basically, I could log into serial console, do some stuff, enter the 
reboot command from there, and everything would be just fine.  However, 
if I had a serial connection and a ssh connection at the same time, and 
I issued the reboot command from my ssh connection, the machine would 
hang exactly in the way which has been described (sits there for about 
20 seconds doing nothing, and then the red light comes on).

Hmm...now that I think about it some more, I want to say that rebooting 
the machine would hang as long as there was a getty process running on a 
serial port, whether or not I had ever logged in over serial.

For what it's worth, I also use gcc-4 to build my kernels.

-Steve
