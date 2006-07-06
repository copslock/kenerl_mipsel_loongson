Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2006 18:37:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41900 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S3489809AbWGFRh3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2006 18:37:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k66HbTBE005088;
	Thu, 6 Jul 2006 18:37:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k66HbTZh005087;
	Thu, 6 Jul 2006 18:37:29 +0100
Date:	Thu, 6 Jul 2006 18:37:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] sparsemem fix
Message-ID: <20060706173729.GB4739@linux-mips.org>
References: <20060705.012244.96686002.anemo@mba.ocn.ne.jp> <44AB79D0.90002@innova-card.com> <20060705.192054.128618288.nemoto@toshiba-tops.co.jp> <44AB99AD.8000403@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AB99AD.8000403@innova-card.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 05, 2006 at 12:51:25PM +0200, Franck Bui-Huu wrote:

> no the code related to NUMA is embedded in ip27 directory. So if
> someone has another NUMA system, she should (a) copy all the stuff
> in its platform directory or (b) make a generic solution maybe based
> on ip27 one for all others NUMA platforms.  But in the second case,
> the NUMA implementation is going to be modified heavily (a guess)
> and probably same for pfn_valid definition.
> 
> The previous change makes things clear: for now, you can't use
> pfn_valid when NUMA or DISCONTIGMEM configs without some reworks.

Most of the related IP27 code bits are for initialization.

  Ralf
