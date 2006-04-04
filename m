Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 13:12:07 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:28299 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133534AbWDDMLo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2006 13:11:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k34CMqx9016156;
	Tue, 4 Apr 2006 13:22:52 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k34CMqph016155;
	Tue, 4 Apr 2006 13:22:52 +0100
Date:	Tue, 4 Apr 2006 13:22:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] tx49_blast_icache32_page_indexed fix
Message-ID: <20060404122252.GD13203@linux-mips.org>
References: <20060404.173414.108982133.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404.173414.108982133.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 04, 2006 at 05:34:14PM +0900, Atsushi Nemoto wrote:

> Fix an index value in tx49_blast_icache32_page_indexed().
> This is a damage by 13acfa3fdef15edaa4f5444c68e28e05978afa08 commit.

Applied on master and linux-2.6.16-stable.

  Ralf
