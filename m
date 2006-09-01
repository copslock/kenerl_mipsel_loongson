Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Sep 2006 00:31:28 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:9094 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20038655AbWIAXb0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 2 Sep 2006 00:31:26 +0100
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 136EDE404D
	for <linux-mips@linux-mips.org>; Fri,  1 Sep 2006 16:50:35 -0700 (PDT)
Subject: early_initcall
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Fri, 01 Sep 2006 16:38:40 -0700
Message-Id: <1157153920.8242.5.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

I m using the 2.6.14.6 tree and trying to get the kernel running on the
Encore M3 board.  

The kernel crashes during the boot process at the early_initcall.  This
function doesnt seem to be defined anywhere.  Which is the last version
of the 2.6 tree that still supports the early_initcall?

Thanks,
Ashlesha.
