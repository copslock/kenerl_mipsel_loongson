Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 16:48:27 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34241 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039888AbWJJPsZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 16:48:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9AFmXsD014516;
	Tue, 10 Oct 2006 16:48:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9AFmW5U014515;
	Tue, 10 Oct 2006 16:48:32 +0100
Date:	Tue, 10 Oct 2006 16:48:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Do not use -msym32 option for modules.
Message-ID: <20061010154832.GA14476@linux-mips.org>
References: <20061010.221355.119270972.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010.221355.119270972.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 10, 2006 at 10:13:55PM +0900, Atsushi Nemoto wrote:

> On 64-bit kernel, modules are loaded into XKSEG for now.  While XKSEG
> address is not a sign-extended 32-bit address, we can not use -msym32
> option.

It would be a nice optimization to reserve XKSEG for modules on -msym32
configurations.

  Ralf
