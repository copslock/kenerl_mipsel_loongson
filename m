Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2009 12:47:05 +0200 (CEST)
Received: from p549F514B.dip.t-dialin.net ([84.159.81.75]:52722 "EHLO
	h5.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1492439AbZI1Kq6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Sep 2009 12:46:58 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8SAlXOJ010773;
	Mon, 28 Sep 2009 11:47:33 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8SAlS5t010771;
	Mon, 28 Sep 2009 11:47:28 +0100
Date:	Mon, 28 Sep 2009 11:47:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Huang Weiyi <weiyi.huang@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] MIPS: remove duplicated #include
Message-ID: <20090928104728.GA3571@linux-mips.org>
References: <1254021294-3832-1-git-send-email-weiyi.huang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1254021294-3832-1-git-send-email-weiyi.huang@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Sep 27, 2009 at 11:14:54AM +0800, Huang Weiyi wrote:

> Remove duplicated #include('s) in
>   arch/mips/kernel/smp.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

This is the 3rd identical patch I've received ...

Sorry & thanks anyway!

  Ralf
