Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jun 2004 15:04:24 +0100 (BST)
Received: from skl1.ukl.uni-freiburg.de ([IPv6:::ffff:193.196.199.1]:27559
	"EHLO relay1.uniklinik-freiburg.de") by linux-mips.org with ESMTP
	id <S8225457AbUFVOEU>; Tue, 22 Jun 2004 15:04:20 +0100
Received: from ktl77.ukl.uni-freiburg.de (ktl77.ukl.uni-freiburg.de [193.196.226.77])
	by relay1.uniklinik-freiburg.de (Email) with ESMTP id 03B2F2F4B7
	for <linux-mips@linux-mips.org>; Tue, 22 Jun 2004 16:04:15 +0200 (CEST)
From: Max Zaitsev <maksik@gmx.co.uk>
Organization: Mutella Dev co.
To: linux-mips <linux-mips@linux-mips.org>
Subject: booting SGI O2 from HD
Date: Tue, 22 Jun 2004 16:04:18 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406221604.18306.maksik@gmx.co.uk>
Return-Path: <maksik@gmx.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksik@gmx.co.uk
Precedence: bulk
X-list: linux-mips

Hi!

Looks like it is not quite easy to make the o2 box to boot from the hard 
drive... I have tried both volume header solution (kernel crashes) and 
arcboot-0.3.8.1 (just prints some numbers and hangs without any further 
output, even without printing out the entry point). I've compiled arcboot 
with gcc-3.3.3 from the stage3 tarball available from kumba. Do I have to 
tweak some compile flags or do I need patches to arcboot? Or can somebody put 
out a working binary boot image per chance? 

Regards,
Max
