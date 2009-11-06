Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 13:48:48 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41663 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492680AbZKFMsp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Nov 2009 13:48:45 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA6CoFxk006262;
	Fri, 6 Nov 2009 13:50:15 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA6CoFEK006260;
	Fri, 6 Nov 2009 13:50:15 +0100
Date:	Fri, 6 Nov 2009 13:50:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH -queue 1/2] [loongson] Cleanup the machtype support
Message-ID: <20091106125015.GA31392@linux-mips.org>
References: <cover.1257503696.git.wuzhangjin@gmail.com> <905f2e99289a26852bf8d413f0e56ef2235cac99.1257503696.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905f2e99289a26852bf8d413f0e56ef2235cac99.1257503696.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 06, 2009 at 06:35:33PM +0800, Wu Zhangjin wrote:

> We need to initialize mips_machtype as early as we can, So, we can
> choose corresponding code for different machines via it.
> 
> This patch moves the initialization of mips_machtype to prom_init().
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Thanks, queued for 2.6.33.

  Ralf
