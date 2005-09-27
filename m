Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2005 10:39:47 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:48908 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133567AbVI0Jj2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Sep 2005 10:39:28 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8R9dMND004087;
	Tue, 27 Sep 2005 11:39:22 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8R9dMVi004086;
	Tue, 27 Sep 2005 11:39:22 +0200
Date:	Tue, 27 Sep 2005 11:39:22 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian DELIZY <florian.delizy@sagem.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: linux-mips Vs kernel.org
Message-ID: <20050927093922.GA3793@linux-mips.org>
References: <OFDDFCB8DC.1BFCCB3E-ONC1257089.002AE830-C1257089.002B3D8D@sagem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFDDFCB8DC.1BFCCB3E-ONC1257089.002AE830-C1257089.002B3D8D@sagem.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 27, 2005 at 09:52:01AM +0200, Florian DELIZY wrote:

> We currently working with the 2.6.12 kernel, and wondering which from 
> linux-mips or kernel.org version we should use,
> in a more general manner, what are the differences between linux-mips and 
> kernel.org kernel source code, is one the
> mirror of the other, or is there one that frequently merge with the other 
> ?

At this stage the kernel.org tree is quite unusable for MIPS.

As others have already said, I'm about to dump CVS from linux-mips.org.
You can still access the CVS archive, just don't expect any updates to
it anymore.

  Ralf
