Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 17:45:27 +0100 (BST)
Received: from web81407.mail.yahoo.com ([IPv6:::ffff:206.190.37.96]:59266 "HELO
	web81407.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224935AbUIPQpX>; Thu, 16 Sep 2004 17:45:23 +0100
Message-ID: <20040916164516.18061.qmail@web81407.mail.yahoo.com>
Received: from [216.98.102.225] by web81407.mail.yahoo.com via HTTP; Thu, 16 Sep 2004 09:45:16 PDT
X-RocketYMMF: pete_popov
Date: Thu, 16 Sep 2004 09:45:16 -0700 (PDT)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: PCI VGA card info
To: Keath Milligan <keath@keathmilligan.net>,
	Linux MIPS <linux-mips@linux-mips.org>
In-Reply-To: <4149C140.2070605@keathmilligan.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> I have this card but it doesn't seem to work with a
> 2.6 kernel. I'm trying to just get a console visible

> on it at this point, but the card doesn't seem to 
> be getting turned on.

Did you apply the 36 bit patch from my directory? 2.6
does not yet have the 36bit address support integrated
in the tree. However, the patch in my directory is not
complete yet so ioremap would work, but
io_remap_page_range which is what the vga driver would
call would not work. I have a complete patch that
we're reviewing some more before I send it to Ralf.
Note that without the 36 bit support, none of the pci
cards will work.

Pete
