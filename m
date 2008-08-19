Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:28:01 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:41988 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S28575212AbYHSN1y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Aug 2008 14:27:54 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id BDCEBD8D9; Tue, 19 Aug 2008 13:27:51 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 23E1015063A; Tue, 19 Aug 2008 16:27:34 +0300 (IDT)
Date:	Tue, 19 Aug 2008 16:27:34 +0300
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Compilation problem
Message-ID: <20080819132733.GQ2544@deprecation.cyrius.com>
References: <1219151811.3948.1.camel@kh-ubuntu.razamicroelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1219151811.3948.1.camel@kh-ubuntu.razamicroelectronics.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Kevin Hickey <khickey@rmicorp.com> [2008-08-19 08:16]:
> include/linux/security.h:1760: error: ‘parent’ undeclared (first use in
> this function)
> include/linux/security.h:1760: error: (Each undeclared identifier is
> reported only once
> include/linux/security.h:1760: error: for each function it appears in.)
> make[1]: *** [init/main.o] Error 1
> 
> I did a clean clone to be sure that it was not anything leftover in my
> working directory.  Is it just me?

You need this fix:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=5e186b57e7ede86aeb9db30e66315bde4e8b1815

-- 
Martin Michlmayr
http://www.cyrius.com/
