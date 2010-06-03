Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jun 2010 01:59:52 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40510 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1492043Ab0FCX7r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jun 2010 01:59:47 +0200
Received: from localhost (localhost [127.0.0.1])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTP id EC0AF11051C;
        Fri,  4 Jun 2010 00:59:39 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at opensource.wolfsonmicro.com
Received: from opensource2.wolfsonmicro.com ([127.0.0.1])
        by localhost (opensource.wolfsonmicro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8V3d+9v790an; Fri,  4 Jun 2010 00:59:39 +0100 (BST)
Received: from [10.0.1.17] (cpc3-sgyl4-0-0-cust125.sgyl.cable.virginmedia.com [82.41.240.126])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 192E3110504;
        Fri,  4 Jun 2010 00:59:39 +0100 (BST)
Subject: Re: [RFC][PATCH 20/26] alsa: ASoC: Add JZ4740 codec driver
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
In-Reply-To: <4C084155.5010503@metafoo.de> (sfid-20100604_005758_018873_5A725743)
Date:   Fri, 4 Jun 2010 00:59:38 +0100
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>,
        alsa-devel@alsa-project.org
Content-Transfer-Encoding: 7bit
Message-Id: <BBE59890-DD9C-4B62-AB74-87764381D38E@opensource.wolfsonmicro.com>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de> <1275505950-17334-4-git-send-email-lars@metafoo.de> <20100603174953.GH2762@rakim.wolfsonmicro.main> <4C084155.5010503@metafoo.de> (sfid-20100604_005758_018873_5A725743)
To:     Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: Apple Mail (2.1078)
X-archive-position: 27067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2877

On 4 Jun 2010, at 00:57, Lars-Peter Clausen wrote:

> Mark Brown wrote:
> Uhm, actually this code path is taken when switching from _OFF to
> another state. If it is guaranteed that _OFF is always followed by a
> certain other state I could put the reset code in its part of the switch
> statement.

The only possible transitions are OFF <-> STANDBY <-> PREPARE <-> ON
