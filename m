Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 12:59:12 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:7198 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133548AbWA3Mz0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 12:55:26 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0UD0QTC005207;
	Mon, 30 Jan 2006 13:00:30 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0U3l6fM022493;
	Mon, 30 Jan 2006 03:47:06 GMT
Date:	Mon, 30 Jan 2006 03:47:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] build blast_cache routines from template
Message-ID: <20060130034706.GB22282@linux-mips.org>
References: <20060129.023055.29575878.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129.023055.29575878.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 29, 2006 at 02:30:55AM +0900, Atsushi Nemoto wrote:

> Build blast_xxx, blast_xxx_page, blast_xxx_page_indexed from template.
> Easy to maintainance and saves 300 lines.
> Output code should not be changed.

Following the long tradition of advanced use of the C preprocessor in
Linux/MIPS I of course applied this patch :-)

  Ralf
