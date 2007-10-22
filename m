Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 13:06:58 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:55277 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023260AbXJVMGz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Oct 2007 13:06:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9MC5aQX030718;
	Mon, 22 Oct 2007 13:05:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9M9Vdwe005612;
	Mon, 22 Oct 2007 10:31:39 +0100
Date:	Mon, 22 Oct 2007 10:31:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, Thiemo Seufer <ths@networkno.de>
Subject: Re: [PATCH] Make c0_compare_int_usable more bullet proof
Message-ID: <20071022093139.GA5588@linux-mips.org>
References: <20071020.005445.75183929.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071020.005445.75183929.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 20, 2007 at 12:54:45AM +0900, Atsushi Nemoto wrote:

> Use write_c0_compare(read_c0_count()) to clear interrupt.
> And use delta value based on its speed for faster probing.

Hmm...  This one makes c0_compare_int_usable() fails when I run a malta
kernel on last week's qemu.

  Ralf
