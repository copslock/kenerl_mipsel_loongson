Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 15:48:57 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:22249 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023923AbXHCOsz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Aug 2007 15:48:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l73EmsmT022477;
	Fri, 3 Aug 2007 15:48:55 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l73EmrE9022476;
	Fri, 3 Aug 2007 15:48:53 +0100
Date:	Fri, 3 Aug 2007 15:48:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	hch@lst.de, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] Use -Werror on TX39/TX49 boards
Message-ID: <20070803144853.GA22431@linux-mips.org>
References: <20070802.233617.70476666.anemo@mba.ocn.ne.jp> <20070803132550.GA21454@lst.de> <20070803133629.GB16519@linux-mips.org> <20070803.233021.108306469.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070803.233021.108306469.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 03, 2007 at 11:30:21PM +0900, Atsushi Nemoto wrote:

> Well, I just followed recent MIPS trend ;) I don't mind if you dropped
> them again.

Ideally I'd like something that disables -Werror for -stable releases
and enables it during development releases.

  Ralf
