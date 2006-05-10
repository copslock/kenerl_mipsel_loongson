Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 09:22:07 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:42402 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133397AbWEJHV7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 09:21:59 +0200
Received: from lagash (88-106-136-76.dynamic.dsl.as9105.com [88.106.136.76])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id C4C6F44F44; Wed, 10 May 2006 09:20:01 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1Fdiyv-00064B-Pb; Wed, 10 May 2006 08:19:37 +0100
Date:	Wed, 10 May 2006 08:19:37 +0100
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] use generic DWARF_DEBUG
Message-ID: <20060510071937.GA7813@networkno.de>
References: <20060510.153604.82350680.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510.153604.82350680.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> When debugging a kernel compiled by gcc 4.1 with gdb 6.4, gdb could
> not show filename, linenumber, etc.  It seems fixed if I used generic
> DWARF_DEBUG macro.  Although gcc 3.x seems work without this change,
> it would be better to use the generic macro unless there were
> something MIPS specific.

There was something MIPS specific for n64 (DWARF64) uuntil very
recently. GCC HEAD switched n64 Linux to DWARF32 some days ago.


Thiemo
