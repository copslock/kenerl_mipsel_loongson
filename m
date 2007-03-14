Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2007 17:58:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:47798 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022454AbXCNR6K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Mar 2007 17:58:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2EHuH4W017822;
	Wed, 14 Mar 2007 17:56:17 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2EHu8qx017821;
	Wed, 14 Mar 2007 17:56:08 GMT
Date:	Wed, 14 Mar 2007 17:56:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Peter Watkins <pwatkins@sicortex.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Have sigpoll and sigio band field match glibc for n64
Message-ID: <20070314175608.GC14430@linux-mips.org>
References: <1173469586997-git-send-email-pwatkins@sicortex.com> <20070310132423.GA1295@linux-mips.org> <20070313141951.GA3206@caradoc.them.org> <20070313164107.GA5004@linux-mips.org> <20070314174854.GA23917@caradoc.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070314174854.GA23917@caradoc.them.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 14, 2007 at 01:48:54PM -0400, Daniel Jacobowitz wrote:

> I won't have time any time soon - my MIPS board isn't hooked up.
> If no one has by the time I get around to it next, though, I'll try.

Oh well, it's reasonably straight forward, so I guess I can try to fix
that but I don't have an N32 setup for testing ...

  Ralf
