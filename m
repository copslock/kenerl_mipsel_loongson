Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 21:20:55 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55252 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493053AbZKKUUw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Nov 2009 21:20:52 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nABKKr4I001702;
	Wed, 11 Nov 2009 21:20:54 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nABKKrtm001700;
	Wed, 11 Nov 2009 21:20:53 +0100
Date:	Wed, 11 Nov 2009 21:20:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH -queue 2/2] [loongson] 2f: Cleanups of the #if clauses
Message-ID: <20091111202053.GA20613@linux-mips.org>
References: <cover.1257917611.git.wuzhangjin@gmail.com> <367b02daf305474f0bf59b995c27d6a5aaa2e962.1257917611.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367b02daf305474f0bf59b995c27d6a5aaa2e962.1257917611.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 11, 2009 at 01:39:12PM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds two new kernel options: CPU_SUPPORT_CPUFREQ and
> CPU_SUPPORT_ADDRWINCFG to describe the new features of loongons2f, and
> replaces the several ugly #if clauses by them.
> 
> These two options will be utilized by the future loongson revisions
> and/or by the relative drivers, such as the coming Loongson2F CPUFreq
> driver.

Queued with some minor changes.  Thanks!

  Ralf
