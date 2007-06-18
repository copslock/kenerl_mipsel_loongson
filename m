Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 17:09:23 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52440 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023268AbXFRQJV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Jun 2007 17:09:21 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5IG1squ023987;
	Mon, 18 Jun 2007 17:02:00 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5IG1s89023986;
	Mon, 18 Jun 2007 17:01:54 +0100
Date:	Mon, 18 Jun 2007 17:01:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
Message-ID: <20070618160154.GA16133@linux-mips.org>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> <11818164024053-git-send-email-fbuihuu@gmail.com> <20070614.212913.82089068.nemoto@toshiba-tops.co.jp> <20070617000448.GA30807@linux-mips.org> <cda58cb80706180722n18e79a49vfa61450526e6af76@mail.gmail.com> <20070618151422.GA4864@linux-mips.org> <cda58cb80706180838t4b51c3e4v1392ab4c76773d43@mail.gmail.com> <cda58cb80706180855k5eaa732aufc937980acf7d037@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706180855k5eaa732aufc937980acf7d037@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 18, 2007 at 05:55:28PM +0200, Franck Bui-Huu wrote:

> and burn all the genrtc platform methods ?

Yes, that was my plan.

  Ralf
