Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Aug 2013 19:21:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39759 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6836378Ab3HTRVhmKvl6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Aug 2013 19:21:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r7KHLYlN011606;
        Tue, 20 Aug 2013 19:21:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r7KHLWZD011605;
        Tue, 20 Aug 2013 19:21:32 +0200
Date:   Tue, 20 Aug 2013 19:21:32 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/2] MIPS: Handle OCTEON BBIT instructions in FPU
 emulator.
Message-ID: <20130820172132.GC2163@linux-mips.org>
References: <1376939435-19761-1-git-send-email-ddaney.cavm@gmail.com>
 <1376939435-19761-2-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1376939435-19761-2-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37592
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

On Mon, Aug 19, 2013 at 12:10:34PM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> The branch emulation needs to handle the OCTEON BBIT instructions,
> otherwise we get SIGILL instead of emulation.

Nice - I think there are other MIPS processors that will need the same
sort of fix but this close to 3.11 this is a good solution.  Applied.

  Ralf
