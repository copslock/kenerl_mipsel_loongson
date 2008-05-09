Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2008 20:37:39 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:61679 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20023796AbYEIThh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2008 20:37:37 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m49JacxQ012312;
	Fri, 9 May 2008 21:36:38 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m49Ja1nr012302;
	Fri, 9 May 2008 20:36:01 +0100
Date:	Fri, 9 May 2008 20:36:00 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jean Delvare <khali@linux-fr.org>
cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
In-Reply-To: <20080508095658.40eb74f4@hyperion.delvare>
Message-ID: <Pine.LNX.4.55.0805092019100.10552@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
 <20080507090514.3a86cf4b@hyperion.delvare> <Pine.LNX.4.64.0805070936060.6341@anakin>
 <20080507094343.25f279b9@hyperion.delvare> <Pine.LNX.4.55.0805072214090.25644@cliff.in.clinika.pl>
 <20080508095658.40eb74f4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Jean,

> $ find linux-2.6.26-rc1 -name Kconfig | wc -l
> 455
> $ find linux-2.6.26-rc1 -name Makefile | wc -l
> 1030
> $

 Well, these are not pieces of code and serve a different purpose, don't
they?

> Not to mention the 102 setup.c, 87 irq.c, 62 time.c... It is very
> common to have duplicated file names in the kernel tree because it
> supports so many architectures and platforms. In general, when you work

 Well, that is not a technical argument.  It is a fact of life, sure, but
it does not necessarily mean it is right, but perhaps that nobody has
really thought about it.

> on a given architecture or platform, names become unique again. Taking
> GDB as an example again, you definitely know what architecture you are
> debugging, so there should be relatively little ambiguity on what files
> are involved.

 Hmm, why to have little ambiguity, when you can have none?  We do not
rely on crippled filesystems, so we do not have to save characters in file
names -- we keep them reasonably short anyway.  I say there is no
technical advantage in having duplicate file names throughout the tree
(please name one if I am wrong) and there are advantages -- however small,
but still -- in keeping file names unique.  Therefore the gain from
converting the existing file names may not justify the effort required,
but it does not mean new additions may not take the gain into account?

> (On top of that, I'd argue that we _should_ be able to display relative
> paths to file names when debugging.)

 Human's perception is limited -- GDB's `info frame' is probably already
overloaded with information, so adding the path to the source file in
question will not make it any better.

> Your point about the "single program namespace" is certainly valid for
> small to medium-size programs, but in the case of something as big as
> the kernel, it probably no longer holds.

 I think it is actually the reverse -- the bigger a project is, the easier
to get lost within. ;-)  With small programs it is easier to maintain,
while with bigger ones it is really where it pays off.

> I don't have a strong opinion on this either, it is very unlikely that
> I'll ever have to deal with this file personally. I'm only telling you
> what the common practice is in the kernel tree.

 I don't think this practice has been architected and see above for
justification why it may not necessarily be the cleverest idea. :-)

  Maciej
