Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 11:49:26 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:13318 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465685AbVJTKtK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 11:49:10 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9KAn2eP010147;
	Thu, 20 Oct 2005 11:49:02 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9KAn2C6010146;
	Thu, 20 Oct 2005 11:49:02 +0100
Date:	Thu, 20 Oct 2005 11:49:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Isaacson <adi@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 8/12]  cerr-printk-not-prom-printf
Message-ID: <20051020104902.GA9491@linux-mips.org>
References: <20051020065320.GA23857@broadcom.com> <20051020065757.GH23899@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051020065757.GH23899@broadcom.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 19, 2005 at 11:57:57PM -0700, Andrew Isaacson wrote:

> Use printk rather than prom_printf in cache error handlers.
> prom_printf does not handle SMP locking, and shows up only
> on console (not in dmesg(1) or syslog).

This patch essentially reverses

  http://www.linux-mips.org/git?p=linux.git;a=blobdiff;h=b2d41a2b0c406db6be87d02f51600e7e3013a748;hp=051290842231d9734d0bb2dc4c56b8590c4f5337;hb=760190d3f99ebabd965bd35324d5d084ff266711;f=arch/mips/mm/cerr-sb1.c

(Yuck, gitk URLs are bloody long ...)

The reason for this old commit was that this code is running uncached, so
the operation of ll/sc in the spinlocks is undefined according to the
MIPS64 spec, also there is a potencial deadlock since printk's
logbuf_lock might be held.

The old pass 1 part did truely exercise the cache error handler ;-)

  Ralf
