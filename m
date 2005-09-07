Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 14:55:50 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:21258 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225258AbVIGNzf>; Wed, 7 Sep 2005 14:55:35 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j87E2VT5012748;
	Wed, 7 Sep 2005 15:02:31 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j87E2VFq012747;
	Wed, 7 Sep 2005 15:02:31 +0100
Date:	Wed, 7 Sep 2005 15:02:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: uninitialized variable in install_sigtramp()
Message-ID: <20050907140231.GB3493@linux-mips.org>
References: <20050907.225859.108306911.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907.225859.108306911.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 07, 2005 at 10:58:59PM +0900, Atsushi Nemoto wrote:

> This is a simple fix.  Removing the 'err' variable entirely could be
> alternative fix while the return value of install_sigtramp().

Thanks, I've applied a slightly different fix.

  Ralf
