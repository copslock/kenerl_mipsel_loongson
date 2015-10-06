Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 13:34:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46303 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009647AbbJFLeYL0fFb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Oct 2015 13:34:24 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t96BYNDD026461;
        Tue, 6 Oct 2015 13:34:23 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t96BYNvD026460;
        Tue, 6 Oct 2015 13:34:23 +0200
Date:   Tue, 6 Oct 2015 13:34:19 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: jz4740: Use PWM lookup table
Message-ID: <20151006113419.GC26251@linux-mips.org>
References: <1444044677-11518-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1444044677-11518-1-git-send-email-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49447
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

On Mon, Oct 05, 2015 at 01:31:17PM +0200, Thierry Reding wrote:

> Associate the PWM with the pwm-beeper device using a PWM lookup table.
> This will eventually allow the legacy function calls to pwm_request() to
> be removed from all consumer drivers.

This one applied with fuzz only, probably because I was using the other
fix for the gpio issue.

Thanks,

  Ralf
