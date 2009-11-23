Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 17:20:25 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34651 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493263AbZKWQUS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 17:20:18 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nANGKWlK011954;
	Mon, 23 Nov 2009 16:20:32 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nANGKVPc011952;
	Mon, 23 Nov 2009 16:20:31 GMT
Date:	Mon, 23 Nov 2009 16:20:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH v1 3/4] [loongson] yeeloong2f: add LID open event as
	the wakeup event
Message-ID: <20091123162031.GC7337@linux-mips.org>
References: <cover.1258800842.git.wuzhangjin@gmail.com> <b983b517f93e13dda9d76c3d1719999b0593b9d3.1258800842.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b983b517f93e13dda9d76c3d1719999b0593b9d3.1258800842.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 21, 2009 at 07:05:24PM +0800, Wu Zhangjin wrote:

> Yeeloong2F netbook has an embedded controller(kb3310b) to manage the LID
> action. when the LID is closed/opened, a SCI interrupt is sent out and
> the corresponding event is saved to an EC register for later query.
> 
> This patch allow the LID open action to wake up the processor from wait
> mode if it is in the suspend mode.

Thanks, queued for 2.6.33.

  Ralf
