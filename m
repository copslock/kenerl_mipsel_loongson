Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:56:32 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:45125 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007846AbbK3Q42JByZe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:56:28 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 47B721F9; Mon, 30 Nov 2015 17:56:21 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 141BB1F0;
        Mon, 30 Nov 2015 17:56:21 +0100 (CET)
Date:   Mon, 30 Nov 2015 17:56:21 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Paul Burton <paul.burton@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-mips@linux-mips.org, rtc-linux@googlegroups.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/28] rtc: m41t80: add devicetree probe support
Message-ID: <20151130165621.GG22136@piout.net>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-17-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448900513-20856-17-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Hi,

On 30/11/2015 at 16:21:41 +0000, Paul Burton wrote :
> Allow the m41t80 RTC driver to be probed via devicetree.
> 

This patch is probably unnecessary as "m41t81s" is already part of
m41t80_id[] and will be matched with "st,m41t81s" by the i2c core. See
http://lxr.free-electrons.com/source/drivers/i2c/i2c-core.c#L700

I actually don't know how to get people to stop submitting that kind of
patches :)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
