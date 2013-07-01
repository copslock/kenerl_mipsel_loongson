Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jul 2013 15:19:39 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35325 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6826533Ab3GANTgppt4A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Jul 2013 15:19:36 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r61DJYtA029863;
        Mon, 1 Jul 2013 15:19:35 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r61DJYsY029860;
        Mon, 1 Jul 2013 15:19:34 +0200
Date:   Mon, 1 Jul 2013 15:19:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: boot: compressed: Remove -fstack-protector from
 CFLAGS
Message-ID: <20130701131933.GD27158@linux-mips.org>
References: <1372675110-1301-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1372675110-1301-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37243
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

On Mon, Jul 01, 2013 at 11:38:30AM +0100, Markos Chandras wrote:

I've inserted this patch before the patch that actually adds the stack
protector.

Thanks,

  Ralf
