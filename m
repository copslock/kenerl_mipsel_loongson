Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2006 22:00:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:17815 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133876AbWEIUAG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 May 2006 22:00:06 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k49GfS43010748;
	Tue, 9 May 2006 17:41:28 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k49GfS8N010747;
	Tue, 9 May 2006 17:41:28 +0100
Date:	Tue, 9 May 2006 17:41:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Mark.Zhan" <rongkai.zhan@windriver.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] Wind River 4KC PPMC Eval Board Support
Message-ID: <20060509164127.GA10647@linux-mips.org>
References: <445C6694.6010901@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445C6694.6010901@windriver.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, May 06, 2006 at 05:04:20PM +0800, Mark.Zhan wrote:

> According to your comments, I re-create the patch. Hopefully, no line-wrapped problems:-)
> Patch 1 and 2 in the original mails are concatenated into one patch in this mail.

Well, this patch was still somewhat corrupt, a few spaces were missing
but I was somehow able to talk git into taking it.  So it's applied on
the queue branch.

  Ralf
