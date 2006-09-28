Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 10:43:31 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:3508 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038566AbWI1Jn3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 10:43:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8S9iKjs002417;
	Thu, 28 Sep 2006 10:44:21 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8S9iJvR002416;
	Thu, 28 Sep 2006 10:44:19 +0100
Date:	Thu, 28 Sep 2006 10:44:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manoj Ekbote <manoje@broadcom.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	Mark E Mason <mark.e.mason@broadcom.com>
Subject: Re: [MIPS] SB1: Build fix: delete initialization of flush_icache_page pointer.
Message-ID: <20060928094419.GA747@linux-mips.org>
References: <20060927.235804.95064004.anemo@mba.ocn.ne.jp> <710F16C36810444CA2F5821E5EAB7F230A0E91@NT-SJCA-0752.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710F16C36810444CA2F5821E5EAB7F230A0E91@NT-SJCA-0752.brcm.ad.broadcom.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 27, 2006 at 07:17:16PM -0700, Manoj Ekbote wrote:

> I am wondering if people have booted the latest tree on non-Broadcom
> boards...curious to know if the removal of flush_icache_page has
> affected them.

I applied that patch only after some positive test feedback ...

  Ralf
