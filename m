Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 22:35:47 +0100 (CET)
Received: from ns1.pc-advies.be ([83.149.101.17]:32909 "EHLO
        spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6833254Ab3A1VfqtTEY7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jan 2013 22:35:46 +0100
Received: from wimvs by spo001.leaseweb.com with local (Exim 4.50)
        id 1TzwMi-00009M-Ke; Mon, 28 Jan 2013 22:35:44 +0100
Date:   Mon, 28 Jan 2013 22:35:44 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-watchdog@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v4 0/5] watchdog: bcm47xx_wdt.c: add support for SoCs with PMU
Message-ID: <20130128213544.GB3338@spo001.leaseweb.com>
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de> <51016C4D.40707@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51016C4D.40707@hauke-m.de>
User-Agent: Mutt/1.4.1i
X-archive-position: 35605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Hauke,

> what is the status of these patches?

First reading/checking (v4+v5) seems OK.
1 small remark allready: the settimeout functions seem to check the min and max timeout values.
Can't you use the min and max values of the watchdog structure for this?

Kind regards,
Wim.
