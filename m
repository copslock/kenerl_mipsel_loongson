Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2009 16:12:45 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64231 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20026927AbZDFPMj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2009 16:12:39 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n36FCaam020377;
	Mon, 6 Apr 2009 17:12:37 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n36FCXkm020362;
	Mon, 6 Apr 2009 17:12:33 +0200
Date:	Mon, 6 Apr 2009 17:12:33 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org,
	"Kevin D. Kissell" <kevink@paralogos.com>
Subject: Re: [PATCH] Fix build error if CONFIG_CEVT_R4K was not defined
Message-ID: <20090406151233.GA16069@linux-mips.org>
References: <1239030295-14080-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1239030295-14080-1-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 07, 2009 at 12:04:55AM +0900, Atsushi Nemoto wrote:

> This patch fixes build error introduced by "MIPS: SMTC:
> Fix xxx_clockevent_init() naming conflict for SMT".

I've already commited an identical patch last night.

Luckily modern gcc throws an error for this sort of issue; in the past it
used to be subtle breakage ...

  Ralf
