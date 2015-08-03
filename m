Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 20:23:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37244 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012183AbbHCSXlvq9TT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 20:23:41 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t73INcIH011328;
        Mon, 3 Aug 2015 20:23:38 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t73INaGG011327;
        Mon, 3 Aug 2015 20:23:36 +0200
Date:   Mon, 3 Aug 2015 20:23:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] MIPS: ath79: Add the reset controller to the AR9132
 dtsi
Message-ID: <20150803182336.GH2843@linux-mips.org>
References: <1438622633-9407-1-git-send-email-albeu@free.fr>
 <1438622633-9407-4-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438622633-9407-4-git-send-email-albeu@free.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48557
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

On Mon, Aug 03, 2015 at 07:23:53PM +0200, Alban Bedel wrote:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Philipp,

Feel free to take this through the reset tree.  Or I can carry this in
the MIPS tree which is probably better for testing.  Just lemme know.

  Ralf
