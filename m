Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 17:24:05 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43828 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493262AbZKWQX6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 17:23:58 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nANGOCu0014939;
	Mon, 23 Nov 2009 16:24:12 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nANGOC98014937;
	Mon, 23 Nov 2009 16:24:12 GMT
Date:	Mon, 23 Nov 2009 16:24:12 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH v1 4/4] [loongson] yeeloong2f: cleanup the reset logic
	with ec_write function
Message-ID: <20091123162412.GD7337@linux-mips.org>
References: <cover.1258800842.git.wuzhangjin@gmail.com> <6dcb6241dda22fe6255b1f74e784f8b20214413c.1258800842.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dcb6241dda22fe6255b1f74e784f8b20214413c.1258800842.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 21, 2009 at 07:05:25PM +0800, Wu Zhangjin wrote:

> A commen ec_read/ec_write function is defined in "[loongson] yeeloong2f:
> add basic ec operations", So, we can use it here to cleanup the reset
> logic of yeeloong2f netbook.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

And this one queued for 2.6.33 as well.

Thanks,

  Ralf
