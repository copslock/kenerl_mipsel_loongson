Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jan 2007 11:45:07 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:43158 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28584491AbXAILpF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Jan 2007 11:45:05 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l09BjrLP006719;
	Tue, 9 Jan 2007 11:45:53 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l09BjqO5006718;
	Tue, 9 Jan 2007 11:45:52 GMT
Date:	Tue, 9 Jan 2007 11:45:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, danieljlaird@hotmail.com
Subject: Re: [MIPS] PNX8550: Fix system timer support
Message-ID: <20070109114552.GA6614@linux-mips.org>
References: <S28574475AbXAHSAL/20070108180011Z+188138@ftp.linux-mips.org> <20070109.102300.126576736.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109.102300.126576736.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 09, 2007 at 10:23:00AM +0900, Atsushi Nemoto wrote:

> Please apply this patch too.  Daniel confirmed this patch fixes a long
> hang on boot.
> 
> Subject: PNX8550: Fix system timer initialization

Thanks, applied.

  Ralf
