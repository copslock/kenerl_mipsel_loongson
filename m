Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 10:41:33 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:58793 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133463AbWEBJlZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 10:41:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k429fOcw004601;
	Tue, 2 May 2006 10:41:24 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k429fNW3004600;
	Tue, 2 May 2006 10:41:23 +0100
Date:	Tue, 2 May 2006 10:41:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Make interrupt handler works for all cases
Message-ID: <20060502094123.GB4301@linux-mips.org>
References: <cda58cb80605020055r2597bf3ds9fb380aab8cbf7b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80605020055r2597bf3ds9fb380aab8cbf7b3@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 02, 2006 at 09:55:51AM +0200, Franck Bui-Huu wrote:

> specially when the kernel is mapped.

At which time you're on very fragile ice because TLB instructions should
better be executed from an unmapped address ...

  Ralf
