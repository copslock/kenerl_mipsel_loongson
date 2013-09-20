Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2013 20:18:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60021 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823013Ab3ITSSTWoXFP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Sep 2013 20:18:19 +0200
Date:   Fri, 20 Sep 2013 19:18:19 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joe Perches <joe@perches.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] framebuffer: Remove pmag-aa-fb
In-Reply-To: <CAMuHMdW6R5qTJ0uvsUUaYBZAqFcNshPsXeMbz5hwqq5UOkJr-g@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1309201907380.8379@linux-mips.org>
References: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>        <6f500d88eb23fd9a4cfc5583f5ca17bc5f58fe24.1379641901.git.joe@perches.com> <CAMuHMdW6R5qTJ0uvsUUaYBZAqFcNshPsXeMbz5hwqq5UOkJr-g@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Joe, Geert --

 Can we please wait with that a few days?  I've been reviving DECstation 
bits recently but the generic stuff took priority (thankfully little 
bitrot there, the port generally works, except from the 64-bit mode).  I 
think it'll make more sense if we have an incremental diff in the repo 
rather than a complete removal, followed with a readdition with necessary 
adjustments.

> Adding Maciej and linux-mips

 Thanks for (re-)pinging, I've been trying to push things forwards as time 
permits.

  Maciej
