Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2008 18:40:42 +0000 (GMT)
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:43691
	"EHLO QMTA05.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23956805AbYK0Skk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Nov 2008 18:40:40 +0000
Received: from OMTA10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by QMTA05.westchester.pa.mail.comcast.net with comcast
	id kEcF1a00j0cZkys55JgZp3; Thu, 27 Nov 2008 18:40:33 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA10.westchester.pa.mail.comcast.net with comcast
	id kJgU1a00858Be2l3WJgYq9; Thu, 27 Nov 2008 18:40:33 +0000
X-Authority-Analysis: v=1.0 c=1 a=fLOQ5V8KvIcA:10 a=U2v6DU921_sA:10
 a=10jn3E0NSORXkwKcy4MA:9 a=bGL4jPGH4JMnK636LhQiZ0AoAL0A:4 a=WeOa-AV5lc8A:10
 a=XF7b4UCPwd8A:10
Message-ID: <492EE963.2070804@gentoo.org>
Date:	Thu, 27 Nov 2008 13:39:31 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] [MIPS] Remove unused header file gio.h
References: <1227706472-16219-1-git-send-email-dmitri.vorobiev@movial.fi> <20081127091619.GA6255@alpha.franken.de> <43787.88.114.226.209.1227781466.squirrel@webmail.movial.fi> <20081127103706.GA6929@alpha.franken.de>
In-Reply-To: <20081127103706.GA6929@alpha.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> 
> first step is to introduce GIO devices similair to PCI devices. My
> current working GIO device is solid impact. I also looked at
> supporting Phobos G160 cards, but the current set of 2114x drivers
> is not useable for that...

FWIW, I also have one of the ThunderLAN GIO cards for IP22, if you want to cook 
up a driver for that to test this for networking devices.  I also have a G130 
too, both plugged into my Indy.


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
