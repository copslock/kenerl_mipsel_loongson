Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2015 00:00:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49543 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008002AbbFJWAtZU3ho (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Jun 2015 00:00:49 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t5AM0moc015738;
        Thu, 11 Jun 2015 00:00:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t5AM0lff015737;
        Thu, 11 Jun 2015 00:00:47 +0200
Date:   Thu, 11 Jun 2015 00:00:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH linux-next] MIPS: pci-ar71xx: Fix left over reference to
 ath79_ddr_base
Message-ID: <20150610220047.GI2753@linux-mips.org>
References: <5571B520.9040808@roeck-us.net>
 <1433970072-11790-1-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433970072-11790-1-git-send-email-albeu@free.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47927
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

On Wed, Jun 10, 2015 at 11:01:12PM +0200, Alban Bedel wrote:

> The patch 'MIPS: ath79: Improve the DDR controller interface'
> broke the PCI support as it failed to properly removed the use of the
> variable 'ath79_ddr_base'. Remove that last reference to fix the build.

Thanks, I folded this into the original patch.

  Ralf
