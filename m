Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 16:53:37 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:41486 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20022912AbXICPx3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2007 16:53:29 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1ISEBs-0007RK-00; Mon, 03 Sep 2007 16:50:16 +0100
Received: from ukcvpn58.mips-uk.com ([192.168.193.58] helo=[127.0.0.1])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1ISEBk-0006Ez-00; Mon, 03 Sep 2007 16:50:08 +0100
Message-ID: <46DC2D2E.8080408@mips.com>
Date:	Mon, 03 Sep 2007 16:50:06 +0100
From:	Chris Dearman <chris@mips.com>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line argument.
References: <S20024438AbXHGQ1m/20070807162742Z+2733@ftp.linux-mips.org> <20070904.000501.41013092.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070904.000501.41013092.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: chris@mips.com
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Why pci_get_class() in ide_default_io_base() cause crash on SMTC?

The bug wasn't really SMTC specific, it was just that it showed up on 
SMTC builds. The failure was caused by the early parsing of the 
idebus=xx argument. The argument parser ended up calling
pci_scan that unconditionally enabled interrupts prematurely.

Ralf says this has now been fixed in head of tree:
> Turns out our dear friends at Intel recently had trouble with some JVC CDROM
> drive and their changes made a proper fix for us fairly easy.
> 
> master: 00cc123703425aa362b0af75616134cbad4e0689
> 2.6.22: 50a32ae87aed46b01c8e0c2e90cd6f06a3800c33
> 
> For older kernels the generic PCI code doesn't have the necessary bits in so
> that'd be somewhat more surgery than I want in lmo.

Chris

-- 
Chris Dearman          7200 Cambridge Research Park     +44 1223 203108
MIPS Technologies (UK) Waterbeach, Cambs CB25 9TL  fax  +44 1223 203181
