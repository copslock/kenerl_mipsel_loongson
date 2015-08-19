Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Aug 2015 22:49:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36033 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012824AbbHSUtnrFNch (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Aug 2015 22:49:43 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t7JKnhGc023014;
        Wed, 19 Aug 2015 22:49:43 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t7JKngWn023013;
        Wed, 19 Aug 2015 22:49:42 +0200
Date:   Wed, 19 Aug 2015 22:49:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: OCTEON: fix management port MII address on Kontron
 S1901
Message-ID: <20150819204942.GN3612@linux-mips.org>
References: <1439279788-2050-1-git-send-email-aaro.koskinen@nokia.com>
 <55CA55E3.70202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55CA55E3.70202@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48946
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

On Tue, Aug 11, 2015 at 01:06:59PM -0700, David Daney wrote:

> 
> On 08/11/2015 12:56 AM, Aaro Koskinen wrote:
> >Management port MII address is incorrect on Kontron S1901 resulting
> >in broken networking. Fix by providing definitions for the in-tree DT
> >pruning code.
> >
> >Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> This seems reasonable, I cannot test it, but ...
> 
> Acked-by: David Daney <david.daney@cavium.com>

Queued for 4.3.

Thanks folks!

  Ralf
