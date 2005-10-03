Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2005 11:41:15 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:23065 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133451AbVJCKkz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Oct 2005 11:40:55 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j93AenFS009984;
	Mon, 3 Oct 2005 11:40:49 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j93Ael1O009983;
	Mon, 3 Oct 2005 11:40:47 +0100
Date:	Mon, 3 Oct 2005 11:40:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix some sparse warnings
Message-ID: <20051003104047.GB2624@linux-mips.org>
References: <20051003.011637.41198806.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003.011637.41198806.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 03, 2005 at 01:16:37AM +0900, Atsushi Nemoto wrote:

> Make memcpy_fromio etc. more sparse-friendly.
> Remove duplicate __user annotation from __copy_to_user.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, applied.

  Ralf
