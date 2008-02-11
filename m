Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Feb 2008 14:59:43 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:62656 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S20030130AbYBKO7f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Feb 2008 14:59:35 +0000
Received: (qmail 25886 invoked from network); 11 Feb 2008 14:59:32 -0000
Received: from unknown (HELO ?10.41.13.129?) (38.101.235.133)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 11 Feb 2008 07:59:31 -0700
Subject: cache line size for a PCI device
From:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Mon, 11 Feb 2008 09:59:00 -0500
Message-Id: <1202741940.3298.80.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips

Should the cache line size of a PCI device be set by the system BIOS,
the linux kernel, or by the device driver? My device currently has the
cache line size set to 0 on my mips box. Is this a bug with the BIOS or
should I be setting this myself. If I should be setting this myself,
what is the best strategy to determine what the cache line size should
be? Right now the best I can do is mimic the PCI configuration space of
my x86 box, but I'm not sure if this is the best way to go or not.

The same thing goes for latency timer.

Thanks for any help,
Jon
