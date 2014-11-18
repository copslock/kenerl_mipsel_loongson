Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 21:48:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56992 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013904AbaKRUsaWK0b7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Nov 2014 21:48:30 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAIKmTT1027023;
        Tue, 18 Nov 2014 21:48:29 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAIKmSOZ027022;
        Tue, 18 Nov 2014 21:48:28 +0100
Date:   Tue, 18 Nov 2014 21:48:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     bin.jiang@windriver.com
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: get_user: set the parameter @x to zero on error
Message-ID: <20141118204827.GG24165@linux-mips.org>
References: <1416292496-6149-1-git-send-email-bin.jiang@windriver.com>
 <20141118112258.GQ24983@linux-mips.org>
 <20141118171947.GA22757@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118171947.GA22757@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44276
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

On Tue, Nov 18, 2014 at 06:19:48PM +0100, Ralf Baechle wrote:

FWIW, I dove into the history of this.  The issue got introduced in
4feb8f8f ([MIPS] Bullet proof uaccess.h against 4.0.1 miss-compilation.),
then backported to 2.4.

  Ralf
