Received:  by oss.sgi.com id <S553725AbQKRR0h>;
	Sat, 18 Nov 2000 09:26:37 -0800
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35848 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S553712AbQKRR0T>;
	Sat, 18 Nov 2000 09:26:19 -0800
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 13xBlP-0001tb-00; Sat, 18 Nov 2000 17:26:55 +0000
Subject: Re: sysmips syscall
To:     kaos@melbourne.sgi.com (Keith Owens)
Date:   Sat, 18 Nov 2000 17:26:54 +0000 (GMT)
Cc:     ralf@oss.sgi.com (Ralf Baechle), linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
In-Reply-To: <23098.974555179@ocs3.ocs-net> from "Keith Owens" at Nov 19, 2000 12:46:19 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xBlP-0001tb-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> Use Dekker's algorithm between systems.  It requires cache coherent
> memory but does not need any inter cpu locking mechanisms.

Cache coherent and write ordered
