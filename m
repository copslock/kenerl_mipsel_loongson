Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2007 16:34:02 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:30984 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S28578833AbXK3Qdy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Nov 2007 16:33:54 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 843CFD8E7; Fri, 30 Nov 2007 16:33:15 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 8F93A544F2; Fri, 30 Nov 2007 17:32:58 +0100 (CET)
Date:	Fri, 30 Nov 2007 17:32:58 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org, Richard Purdie <rpurdie@rpsys.net>
Subject: CONFIG_LEDS_COBALT_RAQ not as module
Message-ID: <20071130163258.GA10006@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Hi Yoichi,

Is there are good reason why LEDS_COBALT_QUBE is a tristate while
LEDS_COBALT_RAQ is a bool?  I don't see why the RAQ LED driver
couldn't be modular.
-- 
Martin Michlmayr
http://www.cyrius.com/
