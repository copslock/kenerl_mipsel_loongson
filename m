Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2015 19:21:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60781 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009295AbbJBRVQx3uBR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Oct 2015 19:21:16 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t92HL8kZ013409;
        Fri, 2 Oct 2015 19:21:08 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t92HL4Tg013408;
        Fri, 2 Oct 2015 19:21:04 +0200
Date:   Fri, 2 Oct 2015 19:21:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Matt Bennett <matt.bennett@alliedtelesis.co.nz>,
        linux-mips@linux-mips.org, aleksey.makarov@auriga.com,
        david.daney@cavium.com
Subject: Re: [PATCH] MIPS: Octeon: Fix kernel panic on startup from memory
 corruption
Message-ID: <20151002172101.GH14601@linux-mips.org>
References: <1443588042-21496-1-git-send-email-matt.bennett@alliedtelesis.co.nz>
 <560EB67E.4070401@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560EB67E.4070401@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49415
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

On Fri, Oct 02, 2015 at 09:53:18AM -0700, David Daney wrote:

> Acked-by: David Daney <david.daney@cavium.com>

Thanks, applied.

> It is probably suitable for stable as well.

Will deal with that later tonight.

  Ralf
