Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 16:51:50 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:13074 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133560AbWB1QvX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 16:51:23 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id A52BD64D3D; Tue, 28 Feb 2006 16:58:46 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 9BEB581F5; Tue, 28 Feb 2006 17:58:38 +0100 (CET)
Date:	Tue, 28 Feb 2006 16:58:38 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	ladis@linux-mips.org, tmnousia@cc.hut.fi
Subject: VINO doesn't work with 2.6.16-rc5: Problem getting video capabilities
Message-ID: <20060228165838.GA4489@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

The VINO driver doesn't seem to work in 2.6.16-rc5.  When I load the
module, I get:

Linux video capture interface: v1.00
SGI VINO driver version 0.0.5
VINO revision 0 found
Philips SAA7191 driver version 0.0.5
SAA7191 initialized
SGI IndyCam driver version 0.0.5
IndyCam v1.0 detected
IndyCam initialized

However, when I try to take a picture, I get:

sgi:~# vgrabbj
Problem getting video capabilities
Fatal Error (non-daemon), exiting...
There was no map allocated to be freed...

And in dmesg:

ioctl32(vgrabbj:2306): Unknown cmd fd(3) cmd(403c7601){00} arg(0044f11c) on /dev/video

sgi:~# uname -a
Linux sgi 2.6.16-rc5-r4k-ip22 #2 Tue Feb 28 03:57:30 UTC 2006 mips64 GNU/Linux


It works fine with 2.4.26:

sgi:~# modprobe vino
i2c-core.o: i2c core module version 2.6.1 (20010830)
Linux video capture interface: v1.00
VINO Rev: 0x00
VINO: clipping 0, 0, 640, 486 / 1 - 640
VINO: clipping 0, 0, 640, 486 / 1 - 640
Indycam v1.0 detected.

sgi:~# vgrabbj > x.jpg
VINO: scaling 0, 0, 352, 288 / 1 - 1408
Reading image from /dev/video
VINO: intr status 0004
VINO: chnl A clear EOD
VINO: intr status 0002
VINO: chnl A clear EOD
sgi:~#

-- 
Martin Michlmayr
http://www.cyrius.com/
