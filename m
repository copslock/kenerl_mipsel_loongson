Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 00:16:16 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:47180 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23916063AbYKZAQG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Nov 2008 00:16:06 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492c94fe0000>; Tue, 25 Nov 2008 19:14:54 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 16:14:52 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 16:14:52 -0800
Message-ID: <492C94FC.9070906@caviumnetworks.com>
Date:	Tue, 25 Nov 2008 16:14:52 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/5] serial: Patches for OCTEON CPU support.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Nov 2008 00:14:52.0416 (UTC) FILETIME=[00B42000:01C94F5C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Previously I have posted these five patches as part of the larger CPU
support patch set.  I am separating them out now as I have
incorporated changes as suggested by Alan Cox, and these are ready for
review now.

Changes from previous version:

* I/O functions now called serial_{in,out}.

* UART_BUG_OCTEON_IIR workaround moved to OCTEON serial_in function
   and out of this patch set.

Since these are the only non-mips specific patches required for OCTEON
cpu support, it is necessary to get these Signed-off-by before the
full OCTEON patch set can proceed.  Also since serial is lacking
active maintainers, I am sending directly to akpm and Alan in hopes
that one or more of them will review the patches.


Five patches to follow.

David Daney (5):
   8250: Don't clobber spinlocks.
   8250: Serial driver changes to support future Cavium OCTEON serial
     patches.
   Serial: Allow port type to be specified when calling
     serial8250_register_port.
   8250: Allow port type to specify bugs that are not probed for.
   Serial: UART driver changes for Cavium OCTEON.

  drivers/serial/8250.c        |  230 
+++++++++++++++++++++++++++++++-----------
  drivers/serial/8250.h        |    2 +
  drivers/serial/serial_core.c |    7 +-
  include/linux/serial_8250.h  |    3 +
  include/linux/serial_core.h  |    7 +-
  5 files changed, 185 insertions(+), 64 deletions(-)
