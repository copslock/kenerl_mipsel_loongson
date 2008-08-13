Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 14:00:23 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:1542 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S20037605AbYHMNAS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2008 14:00:18 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 971DDD8DF; Wed, 13 Aug 2008 13:00:15 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 2AF4A150670; Wed, 13 Aug 2008 15:59:55 +0300 (IDT)
Date:	Wed, 13 Aug 2008 15:59:55 +0300
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: "indy_volume_button" [sound/oss/hal2.ko] undefined
Message-ID: <20080813125954.GA3203@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

sound/oss/hal2.ko fails to build because indy_volume_button was
removed from the IP22 code.  Is sound/oss/hal2o going to be removed
before 2.6.27 is out?

-- 
Martin Michlmayr
http://www.cyrius.com/
