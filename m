Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 21:38:19 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:38038 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022981AbXCTVhO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 21:37:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2KLYxct004551;
	Tue, 20 Mar 2007 21:35:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2KGONx3028462;
	Tue, 20 Mar 2007 16:24:23 GMT
Date:	Tue, 20 Mar 2007 16:24:23 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix potential SPARSEMEM bug
Message-ID: <20070320162423.GA27540@linux-mips.org>
References: <20070321.005628.118975639.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070321.005628.118975639.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 21, 2007 at 12:56:28AM +0900, Atsushi Nemoto wrote:

> The first pfn of zones should be min_low_pfn, not 0.

This one indeed looks like it will strike on some configs.  Applied.

Thanks,

  Ralf
