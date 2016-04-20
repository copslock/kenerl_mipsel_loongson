Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 15:33:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34760 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27027141AbcDTNdPPmETF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Apr 2016 15:33:15 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u3KDXCTP031425;
        Wed, 20 Apr 2016 15:33:12 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u3KDXAds031424;
        Wed, 20 Apr 2016 15:33:10 +0200
Date:   Wed, 20 Apr 2016 15:33:10 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     minyard@acm.org, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] mips: Fix crash registers on non-crashing CPUs
Message-ID: <20160420133310.GH24051@linux-mips.org>
References: <1460383819-5213-1-git-send-email-minyard@acm.org>
 <57178326.1090801@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57178326.1090801@mvista.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53122
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

On Wed, Apr 20, 2016 at 08:24:54AM -0500, Corey Minyard wrote:

> Anything on this?

Applied a few days ago and waiting to be pulled by Linus.

  Ralf
