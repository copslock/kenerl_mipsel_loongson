Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 16:08:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54977 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133621AbWEJOIf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 16:08:35 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4AE8XjX010166;
	Wed, 10 May 2006 15:08:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4AE8Vxu010165;
	Wed, 10 May 2006 15:08:31 +0100
Date:	Wed, 10 May 2006 15:08:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Thiemo Seufer <ths@networkno.de>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] use generic DWARF_DEBUG
Message-ID: <20060510140831.GC8063@linux-mips.org>
References: <20060510.153604.82350680.nemoto@toshiba-tops.co.jp> <20060510071937.GA7813@networkno.de> <20060510125042.GA2666@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510125042.GA2666@nevyn.them.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 10, 2006 at 08:50:42AM -0400, Daniel Jacobowitz wrote:

> Shouldn't affect this.  What Atsushi is deleting are sections for DWARF
> _1_, not DWARF _2_; that's ancient history.  I don't know why they need
> to be listed at all, though; I've never had a problem, and orphan
> placement ought to take care of it.

I think this goes back to this file being derived from one of the
binutils generated ld scripts.

  Ralf
