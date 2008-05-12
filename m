Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 14:06:31 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:13583 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20031126AbYELNG2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 14:06:28 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id D4856D8E3; Mon, 12 May 2008 13:06:25 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id E0151372609; Mon, 12 May 2008 15:06:04 +0200 (CEST)
Date:	Mon, 12 May 2008 15:06:04 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	linux-ext4@vger.kernel.org
Subject: ext4dev build failure on mips: "empty_zero_page" undefined
Message-ID: <20080512130604.GA15008@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I get the following build failure on MIPS Malta with 2.6.26-rc1:

  MODPOST 1516 modules
ERROR: "empty_zero_page" [fs/ext4/ext4dev.ko] undefined!

Any idea?  A missing export?
-- 
Martin Michlmayr
http://www.cyrius.com/
