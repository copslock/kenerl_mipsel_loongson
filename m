Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 18:56:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45394 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903725Ab2HNQ4O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 18:56:14 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7EGuB9L030765;
        Tue, 14 Aug 2012 18:56:11 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7EGu7Ho030757;
        Tue, 14 Aug 2012 18:56:07 +0200
Date:   Tue, 14 Aug 2012 18:56:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Alan Cox <alan@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: OCTEON: Fix breakage due to 8250 changes.
Message-ID: <20120814165607.GA29888@linux-mips.org>
References: <1344962559-6823-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344962559-6823-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34164
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

On Tue, Aug 14, 2012 at 09:42:39AM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> The changes in linux-next removing serial8250_register_port() cause
> OCTEON to fail to compile.
> 
> Lets make OCTEON use the new serial8250_register_8250_port() instead.

I think this one should go via the serial tree.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks,

  Ralf
