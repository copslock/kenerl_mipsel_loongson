Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Feb 2005 16:50:37 +0000 (GMT)
Received: from ms-1.rz.RWTH-Aachen.DE ([IPv6:::ffff:134.130.3.130]:41471 "EHLO
	ms-dienst.rz.rwth-aachen.de") by linux-mips.org with ESMTP
	id <S8225200AbVBEQuV>; Sat, 5 Feb 2005 16:50:21 +0000
Received: from r220-1 (r220-1.rz.RWTH-Aachen.DE [134.130.3.31])
 by ms-dienst.rz.rwth-aachen.de
 (iPlanet Messaging Server 5.2 HotFix 1.12 (built Feb 13 2003))
 with ESMTP id <0IBG001JU6RW9H@ms-dienst.rz.rwth-aachen.de> for
 linux-mips@linux-mips.org; Sat, 05 Feb 2005 17:50:21 +0100 (MET)
Received: from relay.rwth-aachen.de ([134.130.3.1])
	by r220-1 (MailMonitor for SMTP v1.2.2 ) ; Sat,
 05 Feb 2005 17:50:20 +0100 (MET)
Received: from robins (robins.karman5.RWTH-Aachen.DE [134.130.104.75])
	by relay.rwth-aachen.de (8.13.0/8.13.0/1) with ESMTP id j15GoJ4e019387	for
 <linux-mips@linux-mips.org>; Sat, 05 Feb 2005 17:50:19 +0100 (MET)
Received: from rob by robins with local (Exim 3.36 #1 (Debian))
	id 1CxT8V-0001P4-00	for <linux-mips@linux-mips.org>; Sat,
 05 Feb 2005 17:50:19 +0100
Date:	Sat, 05 Feb 2005 17:50:19 +0100
From:	Robert Michel <news@robertmichel.de>
Subject: patch like kexec for MIPS possible?
To:	linux-mips <linux-mips@linux-mips.org>
Message-id: <20050205165019.GC3071@mail.robertmichel.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <news@robertmichel.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: news@robertmichel.de
Precedence: bulk
X-list: linux-mips

Salve!

Does the MIPS CPUs makes a patch like kexec possible?

Kexec is a kernel patch which allows you to start another kernel.

IMHO would such a kernel patch would be handy, especialy for
small MIPS Linux boxes. For more info about kexec read e.g.
http://www-106.ibm.com/developerworks/linux/library/l-kexec.html

And please don't get me wrong - as a non-kernel-developer I'm
very happy with your work - my question is not a request,
I'm just interested if there is a limitation of the MIPS
platform to do something like this or not.

Greetings,
rob


PS: And _if_ it would be possible, maybe sombody read this
and join thinking that this feature would be realy cool ;)
