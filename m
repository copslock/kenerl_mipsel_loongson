Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2008 00:44:14 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13947 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20874242AbYJGXoH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Oct 2008 00:44:07 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48ebf4280000>; Tue, 07 Oct 2008 19:43:36 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 7 Oct 2008 16:43:34 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 7 Oct 2008 16:43:34 -0700
Message-ID: <48EBF426.9080500@caviumnetworks.com>
Date:	Tue, 07 Oct 2008 16:43:34 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
CC:	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: [PATCH 0/4] serial: 8250 driver improvements & Cavium OCTEON serial
 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2008 23:43:34.0633 (UTC) FILETIME=[83376D90:01C928D6]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a follow up to the 'Allow for replaceable I/O functions in
8250 driver' patch I sent yesterday.  I hope it addresses the issues
raised by Alan Cox and Arnd Bergmann.

The four parts of the patch are as follows:

1/4) Add replaceable I/O functions to the 8250 driver.  This allows
     platform specific register access code to be moved out of the
     driver into the platform support files.

2/4) Add a new port flag UPF_FIXED_TYPE that allows callers of
     serial8250_register_port() to specify the port type and disables
     probing.

3/4) Add a 'bugs' field to the serial8250_config.  Used in conjunction
     with 2/4, this allows the bugs flags to be set without probing.

4/4) Add an entry to uart_config for PORT_OCTEON describing the
     OCTEON's internal UARTs.  Two new bug flags are defined to
     account for PORT_OCTEON's peculiarities.

Comments welcome,

David Daney
