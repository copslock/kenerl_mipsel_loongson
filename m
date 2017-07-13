Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2017 13:49:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37328 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991797AbdGMLtWUWyRl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jul 2017 13:49:22 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v6DBnHSu028703;
        Thu, 13 Jul 2017 13:49:17 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v6DBnGR8028702;
        Thu, 13 Jul 2017 13:49:16 +0200
Date:   Thu, 13 Jul 2017 13:49:16 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 01/18] clk: ingenic: Use const pointer to clk_ops in
 struct
Message-ID: <20170713114916.GA17495@linux-mips.org>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170702163016.6714-1-paul@crapouillou.net>
 <20170702163016.6714-2-paul@crapouillou.net>
 <20170712232037.GR22780@codeaurora.org>
 <ca4da3fa3067a7301f8fc1539e9e4362@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca4da3fa3067a7301f8fc1539e9e4362@crapouillou.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59105
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

On Thu, Jul 13, 2017 at 12:07:25PM +0200, Paul Cercueil wrote:

> > Sorry I forgot, did you want an ack for these clk patches or for
> > me to take them through clk tree. If it's the ack case,
> > 
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > for patches 1 through 6.
> 
> I think ACK; then Ralf can take them in 4.13 :)

My pull request for 4.13 is already finalized so it'd be great if this
could make it to 4.13 through the clk tree.  If that should be impossible
I'd like to merge this via the MIPS tree for 4.14.

Thanks,

  Ralf
