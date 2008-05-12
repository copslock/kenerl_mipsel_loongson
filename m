Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 18:39:17 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:49422 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20030644AbYELRjO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 18:39:14 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 8A8DDD8E7; Mon, 12 May 2008 17:39:10 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 653B6372609; Mon, 12 May 2008 19:39:07 +0200 (CEST)
Date:	Mon, 12 May 2008 19:39:07 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: sb1-bcm91250a build error
Message-ID: <20080512173907.GA20477@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I get the following build error on sb1-bcm91250a with 2.6.26-rc1 (did
I mention that -Werror by default is a really bad idea?):

cc1: warnings being treated as errors
arch/mips/kernel/traps.c: In function ‘show_raw_backtrace’:
arch/mips/kernel/traps.c:92: warning: cast from pointer to integer of different size
make[5]: *** [arch/mips/kernel/traps.o] Error 1

-- 
Martin Michlmayr
http://www.cyrius.com/
