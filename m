Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 15:25:45 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:35801 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038537AbWIYOZn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Sep 2006 15:25:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8PEQUqa023451;
	Mon, 25 Sep 2006 15:26:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8PEQUVm023450;
	Mon, 25 Sep 2006 15:26:30 +0100
Date:	Mon, 25 Sep 2006 15:26:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] fixed mtc0_tlbw_hazard
Message-ID: <20060925142630.GE20048@linux-mips.org>
References: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp> <4512BC2A.6040003@dev.rtsoft.ru> <20060922014142.2a1985c1.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922014142.2a1985c1.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 22, 2006 at 01:41:42AM +0900, Yoichi Yuasa wrote:

> previous mtc0_tlbw_hazard() for C used nop.
> "b . + 8" is trick for R4000/R4400, see comment in old hazard.h .

The trick actually requires to have the tlbw in the branch delay slot,
so was broken for the C version anyway.

  Ralf
