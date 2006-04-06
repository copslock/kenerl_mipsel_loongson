Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2006 18:51:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:22953 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133539AbWDFRv2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2006 18:51:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k36I2mKQ021296;
	Thu, 6 Apr 2006 19:02:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k36I2l5p021295;
	Thu, 6 Apr 2006 19:02:47 +0100
Date:	Thu, 6 Apr 2006 19:02:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] use CONFIG_HZ
Message-ID: <20060406180247.GA20449@linux-mips.org>
References: <20060407.011000.77652835.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407.011000.77652835.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 07, 2006 at 01:10:00AM +0900, Atsushi Nemoto wrote:

> Make HZ configurable (except for DECSTATION which is using special HZ
> value which is out of choice).  Also remove some param.h files and
> update all defconfigs according to current HZ value (except for JAZZ
> which does not have defconfig).

Looking good except for Jazz which because it currently isn't using the
count/compare timer is limited to 100Hz only.

  Ralf
