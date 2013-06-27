Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 13:11:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52167 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824769Ab3F0LLSOf-6f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 13:11:18 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5RBBGrQ005834;
        Thu, 27 Jun 2013 13:11:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5RBBGek005833;
        Thu, 27 Jun 2013 13:11:16 +0200
Date:   Thu, 27 Jun 2013 13:11:16 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org,
        cernekee@gmail.com
Subject: Re: [PATCH] MIPS: BMIPS: fix warnings for non BMIPS43xx builds
Message-ID: <20130627111116.GT7171@linux-mips.org>
References: <1372329915-17944-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1372329915-17944-1-git-send-email-florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37168
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

On Thu, Jun 27, 2013 at 11:45:15AM +0100, Florian Fainelli wrote:

> Commit dccfb4c4 ("MIPS: BMIPS: support booting from physical CPU other
> than 0") introduces the following warning when building for non
> BMIPS43xx builds:
> 
> arch/mips/kernel/smp-bmips.c:150:6: error: unused variable 'tpid'
> [-Werror=unused-variable]
> 
> Fix this by getting rid of this variable and directly using
> cpu_logical_map(cpu).

Sounds like the previous patch wasn't really tested - or somebody shot
himself into the foot by removing the -Werror.

Anyway, folded in.

  Ralf
