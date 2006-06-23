Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 11:33:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:47584 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133627AbWFWKdn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2006 11:33:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5NAXhIS006365;
	Fri, 23 Jun 2006 11:33:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5NAXhKT006364;
	Fri, 23 Jun 2006 11:33:43 +0100
Date:	Fri, 23 Jun 2006 11:33:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Domen Puncer <domen.puncer@ultra.si>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch 5/8] au1xxx: export dbdma functions
Message-ID: <20060623103343.GE5896@linux-mips.org>
References: <20060623095703.GA30980@domen.ultra.si> <20060623100021.GE31017@domen.ultra.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623100021.GE31017@domen.ultra.si>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 23, 2006 at 12:00:21PM +0200, Domen Puncer wrote:

> These are needed for au1550_ac97 module.
> 
> Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

Will apply but change that to EXPORT_SYMBOL_GPL.

  Ralf
