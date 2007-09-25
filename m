Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 19:14:52 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:45586 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20023456AbXIYSOu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 19:14:50 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6AC29D8DD; Tue, 25 Sep 2007 18:14:13 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id AA139540C4; Tue, 25 Sep 2007 20:13:53 +0200 (CEST)
Date:	Tue, 25 Sep 2007 20:13:53 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	Franck Bui-Huu <fbuihuu@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
Message-ID: <20070925181353.GA15412@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

IP32 kernels that are built with CONFIG_BUILD_ELF64=y only produce an
exception when booted.  This worked with 2.6.19 and before.  I haven't
had a chance to dig deep yet but it seems both Franck Bui-Huu and
Atsushi Nemoto had patches in 2.6.20 that might have caused this.
This still happens with 2.6.22.  I cannot boot current git for other
reasons.

If anyone has an idea which specific patch might have caused this,
please let me know.  Otherwise I'll try to find time in the next few
days to revert various patches.
-- 
Martin Michlmayr
http://www.cyrius.com/
