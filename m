Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 18:31:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33214 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991932AbcIWQbp5Xw8g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Sep 2016 18:31:45 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8NGVimR021412;
        Fri, 23 Sep 2016 18:31:44 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8NGVifk021411;
        Fri, 23 Sep 2016 18:31:44 +0200
Date:   Fri, 23 Sep 2016 18:31:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        "stable # v4 . 0+" <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix pre-r6 emulation FPU initialisation
Message-ID: <20160923163143.GA21408@linux-mips.org>
References: <20160923141353.1596-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160923141353.1596-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55255
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

On Fri, Sep 23, 2016 at 03:13:53PM +0100, Paul Burton wrote:

Thanks, applied.

  Ralf
