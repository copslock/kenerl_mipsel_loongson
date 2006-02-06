Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 15:13:01 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:23053 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3458487AbWBFPMv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Feb 2006 15:12:51 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 692DC64D3D; Mon,  6 Feb 2006 15:18:18 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id B0A1E8D2D; Mon,  6 Feb 2006 15:17:54 +0000 (GMT)
Date:	Mon, 6 Feb 2006 15:17:54 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Has anyone seen O2 crashes?
Message-ID: <20060206151754.GA22181@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I got a report that Debian's experimental 2.6.15 mips patches
(2.6.15.2 plus linux-mips git from a few weeks ago plus random
patches) sometimes crashes, posibly under high load - there's
nothing on the serial console.

I was just wondering if anyone else (in particular the Gentoo folks)
has seem something similar, or is O2 rock solid for you?
-- 
Martin Michlmayr
http://www.cyrius.com/
