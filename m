Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2008 14:02:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:14224 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28579275AbYCLOCE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Mar 2008 14:02:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2CE22wL026091;
	Wed, 12 Mar 2008 14:02:02 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2CE21pb026090;
	Wed, 12 Mar 2008 14:02:01 GMT
Date:	Wed, 12 Mar 2008 14:02:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix the installation condition of MIPS
	clocksource
Message-ID: <20080312140201.GA25986@linux-mips.org>
References: <20080218230459.35c2204b.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080218230459.35c2204b.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 18, 2008 at 11:04:59PM +0900, Yoichi Yuasa wrote:

> MIPS clocksource has been installed on DEC 5000/200(R3000).
> The installation condition of MIPS clocksource is wrong.

A bug indeed but I figured it was cleaner to have init_mips_clocksource()
itself check for the presence of an r4k style counter like other
device initialitation functions.  So I went for a different fix for
both 2.6.24 and master.

Thanks for raising the issue,

  Ralf
