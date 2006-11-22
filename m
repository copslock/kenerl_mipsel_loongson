Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2006 19:31:00 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:4772 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20039197AbWKVTaz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2006 19:30:55 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 270C6E401B
	for <linux-mips@linux-mips.org>; Wed, 22 Nov 2006 12:59:09 -0800 (PST)
Subject: request_module: runaway loop modprobe net-pf-1
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Wed, 22 Nov 2006 11:42:39 -0800
Message-Id: <1164224559.6511.4.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

During boot up on the Encore M3 board (AU1500 MIPS) of the 2.6.14.6
kernel, the process stops after the NFS filesystem has been mounted,
memory freed  and spits out the following message:


> request_module: runaway loop modprobe net-pf-1

I can ping to the board and see that the control periodically goes back
to the flush_local_tlb_all function in the arch/mips/mm/tlb-r4k.c file
and prints a line that I have put in..

What does the net-pf-1 mean?

Thanks
Ashlesha.
