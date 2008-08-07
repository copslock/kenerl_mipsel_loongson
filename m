Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 13:48:35 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:151 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20025199AbYHGMs1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Aug 2008 13:48:27 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id ADF67201B2EC;
	Thu,  7 Aug 2008 14:48:23 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 25068-01; Thu, 7 Aug 2008 14:48:23 +0200 (CEST)
Received: from [192.168.27.166] (152-186-96-87.cust.blixtvik.se [87.96.186.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 3481B201B2E4;
	Thu,  7 Aug 2008 14:48:23 +0200 (CEST)
Message-ID: <489AEEF1.60403@27m.se>
Date:	Thu, 07 Aug 2008 14:47:45 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	TriKri <kristoferkrus@hotmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Debugging MIPS cpu with a probe, how?
References: <18830812.post@talk.nabble.com>
In-Reply-To: <18830812.post@talk.nabble.com>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

See: http://www.linux-mips.org/wiki/JTAG for references...

//Markus

TriKri wrote:
> Hello!
>
> I have an embedded system, a box, with a MIPS processor on it,
> which I need to debug (stop and start the processor, tell what
> instructions it has previously executed, etc.). I also have an
> EJTAG probe, which I have connected between the computer's usb and
> the box, and written software for it. The software can communicate
> with the probe, which in its own turn can communicate with the box
> through the tap (test access port), by giving the tap certain
> instructions. It can also, through the tap, feed the MIPS processor
> with instructions, and read/write data from processor registers.
>
> The question is now, how can debug the processor? How do I stop it,
> do I have to send any certain instructions to it? How can I set a
> breakpoint (which I understand is a quite crucial point)? Can I use
> GDB with my software to help debug the processor and how do I do
> that?
>
> Thank you in advance! /Kristofer Krus
- --

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFImu7o6I0XmJx2NrwRCNBvAKCeiyR2G28PHsrHdfgijKwKFzu4MgCffxzZ
Elrh0qJUHc3TbfeeOtvgOBk=
=2Jjo
-----END PGP SIGNATURE-----
