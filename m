Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 17:47:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33405 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855288AbaHSPrHklu25 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Aug 2014 17:47:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7JFl4hB029422;
        Tue, 19 Aug 2014 17:47:04 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7JFl45Y029421;
        Tue, 19 Aug 2014 17:47:04 +0200
Date:   Tue, 19 Aug 2014 17:47:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lars Persson <lars.persson@axis.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Remove race window in page fault handling
Message-ID: <20140819154704.GG11547@linux-mips.org>
References: <1407505668-18547-1-git-send-email-larper@axis.com>
 <53E500E4.5020509@gmail.com>
 <20140808204705.GH29898@linux-mips.org>
 <1408089827.15236.2.camel@lnxlarper.se.axis.com>
 <20140815110129.GB5642@linux-mips.org>
 <1408104536.19220.7.camel@lnxlarper.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408104536.19220.7.camel@lnxlarper.se.axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42147
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

On Fri, Aug 15, 2014 at 02:08:56PM +0200, Lars Persson wrote:

Btw, this patch applies with minor variations all the way back to
at least 2.6.12 and in even older kernel set_pte_at() doesn't exist
yet ...

  Ralf
