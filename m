Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 12:52:21 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:14245 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039640AbWKAMwT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Nov 2006 12:52:19 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kA1Cqk34015049;
	Wed, 1 Nov 2006 12:52:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kA1Cqj9I015048;
	Wed, 1 Nov 2006 12:52:45 GMT
Date:	Wed, 1 Nov 2006 12:52:45 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix warning mips-boards generic pci
Message-ID: <20061101125245.GC11655@linux-mips.org>
References: <20061101185522.678913fb.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101185522.678913fb.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 01, 2006 at 06:55:22PM +0900, Yoichi Yuasa wrote:

> This patch has fixed the following warning.
> 
> arch/mips/mips-boards/generic/pci.c: In function `mips_pcibios_init':
> arch/mips/mips-boards/generic/pci.c:227: warning: comparison of distinct pointer types lacks a cast
> arch/mips/mips-boards/generic/pci.c:228: warning: comparison of distinct pointer types lacks a cast

Applied as well,

  Ralf
