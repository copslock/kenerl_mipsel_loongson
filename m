Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 12:03:22 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:53519 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133713AbVLEMCa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Dec 2005 12:02:30 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jB5C1RT2008013;
	Mon, 5 Dec 2005 12:01:27 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jB5C1PXd008012;
	Mon, 5 Dec 2005 12:01:25 GMT
Date:	Mon, 5 Dec 2005 12:01:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	maillist@jg555.com, linux-mips@linux-mips.org
Subject: Re: Cobalt IDE Patch
Message-ID: <20051205120125.GB2728@linux-mips.org>
References: <4393CE3B.20303@jg555.com> <20051205.144319.126575575.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205.144319.126575575.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 05, 2005 at 02:43:19PM +0900, Atsushi Nemoto wrote:

> jim> This is Peter Horton's IDE patch for the Cobalt. From the notes
> jim> in Peter's file.
> 
> I suppose this patch is not required anymore since current
> asm-mips/mach-generic/ide.h takes care of dcache aliases.
> 
> If Cobalt's IDE did not work with with the generic ide.h, it should be
> fixed instead of adding one more ide.h.

Amen.

  Ralf
