Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2006 05:58:01 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:778 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133408AbWCIF5s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Mar 2006 05:57:48 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9EC6F64D3D; Thu,  9 Mar 2006 06:06:21 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id DE41266EA8; Thu,  9 Mar 2006 06:06:06 +0000 (GMT)
Date:	Thu, 9 Mar 2006 06:06:06 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: 1480: ethernet stops working, box okay
Message-ID: <20060309060606.GA16963@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I just thought that my 1480 box had crashed, but as it turns out I
could still issue commands on the serial console - however, the
network wasn't working anymore.  There was nothing in dmesg and
bringing the interface down and up again didn't help.  I've seen this
twice now while compiling lots of stuff in parallel.

Has anyone else seen this?
-- 
Martin Michlmayr
http://www.cyrius.com/
