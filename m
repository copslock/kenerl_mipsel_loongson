Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 09:20:01 +0200 (CEST)
Received: from p54BA9F99.dip0.t-ipconnect.de ([84.186.159.153]:58466 "EHLO
        linux-mips.org" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6860076AbaGaHT7vrIWg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 09:19:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s6V7JuGY016346;
        Thu, 31 Jul 2014 09:19:56 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s6V7Jtvm016345;
        Thu, 31 Jul 2014 09:19:55 +0200
Date:   Thu, 31 Jul 2014 09:19:55 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: prevent user from setting FCSR cause bits
Message-ID: <20140731071954.GC27790@linux-mips.org>
References: <1406035281-693-1-git-send-email-paul.burton@imgtec.com>
 <20140730173446.GB27790@linux-mips.org>
 <20140730173916.GV30558@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140730173916.GV30558@pburton-laptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41836
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

On Wed, Jul 30, 2014 at 06:39:16PM +0100, Paul Burton wrote:

> Any chance you could expand that acronym for me? Maybe I'm being slow
> since neither of the expansions that spring to mind make much sense.

UML - User Mode Linux.  What I meant is something like UML might have a
legitimate reason to load values triggering exceptions into the FPU.
Obviously with UML not being supported on Linux that's hard to check
for sure ...

  Ralf
