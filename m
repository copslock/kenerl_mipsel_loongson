Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 16:54:34 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:12036 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8225388AbTLIQyd>; Tue, 9 Dec 2003 16:54:33 +0000
Received: from spiral.localnet ([192.168.1.11] helo=bitbox.co.uk)
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1ATl7z-0004hd-00
	for <linux-mips@linux-mips.org>; Tue, 09 Dec 2003 16:54:27 +0000
Message-ID: <3FD5FE41.8040909@bitbox.co.uk>
Date: Tue, 09 Dec 2003 16:54:25 +0000
From: Peter Horton <phorton@bitbox.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Kernel 2.4.23 on Cobalt Qube2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Hi.

Has anyone got a 2.4.23 kernel running on the Cobalt Qube 2 ?

I've cross compiled the latest kernel from CVS (using the default Cobalt 
config in the tree) on a PC using gcc 2.95.4 and binutils 2.12.90.0.1 
(both from Debian sources).

The kernel boots okay from the HD, but I get strange segmentation faults 
and other errors whilst running Debian's "dpkg" to install packages. If 
I repeat the installation from scratch I get exactly the same errors in 
exactly the same places :-(

I've changed both the memory SIMMs for new ones and the problem is still 
the same. I've done the same Debian install on an Au1100 board with no 
problems at all.

Neither of the on-board ethernet ports work correctly with new kernel 
either. The primary port seems to work fine pinging single packets back 
and forth, but seems to stall for periods of approx 20 seconds when 
performing bulk transfers. I've been using an RTL8139 card in the PCI 
slot for network access.

TIA,

    P.
