Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 12:40:09 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56249 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492807AbZKQLj5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Nov 2009 12:39:57 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAHBe7sC015789;
	Tue, 17 Nov 2009 12:40:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAHBe7gF015788;
	Tue, 17 Nov 2009 12:40:07 +0100
Date:	Tue, 17 Nov 2009 12:40:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] loongson: lemote-2f: add lynloong support
Message-ID: <20091117114007.GB15759@linux-mips.org>
References: <cover.1258390323.git.wuzhangjin@gmail.com> <f090a0d94d52dd40dadfda678f83ab99f56a86c9.1258390323.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f090a0d94d52dd40dadfda678f83ab99f56a86c9.1258390323.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 12:58:15AM +0800, Wu Zhangjin wrote:

> This patch add a new machtype and kernel options for lynloong, which can
> help to select lynloong specific source code and tell users which type
> of machine they are using via the /proc/cpuinfo interface.

Thanks, queued for 2.6.33.

  Ralf
