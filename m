Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id WAA07809
	for <pstadt@stud.fh-heilbronn.de>; Fri, 17 Sep 1999 22:08:06 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA14289; Fri, 17 Sep 1999 13:02:45 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA91262
	for linux-list;
	Fri, 17 Sep 1999 12:56:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA51782
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Sep 1999 12:56:19 -0700 (PDT)
	mail_from (roryh@dcs.ed.ac.uk)
Received: from haymarket.ed.ac.uk (haymarket.ed.ac.uk [129.215.128.53]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA02387
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Sep 1999 12:56:17 -0700 (PDT)
	mail_from (roryh@dcs.ed.ac.uk)
Received: from dcs.ed.ac.uk (rory@dialup-110.publab.ed.ac.uk [129.215.38.110])
	by haymarket.ed.ac.uk (8.8.7/8.8.7) with ESMTP id UAA02976;
	Fri, 17 Sep 1999 20:56:14 +0100 (BST)
Message-ID: <37E29EBF.FA10420D@dcs.ed.ac.uk>
Date: Fri, 17 Sep 1999 21:04:15 +0100
From: Rory Hunter <roryh@dcs.ed.ac.uk>
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Re: about the O2..
References: <37E159C8.4CE49EF@dcs.ed.ac.uk> <v04220300b407f10f6f0e@[216.63.49.245]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Hi,

Here's something to amuse you in the meantime:-

Being an IRIX newbie, more used to RH linux, upon encountering an
install of IRIX 6.3 (and a decidedly stale one at that), I naturally
went about trying to impose order opon the chaos and tried to make the
filesystem layout etc. more like the linux server's. Copious Fear and
Loathing was forthcoming upon discovering than /bin was nothing more
than a symbolic link, and that most of the system utils were in /sbin.
After eventually getting a bash shell onto the box (by ftp'ing onto it
as root, no less), a struggle in itself, I was told by the gee-whizz GUI
sysadmin tool that I wasn't allowed to change root's home directory (a
quick hack of /etc/passwd soon fixed that). Then I thought that it would
be nice to rearrange the system utilities ala linux... no such luck,
those bloody symlinks confused me to the point where I managed to toast
'ls'. Stop and think. How many times in a day do you use 'ls'? Scary
isn't it... the only way to view files now is using the point-and-drool
icon interface.

It get's better though; we don't have any install disks, since we got it
second hand at a dodgy auction, so I had to download a .tardist file
with the utilites (like I did with bash, though it took my a *litle*
while to work out that a tardist was like an rpm). Then of course I
attempted to install, only to discover that the GUI tool and tool that
said GUI tool uses die screaming in the absence of 'ls'... go work it
out, it's not pretty.

So now we've got to (gasp) buy a distribution of IRIX, which costs no
less that 260 UKP, with P+P costing a further 30 UKP... I feel decidedly
withered by the whole experience, so much so that if I had my way I'd
probably install Hard Hat on it, X or no X. Which would almost be a
shame, since the mouse and monitor are rather nice. Well, at least the
keyboard has some decent weight behind it, something of a rarity these
days it seems (Edinburgh Uni have some great, and proper UNIX, keyboard
in some places, you know, keyboards you could wield two-handed as
viscious weapons).

Oh, and Photoshop costs $995 dollars for UNIX <slump>.


Happy hacking,

Rory Hunter
