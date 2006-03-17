Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 16:47:33 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:4358 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133525AbWCQQrX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2006 16:47:23 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id D0EFB64D3D; Fri, 17 Mar 2006 16:56:44 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 76C8B66ED5; Fri, 17 Mar 2006 16:56:29 +0000 (GMT)
Date:	Fri, 17 Mar 2006 16:56:29 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: 1480: "bad address" instead of "argument list too"
Message-ID: <20060317165629.GX18750@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I get the following in a directory which has many files in it on a
Braodcom 1480:

2179:tbm@bigsur: ~/build/logs] grep foo *
zsh: bad address: grep

Normally, I'd expect an "zsh: argument list too long: grep" error.

I get this with different shells.  Hmm, that's interesting.  "echo *"
works.  I assume shell built-in commands work but others don't.

Any idea?
-- 
Martin Michlmayr
http://www.cyrius.com/
