Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 15:36:41 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:15004 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22510461AbYJ0Pgg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2008 15:36:36 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9RFaZon026908;
	Mon, 27 Oct 2008 15:36:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9RFaZxt026906;
	Mon, 27 Oct 2008 15:36:35 GMT
Date:	Mon, 27 Oct 2008 15:36:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
Cc:	linux-mips@linux-mips.org, shinya.kuribayashi@necel.com
Subject: Re: [PATCH] MIPS: EMMA2RH: Fix incorrect header references
Message-ID: <20081027153635.GA23437@linux-mips.org>
References: <4900A510.3000101@ruby.dti.ne.jp> <4900A69C.7060208@ruby.dti.ne.jp> <4905D927.3050005@ruby.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4905D927.3050005@ruby.dti.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 28, 2008 at 12:07:19AM +0900, Shinya Kuribayashi wrote:

> Now we have <asm/emma/emma2rh.h> as a new EMMA2RH header place.  This
> patch will fix all of the remaining <asm/emma2rh/emma2rh.h> references.

Applied.  For kernel.org I'll fold this into the earlier patch "MIPS: EMMA:
Move <asm/emma2rh> to <asm/emma> dir" to keep things bisectable.

Thanks,

  Ralf
