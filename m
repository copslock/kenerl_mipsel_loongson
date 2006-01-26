Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 11:22:43 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:2582 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133511AbWAZLW0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 11:22:26 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0QBQfVL004562;
	Thu, 26 Jan 2006 11:26:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0QBQcX4004561;
	Thu, 26 Jan 2006 11:26:38 GMT
Date:	Thu, 26 Jan 2006 11:26:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Optimize swab operations
Message-ID: <20060126112638.GC3411@linux-mips.org>
References: <cda58cb80601260308v3eecf0d0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80601260308v3eecf0d0w@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 26, 2006 at 12:08:25PM +0100, Franck wrote:

> This patch uses 'wsbh' instruction to optimize swab operations. This
> instruction is part of the MIPS Release 2 instructions set.

Will apply.  Small nit - you must include <linux/config.h> in every file
that is refering to a CONFIG_* symbols, I'll take care of that.

  Ralf
