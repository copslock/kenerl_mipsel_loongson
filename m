Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2004 19:48:34 +0100 (BST)
Received: from sorrow.cyrius.com ([IPv6:::ffff:65.19.161.204]:55301 "EHLO
	sorrow.cyrius.com") by linux-mips.org with ESMTP
	id <S8225974AbUEMSsd>; Thu, 13 May 2004 19:48:33 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id C645064D3B; Thu, 13 May 2004 18:48:28 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id AB9AAFF6F; Thu, 13 May 2004 19:47:24 +0100 (BST)
Date: Thu, 13 May 2004 19:47:24 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Joerg Rossdeutscher <joerg@factorlocal.de>
Cc: linux-mips@linux-mips.org
Subject: Re: RaQ2: Installation stops at "loading debian installer"
Message-ID: <20040513184724.GA12261@deprecation.cyrius.com>
References: <5055A94A-A503-11D8-B16C-000A956A056E@aurora.factorlocal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5055A94A-A503-11D8-B16C-000A956A056E@aurora.factorlocal.de>
User-Agent: Mutt/1.5.6i
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Joerg Rossdeutscher <joerg@factorlocal.de> [2004-05-13 19:31]:
> The last lines say:
> 
> >execute initrd={initrd-size}@{initrd-start} 
> console=ttyS0,{console-speed}
> elf: 80080000 <-- 00001000 1916928t+176112t
> elf: entry 801fc040
> net: interface down

That's the same as I get:

> -script
> lcd 'Loading' 'debian-installer'
> tftp {dhcp-next-server} vmlinux-2.4.25-r5k-cobalt initrd.gz
arp: request from 192.168.1.1
...
> execute initrd={initrd-size}@{initrd-start} console=ttyS0,{console-speed}
elf: 80080000 <-- 00001000 1916928t + 176112t
elf: entry 801fc040
net: interface down
CPU revision is: 000028a0
FPU revision is: 000028a0
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB 2-way, linesize 32 bytes.
Linux version 2.4.25-r5k-cobalt (root@solitude.cyrius.com) (gcc version 3.3.3 (Debian 20040321)) #1 Thu Apr 15 15:17:00 BST 2004

Well, immediately after the message you saw, control should be passed to the
kernel and you should see kernel message.  I don't really know why that
wouldn't work in your case.

-- 
Martin Michlmayr
tbm@cyrius.com
