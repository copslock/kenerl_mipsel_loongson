Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 12:54:15 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57759 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827486Ab3CLLyOmGB7k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Mar 2013 12:54:14 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r2CB7KjJ006531;
        Tue, 12 Mar 2013 12:07:20 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r2CB7Ifn006530;
        Tue, 12 Mar 2013 12:07:18 +0100
Date:   Tue, 12 Mar 2013 12:07:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        Jim Quinlan <jim2101024@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix logic errors in bitops.c
Message-ID: <20130312110718.GA6203@linux-mips.org>
References: <1361918123-19404-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1361918123-19404-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35875
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Feb 26, 2013 at 02:35:23PM -0800, David Daney wrote:

Applied.

-stable folks - this patch should be applied to 3.7-stable and 3.8-stable.

Thanks,

  Ralf
