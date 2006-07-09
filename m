Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2006 18:58:58 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:37905 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133862AbWGIR6r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Jul 2006 18:58:47 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E347664D55; Sun,  9 Jul 2006 17:58:39 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 5A30666E52; Sun,  9 Jul 2006 19:58:41 +0200 (CEST)
Date:	Sun, 9 Jul 2006 19:58:41 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Julien BLACHE <jblache@debian.org>
Cc:	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: [PATCH] IP22: fix serial console hangs
Message-ID: <20060709175841.GB24958@deprecation.cyrius.com>
References: <87irm6naxt.fsf@frigate.technologeek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87irm6naxt.fsf@frigate.technologeek.org>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Julien BLACHE <jblache@debian.org> [2006-07-09 15:51]:
> The patch below fixes serial console hangs as seen on IP22
> machines. Typically, while booting, the machine hangs for ~1 minute

Thanks for tracking this down.  You've to send the patch to
rmk+serial@arm.linux.org.uk and linux-serial@vger.kernel.org
though.
-- 
Martin Michlmayr
http://www.cyrius.com/
