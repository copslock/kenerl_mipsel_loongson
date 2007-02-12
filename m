Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 15:05:49 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:62668 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038853AbXBLPFr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Feb 2007 15:05:47 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1CE50E9009772;
	Mon, 12 Feb 2007 14:07:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1CE4xUl009769;
	Mon, 12 Feb 2007 14:04:59 GMT
Date:	Mon, 12 Feb 2007 14:04:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Franck Bui-Huu <fbuihuu@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] signal.c: fix gcc warning on 32 bits kernel
Message-ID: <20070212140459.GA9679@linux-mips.org>
References: <1171033658561-git-send-email-fbuihuu@gmail.com> <11710336591652-git-send-email-fbuihuu@gmail.com> <20070210.011835.08318488.anemo@mba.ocn.ne.jp> <61ec3ea90702090834k774bf18bwf7ec5f7b10349779@mail.gmail.com> <20070209210014.GA26939@linux-mips.org> <cda58cb80702120101k770e059end43579394206b9d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80702120101k770e059end43579394206b9d2@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 12, 2007 at 10:01:18AM +0100, Franck Bui-Huu wrote:

> How about this instead ?

Won't work for a pointer to some const thing.

  Ralf
