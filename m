Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 11:42:19 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:25226 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021528AbXIMKmR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 11:42:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8CNKFgw010975
	for <linux-mips@linux-mips.org>; Thu, 13 Sep 2007 00:20:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8CNKFHX010974;
	Thu, 13 Sep 2007 00:20:15 +0100
Date:	Thu, 13 Sep 2007 00:20:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: pci-to-pci bridges on ip32
Message-ID: <20070912232015.GJ4571@linux-mips.org>
References: <1189536946.7988.62.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1189536946.7988.62.camel@scarafaggio>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 11, 2007 at 08:55:46PM +0200, Giuseppe Sacco wrote:

> Hi all,
> I have a PCI board that is not recognised by Linux on MIPS. Its ID is
> 9710:9250, using an MCS9250 PCI-to-PCI chip manufactured by MosCHIP
> (a.k.a. Netmos). 
> 
> I checked the board on i386 and it works correctly. All devices on that
> board are recognised and every driver is loaded by udev upon startup.
> 
> Is there any problem with pci-to-pci bridges on mips ip32?

Can you give a few more details on the sympthom with this card on IP32?

  Ralf
