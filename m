Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2003 22:37:17 +0100 (BST)
Received: from mailgate5.cinetic.de ([IPv6:::ffff:217.72.192.165]:22181 "EHLO
	mailgate5.cinetic.de") by linux-mips.org with ESMTP
	id <S8225209AbTGYVhN>; Fri, 25 Jul 2003 22:37:13 +0100
Received: from web.de (fmomail03.dlan.cinetic.de [172.20.1.236])
	by mailgate5.cinetic.de (8.11.6p2/8.11.2/SuSE Linux 8.11.0-0.4) with SMTP id h6PLb6Q01329
	for linux-mips@linux-mips.org; Fri, 25 Jul 2003 23:37:06 +0200
Date: Fri, 25 Jul 2003 23:37:06 +0200
Message-Id: <200307252137.h6PLb6Q01329@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: =?iso-8859-1?Q? "Frank=20F=F6rstemann" ?= <Foerstemann@web.de>
To: linux-mips@linux-mips.org
Subject: No mouse support for Indy in 2.5.75 ?
Precedence: fm-user
Content-Type: multipart/mixed; boundary="STEFAN3f21a302758c"
Return-Path: <Foerstemann@web.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Foerstemann@web.de
Precedence: bulk
X-list: linux-mips

This is a MIME encoded message.
--STEFAN3f21a302758c
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi.

I tried kernel version 2.5.75 on my Indy. It works fine with the
exception that the mouse in XFree86 does not move. The devices are 
available, but event debugging shows no mouse events at all. Are there
any special configuration options for the Indy mouse except the ones in
the 'input' section ? Dmesg output and kernel configuration are
attached.

Regards

Frank


______________________________________________________________________________
Spam-Filter fuer alle - bester Spam-Schutz laut ComputerBild 15-03
WEB.DE FreeMail - Deutschlands beste E-Mail - http://s.web.de/?mc=021120
--STEFAN3f21a302758c
Content-Type: application/gzip; name="dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline; filename="dmesg.gz"

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

--STEFAN3f21a302758c--
