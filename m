Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 11:34:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51317 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493483AbZJOJeF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Oct 2009 11:34:05 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9F7ePJ7014208;
	Thu, 15 Oct 2009 09:45:45 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9F7eOOX014206;
	Thu, 15 Oct 2009 09:40:24 +0200
Date:	Thu, 15 Oct 2009 09:40:24 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: zboot: make the vmlinuz be fresh all the time
Message-ID: <20091015074024.GA12835@linux-mips.org>
References: <1255518712-14666-1-git-send-email-wuzhangjin@gmail.com> <20091014114403.GA28514@linux-mips.org> <1255586019.11221.5.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255586019.11221.5.camel@falcon>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 15, 2009 at 01:53:39PM +0800, Wu Zhangjin wrote:

> I have updated my git repository to your master branch, and plan to push
> the basic support of fuloong2f to you and also the linux-mips mailing
> list, is it okay? any suggestion?

Sure, go ahead.  It would be appreciated if you would rebase your code
to the queue branch of linux-queue.git for submission; this will
minimize merge conflicts.

  Ralf
