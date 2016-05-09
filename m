Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 17:20:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33446 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028304AbcEIPUboYJoO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2016 17:20:31 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u49FKV3V031516;
        Mon, 9 May 2016 17:20:31 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u49FKUoB031515;
        Mon, 9 May 2016 17:20:30 +0200
Date:   Mon, 9 May 2016 17:20:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MAINTAINERS: change my email address
Message-ID: <20160509152030.GC28818@linux-mips.org>
References: <1462435076-48703-1-git-send-email-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462435076-48703-1-git-send-email-john@phrozen.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53314
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

On Thu, May 05, 2016 at 09:57:55AM +0200, John Crispin wrote:

> The old address is no longer valid. Use the my new one instead.

Both applied.  I take it you're going to send patches to change the remaining
files to other maintainers?  It'd probably be easier if you'd ask Linus
to run something like sed -e 's/blogic@openwrt.org/blogic@phrozen.org/'
over the tree.

  Ralf
