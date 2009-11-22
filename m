Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2009 14:20:54 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48661 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492489AbZKVNUr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Nov 2009 14:20:47 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAMDKl1x010901;
	Sun, 22 Nov 2009 13:20:49 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAMDKiDh010899;
	Sun, 22 Nov 2009 13:20:44 GMT
Date:	Sun, 22 Nov 2009 13:20:44 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [urgent] [loongson] machtype: Fixup of prom_init_machtype()
Message-ID: <20091122132044.GA5353@linux-mips.org>
References: <1258875473-13260-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1258875473-13260-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 22, 2009 at 03:37:53PM +0800, Wu Zhangjin wrote:

> The old version cut off everything of arcs_cmdline after machtype=xxxx,
> which is totally wrong, we need to copy out the machtype=xxxx and then
> operate it.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Thanks, folded into the "MIPS: Loongson: Cleanup machtype support" patch.

  Ralf
