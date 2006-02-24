Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 00:33:01 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:58385 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133741AbWBXAcv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Feb 2006 00:32:51 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5A48164D3D; Fri, 24 Feb 2006 00:40:00 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id A79018DC5; Fri, 24 Feb 2006 00:39:47 +0000 (GMT)
Date:	Fri, 24 Feb 2006 00:39:47 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Russell King <rmk@arm.linux.org.uk>
Cc:	linux-mips@linux-mips.org, jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060224003947.GJ9704@deprecation.cyrius.com>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060223221350.GA5239@deprecation.cyrius.com> <20060223224346.GA7536@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223224346.GA7536@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Russell King <rmk@arm.linux.org.uk> [2006-02-23 22:43]:
> Looking at the ip22 driver, it seems that if shutdown() is called for
> the console port, the driver does _nothing_.

sunzilog.c does the same, and it's based on a comment by you (quoted
right before shutdown()).  Anyway, I don't quite understand the
comment but maybe Ralf (or you) can write a patch.
-- 
Martin Michlmayr
http://www.cyrius.com/
