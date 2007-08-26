Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Aug 2007 16:36:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:57493 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026382AbXHZPgd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 26 Aug 2007 16:36:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7QFaUWa002144;
	Sun, 26 Aug 2007 16:36:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7QFaSQ0002143;
	Sun, 26 Aug 2007 16:36:28 +0100
Date:	Sun, 26 Aug 2007 16:36:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Alchemy DMA and GFP_DMA
Message-ID: <20070826153628.GC29997@linux-mips.org>
References: <20070816110501.GA5701@linux-mips.org> <46D192C9.7070208@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46D192C9.7070208@ru.mvista.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 26, 2007 at 06:48:41PM +0400, Sergei Shtylyov wrote:

>     Those are probably still necessary because the DBDMA descriptors 
>     itselves (not the data they address) must have 32-bit addresses.

A normla GFP_KERNEL allocation will give you that.

  Ralf
