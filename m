Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 19:14:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:9905 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038599AbWJRSOA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Oct 2006 19:14:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9IIEH6o004857;
	Wed, 18 Oct 2006 19:14:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9IIEGSm004856;
	Wed, 18 Oct 2006 19:14:16 +0100
Date:	Wed, 18 Oct 2006 19:14:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	mlachwani <mlachwani@mvista.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: start_kernel(): bug: interrupts were enabled early
Message-ID: <20061018181416.GA4714@linux-mips.org>
References: <20061018155009.GA22031@deprecation.cyrius.com> <45365B8E.8040704@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45365B8E.8040704@mvista.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 18, 2006 at 09:51:26AM -0700, mlachwani wrote:

> The issue is the on_each_cpu() calls made in arch/mips/mm/c-sb1.c. This 
> function enables the interrupts on exit. As a result, you will get this 
> error
> on bootup. The fix is  similar to arch/mips/mm/c-r4k.c, i.e. to have 
> something like r4k_on_each_cpu().

Also cosider using the local_* variant of a cache or tlb flush operation
wherever possible.

  Ralf
