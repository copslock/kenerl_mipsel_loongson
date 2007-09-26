Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 17:59:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:1679 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029808AbXIZQ7F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 17:59:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8QGx2H4014973;
	Wed, 26 Sep 2007 17:59:03 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8QGx1fV014972;
	Wed, 26 Sep 2007 17:59:01 +0100
Date:	Wed, 26 Sep 2007 17:59:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alexander Voropay <alec@nwpi.ru>
Cc:	qemu-devel@nongnu.org, Thiemo Seufer <ths@networkno.de>,
	linux-mips@linux-mips.org, vlad@comsys.ro
Subject: Re: [Qemu-devel] Qemu and Linux 2.4
Message-ID: <20070926165901.GA13582@linux-mips.org>
References: <46E68AA3.2010907@comsys.ro> <20070911125421.GE10713@networkno.de> <46E69AAF.2090509@comsys.ro> <029001c80059$d7a14960$e90d11ac@spb.in.rosprint.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029001c80059$d7a14960$e90d11ac@spb.in.rosprint.ru>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 26, 2007 at 08:25:18PM +0400, Alexander Voropay wrote:

> >>>- QEMU malta emulation is not really complete, to put it mildly
> >>Out of curiosity, what parts did you miss?
> >Like, for example, the PCI stuff. So I can use the network card.
> 
> PCI stuff in the QEMU/Malta works fine, but pseudo-bootrom
> does not perform PCI enumeration and leaves uninitialized PCI BARs.
> 
> Linux MIPS/Malta 2.4 can not perform PCI enumeration too.  The LANCE
> Ethernet driver *requres* a pre-initialized BARs. The situation even worse,
> since current Linux 2.4 can't be even built with NEW_PCI and PCI_AUTO
> options at all (due to linkage error).
> 
> http://www.linux-mips.org/wiki/PCI_Subsystem
> 
> There is the same PCI problem with NetBSD/evbmips and seems VxWorks/Malta.

Both CONFIG_PCI_NEW and PCI_AUTO were amazingly broken in both concept
and implementation.  It is possible to get them to work well for particular
configurations but for the general case nothing else nothing but rewrite
can rescue things.

> >And yes, I am aware of YAMON.
> 
> AFAIK, YAMON may runs on the MIPS hardware only, and may not
> be redistribuded in the source or binary form.

Alchemy boards run YAMON, too.

> *******************************************************************************************************
> This message and any attachments (the "message") are confidential and 
> intended solely for the addressees. Any unauthorised use or dissemination 

Soley for all the billion internet users, I assume ;-)

  Ralf
