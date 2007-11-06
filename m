Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2007 14:03:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:40104 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022644AbXKFODk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Nov 2007 14:03:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA6E3ej8028946;
	Tue, 6 Nov 2007 14:03:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA6E3eKU028945;
	Tue, 6 Nov 2007 14:03:40 GMT
Date:	Tue, 6 Nov 2007 14:03:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <fbuihuu@gmail.com>
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] tlbex.c: use __cacheline_aligned instead of
	__tlb_handler_align attribute
Message-ID: <20071106140340.GC18017@linux-mips.org>
References: <1192691477-4675-1-git-send-email-fbuihuu@gmail.com> <1192691477-4675-4-git-send-email-fbuihuu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1192691477-4675-4-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 18, 2007 at 09:11:16AM +0200, Franck Bui-Huu wrote:

> To: ralf@linux-mips.org
> Cc: anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org
> Subject: [PATCH 3/4] tlbex.c: use __cacheline_aligned instead of
> 	__tlb_handler_align attribute

Queued for 2.6.25.

Thanks alot,

  Ralf
