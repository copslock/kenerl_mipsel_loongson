Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 00:23:00 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:51602 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28575122AbXAXAW6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 00:22:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0O0MoIu025209;
	Wed, 24 Jan 2007 00:22:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0O0Mhdb025207;
	Wed, 24 Jan 2007 00:22:43 GMT
Date:	Wed, 24 Jan 2007 00:22:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alexey Dobriyan <adobriyan@gmail.com>
Cc:	akpm@osdl.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: there is no __GNUC_MAJOR__
Message-ID: <20070124002243.GA25189@linux-mips.org>
References: <20070123183014.GB5535@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070123183014.GB5535@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 23, 2007 at 09:30:14PM +0300, Alexey Dobriyan wrote:

> 
> gcc major version number is in __GNUC__. As side effect fix checking with
> sparse if sparse was built with gcc 4.1 and mips cross-compiler is 3.4.
> 
> sparse will inherit version 4.1, __GNUC__ won't be filtered from
> "-dM -E -xc" output, sparse will pick only new major, effectively becoming
> gcc version 3.1 which is unsupported.

Thanks, applied with some polishing to the regex.

  Ralf
