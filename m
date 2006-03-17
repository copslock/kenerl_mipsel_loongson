Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 17:12:36 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:19206 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133540AbWCQRM0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Mar 2006 17:12:26 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 4A9DF64D3D; Fri, 17 Mar 2006 17:21:49 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id E3A4166ED5; Fri, 17 Mar 2006 17:21:27 +0000 (GMT)
Date:	Fri, 17 Mar 2006 17:21:27 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 1480: "bad address" instead of "argument list too"
Message-ID: <20060317172127.GZ18750@deprecation.cyrius.com>
References: <20060317165629.GX18750@deprecation.cyrius.com> <20060317170242.GA13850@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317170242.GA13850@linux-mips.org>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2006-03-17 17:02]:
> Chances are this is caused by the return value of some syscall.  Can you
> use strace on a shell to isolate it?

I tried, but I don't know how.  "strace echo *" immediately gives a
"bad address" because the wildcard is evaluated before strace is
invoked.  How can I call strace in this case?

> Is this 32-bit software on a 64-bit kernel?

Yes.
-- 
Martin Michlmayr
http://www.cyrius.com/
