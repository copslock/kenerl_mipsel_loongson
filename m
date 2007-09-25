Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 19:44:14 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:20239 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20023642AbXIYSoM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 19:44:12 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id A5F20D8DD; Tue, 25 Sep 2007 18:43:35 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 812F4540C4; Tue, 25 Sep 2007 20:43:17 +0200 (CEST)
Date:	Tue, 25 Sep 2007 20:43:17 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	sknauert@wesleyan.edu
Cc:	linux-mips@linux-mips.org
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
Message-ID: <20070925184317.GB15556@deprecation.cyrius.com>
References: <20070925181353.GA15412@deprecation.cyrius.com> <57307.69.183.163.198.1190745167.squirrel@webmail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57307.69.183.163.198.1190745167.squirrel@webmail.wesleyan.edu>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* sknauert@wesleyan.edu <sknauert@wesleyan.edu> [2007-09-25 11:32]:
> > One, make sure you're doing "make vmlinux.32", and two, CONFIG_BUILD_ELF64

I should say that I'm indeed using "make vmlinux.32".  Anyway, I see
no reason why this would break, especially given that it used to work.
And if it really isn't supported anymore, make it impossible to chose
CONFIG_BUILD_ELF64 on IP32.
-- 
Martin Michlmayr
http://www.cyrius.com/
