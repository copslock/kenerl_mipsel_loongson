Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jan 2007 16:27:00 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:14727 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574123AbXAHQ06 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jan 2007 16:26:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l08GRmeQ007282;
	Mon, 8 Jan 2007 16:27:48 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l08GRmZ1007281;
	Mon, 8 Jan 2007 16:27:48 GMT
Date:	Mon, 8 Jan 2007 16:27:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix build_store_reg()
Message-ID: <20070108162748.GB5763@linux-mips.org>
References: <20061218.003821.96686517.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218.003821.96686517.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 18, 2006 at 12:38:21AM +0900, Atsushi Nemoto wrote:

> The commit a923660d786a53e78834b19062f7af2535f7f8ad accidently
> prevents TX49 from using CDEX.  Use build_dst_pref() only if prefetch
> for store was really available.

Applied.  Thanks,

  Ralf
