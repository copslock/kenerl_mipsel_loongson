Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 May 2003 12:01:17 +0100 (BST)
Received: from nx5.HRZ.Uni-Dortmund.DE ([IPv6:::ffff:129.217.131.21]:4708 "EHLO
	nx5.hrz.uni-dortmund.de") by linux-mips.org with ESMTP
	id <S8225193AbTEKLBP>; Sun, 11 May 2003 12:01:15 +0100
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE [129.217.128.51])
	by nx5.hrz.uni-dortmund.de (Postfix) with ESMTP id 68DF64AA7E0
	for <linux-mips@linux-mips.org>; Sun, 11 May 2003 13:01:14 +0200 (MET DST)
Received: from linuxpc1 (p508EDBF0.dip.t-dialin.net [80.142.219.240])
	(authenticated (0 bits))
	by unimail.uni-dortmund.de (8.12.9+Sun/8.11.6) with ESMTP id h4BB0rtC024684
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits) verified NOT)
	for <linux-mips@linux-mips.org>; Sun, 11 May 2003 13:01:05 +0200 (MEST)
From: Benjamin =?iso-8859-1?q?Menk=FCc?= <benmen@gmx.de>
Reply-To: menkuec@auto-intern.com
To: linux-mips@linux-mips.org
Subject: Re: compiling glibc
Date: Sun, 11 May 2003 13:00:50 +0200
User-Agent: KMail/1.5.1
References: <200305092145.43690.benmen@gmx.de> <20030511092828.GA3889@bogon.ms20.nix> <200305111252.52661.benmen@gmx.de>
In-Reply-To: <200305111252.52661.benmen@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305111300.50226.benmen@gmx.de>
X-MailScanner-Information: UniDo-UniMail
X-MailScanner: Found to be clean
Return-Path: <benmen@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benmen@gmx.de
Precedence: bulk
X-list: linux-mips

I have to put some optimization flag into CFLAG="" because otherwise I get the 
error: glibc can't be compiled without optimization...

what should I do?

regards,

Ben
