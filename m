Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 13:37:03 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15255 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20048326AbXAXNhA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 13:37:00 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0ODawVW020191;
	Wed, 24 Jan 2007 13:36:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0ODauME020185;
	Wed, 24 Jan 2007 13:36:56 GMT
Date:	Wed, 24 Jan 2007 13:36:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] vr41xx: need one more nop with mtc0_tlbw_hazard()
Message-ID: <20070124133656.GA19038@linux-mips.org>
References: <20070124222206.7dc832a0.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070124222206.7dc832a0.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 24, 2007 at 10:22:06PM +0900, Yoichi Yuasa wrote:

> NEC VR4111 and VR4121 need one more nop with mtc0_tlbw_hazard().
> If I need to separate vr41xx hazard, please let me know.

I doubt the extra complexity would be justified, so I applied your patch
as-is

Thanks,

  Ralf
