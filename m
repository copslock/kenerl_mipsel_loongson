Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 19:21:23 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15809 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030070AbXLCTVV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Dec 2007 19:21:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB3JKEZD015088;
	Mon, 3 Dec 2007 19:20:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB3JKAdu015087;
	Mon, 3 Dec 2007 19:20:10 GMT
Date:	Mon, 3 Dec 2007 19:20:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Sharp <andy.sharp@onstor.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add code to determine the L2 cache size on Sibyte
	1250/112x processors.
Message-ID: <20071203192010.GA14818@linux-mips.org>
References: <20071203175601.GA26533@onstor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071203175601.GA26533@onstor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 03, 2007 at 09:56:11AM -0800, Andrew Sharp wrote:

>  arch/mips/mm/c-sb1.c                 |   70 ++++++++++++++++++++++++++++++++++

c-sb1.c does no longer exist.  The functionality was folded into c-r4k.c
and at the same time alot of insanity aka pass 1 workarounds dropped.

  Ralf
