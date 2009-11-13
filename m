Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2009 12:07:11 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43359 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492413AbZKMLHI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Nov 2009 12:07:08 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nADB7Bwp028202;
	Fri, 13 Nov 2009 12:07:12 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nADB7Apt028200;
	Fri, 13 Nov 2009 12:07:10 +0100
Date:	Fri, 13 Nov 2009 12:07:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [loongson] Fixups of "MIPS: Loongson 2F: Add suspend
	support framework"
Message-ID: <20091113110710.GA25667@linux-mips.org>
References: <1258077808-582-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1258077808-582-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 13, 2009 at 10:03:28AM +0800, Wu Zhangjin wrote:

> You have helped changing the CPU_SUPPORT_CPUFREQ to
> CPU_SUPPORTS_CPUFREQ(arch/mips/Kconfig), we need to change it here too.
> 
> Could you please fold this patch into "MIPS: Loongson 2F: Add suspend
> support framework"?

Uh, sorry.  Fixed.

  Ralf
