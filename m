Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 13:45:33 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:29194 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3465586AbWAQNpO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 13:45:14 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 8CC7664D54; Tue, 17 Jan 2006 13:48:50 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id C2305854A; Tue, 17 Jan 2006 13:48:38 +0000 (GMT)
Date:	Tue, 17 Jan 2006 13:48:38 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: undefined reference to `__lshrdi3' error with GCC 4.0
Message-ID: <20060117134838.GJ27047@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Has anyone else seen the following error when compiling a kernel with GCC 4.0
(GCC 3.3 works) and knows what to do about it?

arch/mips/kernel/built-in.o: In function `time_init':
: undefined reference to `__lshrdi3'
arch/mips/kernel/built-in.o: In function `time_init':
: relocation truncated to fit: R_MIPS_26 against `__lshrdi3'

This problem is also reported at
http://sources.redhat.com/ml/crossgcc/2005-11/msg00194.html but no solution is
mentioned.
-- 
Martin Michlmayr
http://www.cyrius.com/
