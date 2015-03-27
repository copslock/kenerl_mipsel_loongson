Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2015 10:35:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34970 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014055AbbC0Jf1hDg2Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Mar 2015 10:35:27 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2R9ZQTD004030;
        Fri, 27 Mar 2015 10:35:26 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2R9ZLen004029;
        Fri, 27 Mar 2015 10:35:21 +0100
Date:   Fri, 27 Mar 2015 10:35:21 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Michael Opdenacker <michael.opdenacker@free-electrons.com>
Cc:     chenhc@lemote.com, taohl@lemote.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Loongson-3: remove deprecated IRQF_DISABLED
Message-ID: <20150327093521.GA3959@linux-mips.org>
References: <1427420021-27663-1-git-send-email-michael.opdenacker@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427420021-27663-1-git-send-email-michael.opdenacker@free-electrons.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46564
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

On Thu, Mar 26, 2015 at 06:33:41PM -0700, Michael Opdenacker wrote:

> This removes the use of the IRQF_DISABLED flag
> from arch/mips/loongson/loongson-3/hpet.c
> 
> It's a NOOP since 2.6.35.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

An equivalent patch has been merged into linux-next as d8bf368d0631 (genirq:
Remove the deprecated 'IRQF_DISABLED' request_irq() flag entirely).

  Ralf
