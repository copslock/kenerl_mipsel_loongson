Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Oct 2004 18:44:05 +0000 (GMT)
Received: from quechua.inka.de ([IPv6:::ffff:193.197.184.2]:9449 "EHLO
	mail.inka.de") by linux-mips.org with ESMTP id <S8225200AbUJaSoA>;
	Sun, 31 Oct 2004 18:44:00 +0000
Received: from pcde.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1COKgF-0005Kh-00; Sun, 31 Oct 2004 19:43:55 +0100
Received: by aton.pcde.inka.de (Postfix, from userid 1001)
	id E99231E5C7; Sun, 31 Oct 2004 19:42:33 +0100 (CET)
Date: Sun, 31 Oct 2004 19:42:33 +0100
From: Dennis Grevenstein <dennis@pcde.inka.de>
To: linux-mips@linux-mips.org
Subject: unable to handle kernel paging request
Message-ID: <20041031184233.GA11120@aton.pcde.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <dennis@pcde.inka.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis@pcde.inka.de
Precedence: bulk
X-list: linux-mips

Hi,

I want to get the current cvs kernel running on
an R5000PC Challenge S. It does compile, but the
kernel does not boot. I get this error repeatedly
printed all over the console until I pull the plug:

<1>CPU 0 Unable to handle kernel paging request at\
 virtual address 00000000, epc == 8810da1c, ra == 8810e22c

What could be wrong?

mfg
Dennis

-- 
There is certainly no purpose in remaining in the dark
except long enough to clear from the mind
the illusion of ever having been in the light.
                                        T.S. Eliot
