Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 18:52:57 +0100 (BST)
Received: from smtp220.tiscali.dk ([IPv6:::ffff:62.79.79.114]:6889 "EHLO
	smtp220.tiscali.dk") by linux-mips.org with ESMTP
	id <S8224827AbTFJRwx> convert rfc822-to-8bit; Tue, 10 Jun 2003 18:52:53 +0100
Received: from cpmail4.dk.tiscali.com (mail.tiscali.dk [212.54.64.159])
	by smtp220.tiscali.dk (8.12.6p2/8.12.6) with ESMTP id h5AHqgBQ054821
	for <linux-mips@linux-mips.org>; Tue, 10 Jun 2003 19:52:51 +0200 (CEST)
	(envelope-from mleopold@tiscali.dk)
Received: from [130.225.96.2] by cpmail4.dk.tiscali.com with HTTP; Tue, 10 Jun 2003 19:52:31 +0200
Date: Tue, 10 Jun 2003 19:52:31 +0200
Message-ID: <3EDD28A400000B96@cpfe4.be.tisc.dk>
From: mleopold@tiscali.dk
Subject: Linux on Indigo2 (IP28) - R10000
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Return-Path: <mleopold@tiscali.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mleopold@tiscali.dk
Precedence: bulk
X-list: linux-mips

Hi All.
I just got my hands on an old SGI Indigo2 and I would like to install Linux
on it (preferably Debian). I've searched a few places and I get contradicting
signals on whether this might work or not. The machine is an Indigo2 (IP28)
175MHz R10000.

I've tried booting over the net using bootp and tftp following the instructionsin
the debian-howto.. The machine gets an IP and immediately writes "execute
format error" (using the r4k-ip22/tftpboot.img image). I'm guessing that
this is and 32/64 bit problem, but I really haven't got a clue. I found
an other image looking like it might be a 64 bit image (from Kumba, the
Gentoo guy), it downloads and then freezes the machine.

Can anybody give me some hints here: what I'm I suppose to do? Will this
ever work? I don't really care about installation method (network, cd, etc).
There was some talk in Febuary on a guy got Linux up and running on an Origin
200 - and some bootable cd's. That sounded prety interesting =]

Btw: I also got my hands on an Octane (IP30) with an R10000 (195 Mhz) -
I haven't tried to install on this one, but that might be interesting too..

--
Regards Martin Leopold.
Dept. of Computer Science, University of Copenhagen
