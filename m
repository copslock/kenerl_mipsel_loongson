Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 14:18:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57766 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028599AbcEMMSi6MNd1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2016 14:18:38 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4DCIZRv005317;
        Fri, 13 May 2016 14:18:35 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4DCIX0t005316;
        Fri, 13 May 2016 14:18:33 +0200
Date:   Fri, 13 May 2016 14:18:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Sandeep Sheriker <sandeepsheriker.mallikarjun@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v11 0/3] PIC32MZDA Clock Driver
Message-ID: <20160513121833.GC4215@linux-mips.org>
References: <1463125961-10706-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463125961-10706-1-git-send-email-purna.mandal@microchip.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53434
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

On Fri, May 13, 2016 at 01:22:38PM +0530, Purna Chandra Mandal wrote:

Thanks for resolving the remaining issues.  As per discussion of the
last version I've now queued the entire series for 4.7.

One step closer to full PIC32MZDA in-tree support!

  Ralf
