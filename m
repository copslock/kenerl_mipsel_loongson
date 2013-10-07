Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 14:49:06 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34451 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6868729Ab3JGMtEqzfoz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 14:49:04 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r97Cn1Jb001710;
        Mon, 7 Oct 2013 14:49:01 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r97Cmxho001709;
        Mon, 7 Oct 2013 14:48:59 +0200
Date:   Mon, 7 Oct 2013 14:48:59 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Gregory Fong <gregory.0xf0@gmail.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: stack protector: Fix per-task canary switch
Message-ID: <20131007124859.GF3098@linux-mips.org>
References: <1381144466-19736-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381144466-19736-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38220
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

On Mon, Oct 07, 2013 at 12:14:26PM +0100, James Hogan wrote:

> Ralf: This is a regression in v3.11, so please consider for v3.12.

Applied, will send to Linus with the next pull request.

stable folks - please apply to 3.12-stable.

Thanks!

  Ralf
