Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2008 23:47:31 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15031 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24037832AbYLAXrV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Dec 2008 23:47:21 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493477590000>; Mon, 01 Dec 2008 18:46:33 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Dec 2008 15:46:23 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Dec 2008 15:46:22 -0800
Message-ID: <4934774E.6080805@caviumnetworks.com>
Date:	Mon, 01 Dec 2008 15:46:22 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/4] serial: Patches for OCTEON CPU support (version 2).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Dec 2008 23:46:22.0916 (UTC) FILETIME=[043DA040:01C9540F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips


The previous patch set was Signed-off-by: Andrew Morton and added to
the -mm tree, however comments from Shinya Kuribayashi prompted me to
make some improvements.

The first three patches are unchanged from the previous set (I hope it
is not a breach of etiquette to include them again).  The forth which
allows uart bug types to be statically specified is completely
removed.  And the fifth (now forth) is simplified and now only adds a
uart type for the OCTEON uart.

And as I previously said:
Since these are the only non-mips specific patches required for OCTEON
cpu support, it is necessary to get these Signed-off-by before the
full OCTEON patch set can proceed.


Four patches to follow.

Thanks,

David Daney (4):
   8250: Don't clobber spinlocks.
   8250: Serial driver changes to support future Cavium OCTEON serial
     patches.
   Serial: Allow port type to be specified when calling
     serial8250_register_port.
   Serial: UART driver changes for Cavium OCTEON.

  drivers/serial/8250.c        |  225 
+++++++++++++++++++++++++++++++-----------
  drivers/serial/serial_core.c |    7 +-
  include/linux/serial_8250.h  |    3 +
  include/linux/serial_core.h  |    7 +-
  4 files changed, 179 insertions(+), 63 deletions(-)
