Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 12:12:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60326 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855253AbaHSKM1lhcIj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Aug 2014 12:12:27 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7JACNdB023171;
        Tue, 19 Aug 2014 12:12:23 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7JACMR3023170;
        Tue, 19 Aug 2014 12:12:22 +0200
Date:   Tue, 19 Aug 2014 12:12:22 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     jogo@openwrt.org, zajec5@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: BCM47XX: fix reboot problem on BCM4705/BCM4785
Message-ID: <20140819101222.GC11547@linux-mips.org>
References: <1408392076-308-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1408392076-308-1-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Aug 18, 2014 at 10:01:16PM +0200, Hauke Mehrtens wrote:

> This adds some code based on code from the Broadcom GPL tar to fix the
> reboot problems on BCM4705/BCM4785. I tried rebooting my device for ~10
> times and have never seen a problem. This reverts the changes in the
> previous commit and adds the real fix as suggested by Rafał.
> 
> Setting bit 22 in Reg 22, sel 4 puts the BIU (Bus Interface Unit) into
> async mode.

I'm going to apply this - but in the future, when reverting a patch please
don't fold new changes together with the revert, rather send a revert.

Thanks,

  Ralf
