Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 14:35:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:17335 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20044440AbXAWOfl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 14:35:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0NEZfh1018896;
	Tue, 23 Jan 2007 14:35:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0NEZfhU018895;
	Tue, 23 Jan 2007 14:35:41 GMT
Date:	Tue, 23 Jan 2007 14:35:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: Re: [PATCH 3/7] signal: clean up sigframe structure
Message-ID: <20070123143541.GD18083@linux-mips.org>
References: <1169561903878-git-send-email-fbuihuu@gmail.com> <11695619031474-git-send-email-fbuihuu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11695619031474-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 23, 2007 at 03:18:19PM +0100, Franck Bui-Huu wrote:

> +#ifndef ICACHE_REFILLS_WORKAROUND_WAR

The _WAR symbols are always defined as either 0 or 1 so this #ifndef
will never be true.

  Ralf
