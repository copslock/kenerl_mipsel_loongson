Received:  by oss.sgi.com id <S305159AbQARBJT>;
	Mon, 17 Jan 2000 17:09:19 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:16500 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQARBIy>; Mon, 17 Jan 2000 17:08:54 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA06670; Mon, 17 Jan 2000 17:13:02 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA42404
	for linux-list;
	Mon, 17 Jan 2000 17:02:41 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA72031
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Jan 2000 17:02:35 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA09079
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Jan 2000 17:02:28 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D3E897FA; Tue, 18 Jan 2000 02:02:16 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 548B58FC4; Tue, 18 Jan 2000 01:07:34 +0100 (CET)
Date:   Tue, 18 Jan 2000 01:07:34 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/MIPS <linux@cthulhu.engr.sgi.com>
Subject: Re: Debian mipsel?
Message-ID: <20000118010734.A1936@paradigm.rfc822.org>
References: <Pine.LNX.4.05.10001172109430.12257-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.05.10001172109430.12257-100000@callisto.of.borg>; from Geert Uytterhoeven on Mon, Jan 17, 2000 at 09:14:23PM +0100
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Jan 17, 2000 at 09:14:23PM +0100, Geert Uytterhoeven wrote:

> Anyone who knows whether Debian for mipsel is already usable? Or is the MIPS
> port of Debian meant for big endian SGI boxes only?

No it isnt ... There are a couple of packages at 

ftp://ftp.rfc822.org/pub/local/debian/debian/dists/potato

Martin Schulze has put together a base tgz as a root filesystem.

> If not, I'll have to say goodbye to apt-get and install a RH-based distro...

Hihi ... apt-get works but there are not many packages to install yet ....

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constand battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
