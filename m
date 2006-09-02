Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Sep 2006 16:46:05 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59021 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S20038716AbWIBPpd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 2 Sep 2006 16:45:33 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.6/8.13.4) with ESMTP id k82G7uI4022291;
	Sat, 2 Sep 2006 17:07:56 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k82G7tsR022290;
	Sat, 2 Sep 2006 17:07:55 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: single step in MIPS
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Nida M <nidajm@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <b01966ec0609020445m693b53cfj87d31a4957627f1a@mail.gmail.com>
References: <b01966ec0609020445m693b53cfj87d31a4957627f1a@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sat, 02 Sep 2006 17:07:54 +0100
Message-Id: <1157213274.6271.382.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

Ar Sad, 2006-09-02 am 17:15 +0530, ysgrifennodd Nida M:
> I am woking for linux2.6.16 on MIPS platform.
> I am tring to implement single stepping on MIPS.
> But I found that there is no single step instruction in the MIPS.

There is no single step instruction feature on most processors. Nor any
need to "implement" single step I suspect

man 2 ptrace
man gdb

The tools exist as standard.
