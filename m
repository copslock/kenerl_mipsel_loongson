Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2013 18:24:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59330 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827343Ab3ICQYINn6eP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Sep 2013 18:24:08 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r83GO5Qo018714;
        Tue, 3 Sep 2013 18:24:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r83GO4BP018713;
        Tue, 3 Sep 2013 18:24:04 +0200
Date:   Tue, 3 Sep 2013 18:24:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Octeon: Move declaration of 'fixup_irqs' to common
 header.
Message-ID: <20130903162404.GA18566@linux-mips.org>
References: <1374730817-9040-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1374730817-9040-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37751
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

On Thu, Jul 25, 2013 at 12:40:17AM -0500, Steven J. Hill wrote:

> To prepare for CPU hotplug of CM-based platforms.

But for the time being this is all Octeon-specific code - and without
seeing the patches for the other CM-based platforms I don't even know
if that fixup_irqs() function really serves the same purpose, so I've
added an octeon_ prefix to the function's name and moved its declaration
to a header file.

  Ralf
