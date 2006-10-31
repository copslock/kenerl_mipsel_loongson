Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2006 12:28:49 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:18869 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038413AbWJaM2s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Oct 2006 12:28:48 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id k9VCTGL7002152;
	Tue, 31 Oct 2006 12:29:16 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id k9VCTFvv002151;
	Tue, 31 Oct 2006 12:29:15 GMT
Date:	Tue, 31 Oct 2006 12:29:15 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add BROKEN to FPCIB0 Backplane support
Message-ID: <20061031122915.GA1857@linux-mips.org>
References: <20061031125329.0b5eef68.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031125329.0b5eef68.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 31, 2006 at 12:53:29PM +0900, Yoichi Yuasa wrote:

> This patch has added "depends on BROKEN" to FPCIB0 Backplane Support.
> The files to make smsc_fdc37m81x.o doesn't exist.

Oh, it does now ;-)

  Ralf
