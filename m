Received:  by oss.sgi.com id <S553885AbRBFSIS>;
	Tue, 6 Feb 2001 10:08:18 -0800
Received: from natmail2.webmailer.de ([192.67.198.65]:46211 "EHLO
        post.webmailer.de") by oss.sgi.com with ESMTP id <S553699AbRBFSH7>;
	Tue, 6 Feb 2001 10:07:59 -0800
Received: from scotty.mgnet.de (p3E9EC519.dip.t-dialin.net [62.158.197.25])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id TAA24513
	for <linux-mips@oss.sgi.com>; Tue, 6 Feb 2001 19:07:43 +0100 (MET)
Received: (qmail 6025 invoked from network); 6 Feb 2001 18:07:42 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 6 Feb 2001 18:07:42 -0000
Date:   Tue, 6 Feb 2001 19:07:47 +0100 (CET)
From:   Klaus Naumann <spock@mgnet.de>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc:     Kenneth C Barr <kbarr@MIT.EDU>, linux-mips@oss.sgi.com
Subject: Re: netbooting indy - update, elf2ecoff?
In-Reply-To: <Pine.GSO.4.10.10102060732080.15534-100000@escobaria.sonytel.be>
Message-ID: <Pine.LNX.4.21.0102061905330.8851-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 6 Feb 2001, Geert Uytterhoeven wrote:

> However, /dev/console must _not_ be a symlink, but a character special device
> with major 5 minor 1 (cfr. Documentation/devices.txt).

Unless you're using Linux/MIPS :)
The console implementation is horrible broken, so
this means that under most circumstances the 5,1 device doesn't
work. So the only option is to make /dev/console a symlink to /dev/ttyS0.

		Cya, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
