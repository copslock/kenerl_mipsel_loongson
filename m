Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 15:41:36 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:1550 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S3465572AbWAWPlS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 15:41:18 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 8BAF064D3D; Mon, 23 Jan 2006 15:45:26 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 8799086BB; Mon, 23 Jan 2006 15:45:15 +0000 (GMT)
Date:	Mon, 23 Jan 2006 15:45:15 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"P. Christeas" <p_christ@hol.gr>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
Message-ID: <20060123154515.GB10742@deprecation.cyrius.com>
References: <20060123150507.GA18665@linux-mips.org> <200601231718.40581.p_christ@hol.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601231718.40581.p_christ@hol.gr>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* P. Christeas <p_christ@hol.gr> [2006-01-23 17:18]:
> > I'd appreciate if somebody with gcc 4.0.1 could test this kernel patch
> > below.
> Is that for 2.4? 
> 2.6 doesn't seem to have that problem..

2.6.  You get the problem when you build a 64-bit kernel with the
32-bit COMPAT stuff turned on.  See
http://www.linux-mips.org/archives/linux-mips/2006-01/msg00199.html
-- 
Martin Michlmayr
http://www.cyrius.com/
