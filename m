Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 10:25:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45535 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6860907Ab3IQIZxoUIcQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 10:25:53 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8H8PmhU022538;
        Tue, 17 Sep 2013 10:25:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8H8Pl2o022537;
        Tue, 17 Sep 2013 10:25:47 +0200
Date:   Tue, 17 Sep 2013 10:25:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Reduce code size for MIPS32R2 platforms.
Message-ID: <20130917082547.GA22468@linux-mips.org>
References: <1354857289-28828-1-git-send-email-sjhill@mips.com>
 <20121207150946.GA27226@linux-mips.org>
 <20130627155816.GF10727@linux-mips.org>
 <51CC63E1.3080407@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51CC63E1.3080407@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37824
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

Here's another, hopefully final iteration of this patch.  I now have
another patch, the fix for the get_cycles() issue that depends on this
so would like to push this into 2.12, if still possible.

  Ralf
