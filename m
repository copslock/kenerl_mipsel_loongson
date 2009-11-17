Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 14:44:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38544 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493026AbZKQNoH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Nov 2009 14:44:07 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAHDiEkP018254;
	Tue, 17 Nov 2009 14:44:14 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAHDiD7g018252;
	Tue, 17 Nov 2009 14:44:13 +0100
Date:	Tue, 17 Nov 2009 14:44:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Add Lemote NAS and Lynloong support
Message-ID: <20091117134413.GA27085@linux-mips.org>
References: <cover.1258390323.git.wuzhangjin@gmail.com> <20091116170111.GC14948@linux-mips.org> <1258391389.15821.18.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1258391389.15821.18.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 01:09:49AM +0800, Wu Zhangjin wrote:

> > What driver patches you got pending?
> 
> the CPUFreq driver for loongson2f and the platform drivers for
> yeeloong2f netbook and lynloong pc.

The CPU frequency scaling patches I applied.

> is the time enough to upstream them? and again, where should I put the

Well, we should come to an end.

> platform drivers in(I have incorporated with your feedbacks)? in
> arch/mips or drivers/platform/mips ?

I think in arch/mips/loongson/ is probably the best place.

  Ralf
