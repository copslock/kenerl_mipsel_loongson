Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 21:34:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7110 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133947AbWEBUef (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 21:34:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k42KYXxC004953;
	Tue, 2 May 2006 21:34:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k42KYRcp004952;
	Tue, 2 May 2006 21:34:27 +0100
Date:	Tue, 2 May 2006 21:34:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Herbert Valerio Riedel <hvr@gnu.org>
Cc:	jgarzik@pobox.com, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH] au1000_eth.c: use ether_crc() from <linux/crc32.h>
Message-ID: <20060502203427.GC3474@linux-mips.org>
References: <E1FaYil-0007A8-HB@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FaYil-0007A8-HB@fencepost.gnu.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 01, 2006 at 01:46:42PM +0000, Herbert Valerio Riedel wrote:

> since the au1000 driver already selects the CRC32 routines, simply replace
> the internal ether_crc() implementation with the semantically equivalent
> one from <linux/crc32.h>
> 
> Signed-off-by: Herbert Valerio Riedel <hvr@gnu.org>

Looks good to me.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
