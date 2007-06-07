Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 16:07:52 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:12960 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027230AbXFGPHu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 16:07:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l57F2pGe023981;
	Thu, 7 Jun 2007 16:02:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l57F2o9P023980;
	Thu, 7 Jun 2007 16:02:50 +0100
Date:	Thu, 7 Jun 2007 16:02:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time
	crapectomy
Message-ID: <20070607150250.GE26047@linux-mips.org>
References: <20070606185450.GA10511@linux-mips.org> <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com> <20070607113032.GA26047@linux-mips.org> <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 07, 2007 at 03:11:48PM +0200, Franck Bui-Huu wrote:

> >In theory the patch should be in -mm to be merged early just after .22.

My bad, I meant -rt - which I'm not following.  Realtime is one step
further than I want to look ahead right now.

  Ralf
