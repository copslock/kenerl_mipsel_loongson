Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 12:39:47 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56242 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492796AbZKQLjo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Nov 2009 12:39:44 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAHBdq67015783;
	Tue, 17 Nov 2009 12:39:53 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAHBdqIw015781;
	Tue, 17 Nov 2009 12:39:52 +0100
Date:	Tue, 17 Nov 2009 12:39:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] loongson: lemote-2f: add NAS support
Message-ID: <20091117113952.GA15759@linux-mips.org>
References: <cover.1258390323.git.wuzhangjin@gmail.com> <e52e8ba2b6dee47e44b155693d9237ece9657890.1258390323.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e52e8ba2b6dee47e44b155693d9237ece9657890.1258390323.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 12:58:14AM +0800, Wu Zhangjin wrote:

> This patch add support to Lemote's Loongson-2F based network attached
> system.
> 
> The kernel support to this machine is almost the same as fuloong2f, the
> only difference is that it use the serial port provided by loongson2f
> processor as yeeloong2f does.

Thanks, queue for 2.6.33.

  Ralf
