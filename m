Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 11:47:03 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11235 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133489AbWDDKqx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2006 11:46:53 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k34Aw0r9011227;
	Tue, 4 Apr 2006 11:58:00 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k34AvvVa011223;
	Tue, 4 Apr 2006 11:57:57 +0100
Date:	Tue, 4 Apr 2006 11:57:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Enable SCHED_NO_NO_OMIT_FRAME_POINTER for MIPS.
Message-ID: <20060404105757.GB3142@linux-mips.org>
References: <20060404.131145.130849545.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404.131145.130849545.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 04, 2006 at 01:11:45PM +0900, Atsushi Nemoto wrote:

> MIPS get_wchan() no longer requires -fno-omit-frame-pointer.

I don't think we have have relied on the existence of a frame pointer.

Patch applied,

  Ralf
