Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2004 08:53:37 +0000 (GMT)
Received: from p508B6890.dip.t-dialin.net ([IPv6:::ffff:80.139.104.144]:63119
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225266AbUAIIxg>; Fri, 9 Jan 2004 08:53:36 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i098rYfY017081;
	Fri, 9 Jan 2004 09:53:34 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i098rYaT017080;
	Fri, 9 Jan 2004 09:53:34 +0100
Date: Fri, 9 Jan 2004 09:53:34 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: CONFIG_MAGIC_SYSRQ and CONFIG_DUMMY_KEYB
Message-ID: <20040109085334.GA16940@linux-mips.org>
References: <20040109.174353.26978826.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109.174353.26978826.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 09, 2004 at 05:43:53PM +0900, Atsushi Nemoto wrote:

> The 2.4 kernel could not be built with both CONFIG_MAGIC_SYSRQ and
> CONFIG_DUMMY_KEYB enabled.  This configuration should be possible
> since we can use Magic SysRq with serial driver.
> 
> Here is a patch.

Thanks, applied.

  Ralf
