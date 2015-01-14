Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2015 12:40:36 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49742 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011588AbbANLkeutTF3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jan 2015 12:40:34 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id t0EBeYed020662;
        Wed, 14 Jan 2015 12:40:34 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id t0EBeXbh020661;
        Wed, 14 Jan 2015 12:40:33 +0100
Date:   Wed, 14 Jan 2015 12:40:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Tony Wu <tung7970@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix MIPS32_COMPAT recursive dependency
Message-ID: <20150114114033.GA20617@linux-mips.org>
References: <20150113230344-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150113230344-tung7970@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45106
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

On Tue, Jan 13, 2015 at 11:05:02PM +0800, Tony Wu wrote:

I've already applied an identical fix on 3/1.

  Ralf
