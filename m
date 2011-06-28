Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2011 03:40:52 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:36880 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491956Ab1F1Bkm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Jun 2011 03:40:42 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p5S1crxG006899
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 27 Jun 2011 18:38:56 -0700
Date:   Mon, 27 Jun 2011 18:38:44 -0700 (PDT)
Message-Id: <20110627.183844.146129637361136342.davem@davemloft.net>
To:     magnus.damm@gmail.com
Cc:     ralf@linux-mips.org, eric.y.miao@gmail.com, linux@arm.linux.org.uk,
        ben-linux@fluff.org, lethal@linux-sh.org, jeff@garzik.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, netdev@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2] NET: AX88796: Tighten up Kconfig dependencies
From:   David Miller <davem@davemloft.net>
In-Reply-To: <BANLkTikDxsOJKpiJs0NpMXbjVOFMHL7RZw@mail.gmail.com>
References: <20110627111259.GA13620@linux-mips.org>
        <BANLkTikDxsOJKpiJs0NpMXbjVOFMHL7RZw@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Mon, 27 Jun 2011 18:38:58 -0700 (PDT)
X-archive-position: 30535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22442

From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Jun 2011 09:40:56 +0900

> As for SH and SH-Mobile ARM, unless explicitly requested we usually
> don't restrict our platform drivers. Allowing them to build on any
> system helps to catch compile errors.

I totally agree with Magnus, drivers should build on as many systems
as possible.  Even on those for which the hardware never appears.

Ralf, unless these drivers have unfixable build errors on MIPS I
do not want to add the new restrictions.
