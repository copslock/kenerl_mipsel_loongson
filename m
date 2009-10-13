Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 22:46:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59978 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493618AbZJMUqt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 22:46:49 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9DKm6vp012156;
	Tue, 13 Oct 2009 22:48:07 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9DKlwV7012154;
	Tue, 13 Oct 2009 22:47:58 +0200
Date:	Tue, 13 Oct 2009 22:47:58 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] ip22: remove an unused function
Message-ID: <20091013204758.GA11620@linux-mips.org>
References: <1255462621-20290-1-git-send-email-dmitri.vorobiev@movial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255462621-20290-1-git-send-email-dmitri.vorobiev@movial.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 10:37:01PM +0300, Dmitri Vorobiev wrote:

> Nobody is using the ARCS-specific prom_getcmdline(), so let's remove it.

Thanks, queued for 2.6.32.

  Ralf
