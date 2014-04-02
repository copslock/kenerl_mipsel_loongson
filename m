Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2014 12:32:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47134 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822303AbaDBKcGGxkOc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Apr 2014 12:32:06 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s32AW4jv011739;
        Wed, 2 Apr 2014 12:32:04 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s32AW3LC011738;
        Wed, 2 Apr 2014 12:32:03 +0200
Date:   Wed, 2 Apr 2014 12:32:03 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: MT: proc: Add support for printing VPE and TC ids
Message-ID: <20140402103203.GR4365@linux-mips.org>
References: <1381846382-26437-1-git-send-email-markos.chandras@imgtec.com>
 <20131016151007.GP1615@linux-mips.org>
 <533BE58C.3010201@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533BE58C.3010201@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39612
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

On Wed, Apr 02, 2014 at 11:25:16AM +0100, James Hogan wrote:

> Both of these patches seem to be applied, Markos' in v3.14-rc1, and your
> one in mips-for-linux-next:
> 
> $ cat /proc/cpuinfo
> ...
> processor               : 3
> ...
> core                    : 1
> VPE                     : 1
> VCED exceptions         : not available
> VCEI exceptions         : not available
> VPE                     : 1
> 
> Maybe a revert of Markos' patch could be squashed in to your patch?

Unfortunately I've already sent out my 3.15 pull request so I think I'll
have to live with the damage until I can send a revert to Linus.

That said, Linus didn't pull yesterday.

  Ralf
