Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2009 21:15:54 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:6894 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20643874AbZBDVPw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2009 21:15:52 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n14LFoPD013931;
	Wed, 4 Feb 2009 21:15:50 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n14LFnPO013929;
	Wed, 4 Feb 2009 21:15:49 GMT
Date:	Wed, 4 Feb 2009 21:15:49 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Roel Kluin <roel.kluin@gmail.com>
Cc:	mano@roarinelk.homelinux.net, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: in plat_time_init() t reaches -1, tested: 0
Message-ID: <20090204211549.GA13138@linux-mips.org>
References: <498434B6.5020409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498434B6.5020409@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 31, 2009 at 12:23:34PM +0100, Roel Kluin wrote:

> With a postfix decrement t reaches -1 rather than 0,
> so the fall-back will not occur.

Thanks, applied.

  Ralf
