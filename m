Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 May 2009 00:22:54 +0100 (BST)
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:39879
	"EHLO QMTA12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026010AbZEIXWt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 10 May 2009 00:22:49 +0100
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by QMTA12.emeryville.ca.mail.comcast.net with comcast
	id patT1b00B17UAYkACbNi7L; Sat, 09 May 2009 23:22:42 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA13.emeryville.ca.mail.comcast.net with comcast
	id pbNg1b00858Be2l8ZbNh8h; Sat, 09 May 2009 23:22:42 +0000
Message-ID: <4A06100F.7020105@gentoo.org>
Date:	Sat, 09 May 2009 19:21:51 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Help getting IP30/Octane fixed?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Well, I've been keeping the Octane/IP30 port alive for quite some time lately, 
but the bitrot in the code is making the functionality get progressively worse. 
  As of 2.6.30, the following will _not_ work:

- SMP capabilities (hangs on boot)
- Impact framebuffer (Oopes the kernel)
- Probably any PCI device plugged into the optional card cage

Unfortunately, I do not have the knowledge or capabilities to fix these, let 
alone the time needed to re-write some portions of the code to make these work 
properly.  And that's not including the work needed to actually get this code 
into the mainline kernel.

So I'm looking for help from people that know the kernel a lot better than I, 
and don't mind a little bit of a challenge on getting this machine to work 
straight again.  Maybe even help in some way to get it into an appropriate state 
to submit for inclusion in the kernel.

I've put the minimum three patches needed to get this machine to boot online at 
this address:
http://dev.gentoo.org/~kumba/mips/ip30_code/

Here's what each one does:

5011_2.6.30-ioc3-metadriver-r27.patch

This is a partial implementation of turning the IOC3 device in Octane (and also 
in Origin-class systems) into a bus of sorts.  IOC3 on Octane governs access to 
the keyboard/mouse ports, ethernet controller, Real-time clock (a DS1687-5 
chip), front panel LEDs, and probably the parallel port.  It's not a 
fully-documented device, and violates the PCI spec in very unique ways, which 
requires special handling.


5012_2.6.22-ioc3-revert_commit_691cd0c.patch

This is a reversal of a patch committed to upstream almost 2 years ago (possibly 
longer), which broke IOC3 (when using the above metadriver) by making Linux 
enforce adherence to the PCI specification (I think, anyways.  It's been too 
long).  Without reversing this patch, none of the IOC3 sub-devices are accessible.

Original submission of it (with description) is here:
http://lkml.org/lkml/2007/1/26/67


5041_2.6.30-ip30-octane-support-r28.patch

This is the base code for the Octane port.  I've largely maintained it via 
bandaid fixes, but even bandaids can't keep a ship from sinking forever.  I 
managed to figure out the IRQ stuff to move Octane to using 
set_irq_and_chip_handler, which got it booting again, but this broke the Impact 
video driver, which will oops the kernel on initialization.  SMP code broke back 
in 2.6.24 due to improper conversion to dyntick, and I've never been able to 
figure out why, because my only SMP CPU module turned out to have died while in 
storage.


So if anyone wants to help, take a look, and let me know if there are any 
questions.  I'll answer what I can.

Thanks!,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
