Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 12:31:06 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:50816 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133729AbWDXL3d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2006 12:29:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k3OBgZBR006517;
	Mon, 24 Apr 2006 12:42:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k3O9oXr6003452;
	Mon, 24 Apr 2006 10:50:33 +0100
Date:	Mon, 24 Apr 2006 10:50:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix oprofile module unloading
Message-ID: <20060424095032.GA3194@linux-mips.org>
References: <20060421.233511.82352266.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421.233511.82352266.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 21, 2006 at 11:35:11PM +0900, Atsushi Nemoto wrote:

> When unloading oprofile module with timer-mode, oprofile_arch_exit
> dereferences a NULL pointer.  This patch fixes it and also fix a
> sparse warning.

Applied,

  Ralf
