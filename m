Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 15:01:19 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64909 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021839AbXHAOBQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 15:01:16 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l71E1FLf024209;
	Wed, 1 Aug 2007 15:01:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l71E1EEX024208;
	Wed, 1 Aug 2007 15:01:14 +0100
Date:	Wed, 1 Aug 2007 15:01:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: cacheops.h & r4kcache.h
Message-ID: <20070801140114.GA23858@linux-mips.org>
References: <40378e40708010618r7a93e58br206e7c47e685a05e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40378e40708010618r7a93e58br206e7c47e685a05e@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 01, 2007 at 03:18:00PM +0200, Mohamed Bamakhrama wrote:

> In those two header files, flush & invalidate operations were
> implemented. Nevertheless, the MIPS32 core supports cache locking as
> well. Is there any implementations for Fetch&Lock instructions within
> the kernel?

No.  The primary use for cache locking seems to be the rather extreme
realtime requirements, a league where Linux isn't playing quite yet.
For a more general purpose OS locking has a good chance of doing more
harm than help.

  Ralf
