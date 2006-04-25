Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2006 09:58:45 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:44298 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133560AbWDYI6e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Apr 2006 09:58:34 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id AA37A64D3E; Tue, 25 Apr 2006 09:11:36 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id E07AA66B60; Tue, 25 Apr 2006 11:11:23 +0200 (CEST)
Date:	Tue, 25 Apr 2006 11:11:23 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Sergey Sivkov <ssp@woodland.ru>
Cc:	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: SNI RM300C with R10000
Message-ID: <20060425091123.GD7822@deprecation.cyrius.com>
References: <20060425075615.GA15261@woodland.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425075615.GA15261@woodland.ru>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Sergey Sivkov <ssp@woodland.ru> [2006-04-25 13:56]:
> I have SNI RM300C with R10000 CPU. Is there any chance i'll be able
> to start Linux on that computer?

Certainly not out of the box.  However, Ralf Baechle (the MIPS kernel
maintainer) has (or used to have) a RM200C so it might be possible to
get it going.

Ralf, what's the status of RM200C/RM300C support?
-- 
Martin Michlmayr
http://www.cyrius.com/
