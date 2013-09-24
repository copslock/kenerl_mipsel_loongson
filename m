Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2013 14:32:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43547 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825728Ab3IXMcTyU3Mo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Sep 2013 14:32:19 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8OCWGEC027203;
        Tue, 24 Sep 2013 14:32:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8OCWCrk027195;
        Tue, 24 Sep 2013 14:32:12 +0200
Date:   Tue, 24 Sep 2013 14:32:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Daniel Walker <dwalker@fifo99.com>
Cc:     David Daney <david.daney@cavium.com>,
        Doug Thompson <dougthompson@xmission.com>,
        linux-edac@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: edac: octeon: fix lack of opstate_init
Message-ID: <20130924123212.GD21257@linux-mips.org>
References: <1379717202-26990-1-git-send-email-dwalker@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1379717202-26990-1-git-send-email-dwalker@fifo99.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37936
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

On Fri, Sep 20, 2013 at 03:46:40PM -0700, Daniel Walker wrote:

> If the opstate_init() isn't called the driver won't start properly.
> 
> I just added it in what appears to be an appropriate place.
> 
> Signed-off-by: Daniel Walker <dwalker@fifo99.com>

Makes sense.  Unfortunately :-)

Acked-by: Ralf Baechle <ralf@linux-mips.org>

EDAC folks - I can funnel this patch through my tree or leave that to you,
whatever you prefer.  Same for Daniel's other patch.

  Ralf
