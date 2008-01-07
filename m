Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 16:38:30 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:14054 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574358AbYAGQi2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jan 2008 16:38:28 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m07Gc63V012412;
	Mon, 7 Jan 2008 16:38:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m07Gc458012411;
	Mon, 7 Jan 2008 16:38:04 GMT
Date:	Mon, 7 Jan 2008 16:38:04 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] 64-bit Sibyte kernels need DMA32.
Message-ID: <20080107163804.GB1045@linux-mips.org>
References: <S20038938AbXKZMRu/20071126121750Z+44508@ftp.linux-mips.org> <20071228.014321.41630007.anemo@mba.ocn.ne.jp> <20080108.004113.126142686.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080108.004113.126142686.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 08, 2008 at 12:41:13AM +0900, Atsushi Nemoto wrote:

> How about this fix?

Seems to do the trick on Malta, maybe people can test this patch applied on
top of the master branch of the lmo kernel on various systems?

  Ralf
