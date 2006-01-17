Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 13:37:40 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:21278 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465586AbWAQNhX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 13:37:23 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0HDewaZ015960;
	Tue, 17 Jan 2006 13:40:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0HDevoO015959;
	Tue, 17 Jan 2006 13:40:57 GMT
Date:	Tue, 17 Jan 2006 13:40:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kishore K <hellokishore@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: gcc -3.4.4 and linux-2.4.32
Message-ID: <20060117134057.GC3336@linux-mips.org>
References: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 16, 2006 at 05:53:26PM +0530, Kishore K wrote:

> When 2.4.32 kernel (from linux-mips) is compiled with the tool chain based
> on gcc 3.4.4 and binutils 2.16.1, the kernel crashes on malta board. The
> crash file is enclosed along with the mail. If the same kernel is compiled
> with the tool chain based on gcc 3.3.6, no problem is observed.

Linux 2.4 is known to be broken with gcc 3.4 since ages and I won't fix
this.

  Ralf
