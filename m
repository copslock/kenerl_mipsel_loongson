Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2009 19:43:46 +0000 (GMT)
Received: from wmproxy1-g27.free.fr ([212.27.42.91]:8629 "EHLO
	wmproxy1-g27.free.fr") by ftp.linux-mips.org with ESMTP
	id S21366270AbZCETno (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Mar 2009 19:43:44 +0000
Received: from wmproxy1-g27.free.fr (localhost [127.0.0.1])
	by wmproxy1-g27.free.fr (Postfix) with ESMTP id AC6BB630C5;
	Thu,  5 Mar 2009 20:43:40 +0100 (CET)
Received: from UNKNOWN (imp8-g19.priv.proxad.net [172.20.243.138])
	by wmproxy1-g27.free.fr (Postfix) with ESMTP id 736746306D;
	Thu,  5 Mar 2009 20:43:38 +0100 (CET)
Received: by UNKNOWN (Postfix, from userid 0)
	id 7291C3696AA8A; Thu,  5 Mar 2009 20:43:38 +0100 (CET)
Received: from  ([83.154.79.221]) 
	by imp.free.fr (IMP) with HTTP 
	for <s.boutayeb@172.20.243.55>; Thu, 05 Mar 2009 20:43:38 +0100
Message-ID: <1236282218.49b02b6a6c724@imp.free.fr>
Date:	Thu, 05 Mar 2009 20:43:38 +0100
From:	s.boutayeb@free.fr
To:	gnewsense-dev@nongnu.org
Cc:	dclark@gnu.org, rms@gnu.org, debian-mips@lists.debian.org,
	linux-mips@linux-mips.org
Subject: gns mips-l: what next?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 83.154.79.221
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <s.boutayeb@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: s.boutayeb@free.fr
Precedence: bulk
X-list: linux-mips

Hi,

The "gNewSense mips-l" project (
http://wiki.gnewsense.org/Projects/GNewSenseToMIPS ) is on a good way, thanks to
the support of the gNewSense team, of the FSF, of Lemote Tech, and of various
contributors around the world.

So far, we have a gNewSense-compliant Debian installer allowing the execution of
netboot installation procedure from an usb stick and fine-tuned for the lemote
hardware. The installation and the upgrade uses the archive set by the FSF at
http://archive.gnewsense.org/gnewsense-mipsel-l/.

The Lemote hardware ("yeeloong 8089" laptop and "Fuloong 6003" mini box) boot
from the bsd licensed PMON200 boot loader.

The netboot install procedure has be proven successful on the "Yeeloong 8089"
laptop and remains to be tested on the "Fuloong 6003" mini box. We have now a
nice full-free laptop with beautiful arts designed by the gNewSense-arts-team, a
working gnome desktop environment. Many things need to be polished: for example
the apm (the battery of the laptops show a 0% gauge), the webcam is not yet
working), but we have full networking capabilities (both wired and wireless), a
functional xorg server (thanks to the siliconmotion driver from lemote's dev),
etc.

In the same time, Lemote Tech's team has setup a netboot installation procedure
http://dev.lemote.com/drupal/node/58 and has provided valuable advice, hardware
resources, code, etc. to the gNewSenseToMips project. This was a big help for us
all.

Now, how could we move forward? Maybe:
- improving
- testing
- documenting
- upgrading
- promoting
- upstreaming
- etc.

That is, many things, but not too much, considering the realistic perspective
that more talents decide to contribute to the gNewSense project. You are
wellcome!

Thank you for your comments and for your support!

Cheers

Samy
