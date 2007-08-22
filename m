Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2007 13:51:45 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:22963 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022730AbXHVMvn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Aug 2007 13:51:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7MCpglK030441;
	Wed, 22 Aug 2007 13:51:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7MCpgAf030440;
	Wed, 22 Aug 2007 13:51:42 +0100
Date:	Wed, 22 Aug 2007 13:51:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org, Thiemo Seufer <ths@networkno.de>
Subject: Re: [ths@networkno.de: [PATCH] Maintain si_code field properly for
	FP exceptions]
Message-ID: <20070822125142.GB7715@linux-mips.org>
References: <20070822124818.GA7715@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070822124818.GA7715@linux-mips.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 22, 2007 at 01:48:18PM +0100, Ralf Baechle wrote:

> The appended patch adds code to update siginfo_t's si_code field. It
> fixes e.g. a floating point overflow regression in the SBCL testsuite.
> 
> 
> Thiemo
> 
> 
> Signed-Off-By: Thiemo Seufer <ths@linux-mips.org>

Applied.  Thanks!

  Ralf
