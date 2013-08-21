Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 18:59:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43655 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6842955Ab3HUQ7YgmhHI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 18:59:24 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r7LGxLxF016079;
        Wed, 21 Aug 2013 18:59:21 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r7LGxL5q016078;
        Wed, 21 Aug 2013 18:59:21 +0200
Date:   Wed, 21 Aug 2013 18:59:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] MIPS: Remove unreachable break statements from
 cp1emu.c
Message-ID: <20130821165920.GN2163@linux-mips.org>
References: <1376939435-19761-1-git-send-email-ddaney.cavm@gmail.com>
 <1376939435-19761-3-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1376939435-19761-3-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37632
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

On Mon, Aug 19, 2013 at 12:10:35PM -0700, David Daney wrote:

> There were many cases of:
> 
>    return something;
>    break;
> 
> All those break statements are unreachable and thus redundant.

And are generally making code harder to read.

There seems to be a school of thought which believes that any case
block should end in a break - but those seem to not yet have heared
of Duff's Device or the syntatical candy in C that makes it possible.

Patch queued for 3.12.  Thanks,

  Ralf
