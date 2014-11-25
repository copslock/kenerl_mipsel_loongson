Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 13:09:09 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35094 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007023AbaKYMJIE9Nyp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Nov 2014 13:09:08 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAPC94ql031203;
        Tue, 25 Nov 2014 13:09:04 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAPC92MM031202;
        Tue, 25 Nov 2014 13:09:02 +0100
Date:   Tue, 25 Nov 2014 13:09:02 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Cowgill <James.Cowgill@imgtec.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Herrmann, Andreas" <Andreas.Herrmann@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: octeon: Add support for the UBNT E200 board
Message-ID: <20141125120902.GD16505@linux-mips.org>
References: <1416837096-52243-1-git-send-email-James.Cowgill@imgtec.com>
 <54736A06.9070206@gmail.com>
 <20141124191301.GC6796@fuloong-minipc.musicnaut.iki.fi>
 <20141124194611.GD6796@fuloong-minipc.musicnaut.iki.fi>
 <54738CCA.4090302@gmail.com>
 <104ADEDC18AE5E45870C06CF0304E344A50C91@LEMAIL01.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <104ADEDC18AE5E45870C06CF0304E344A50C91@LEMAIL01.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44431
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

On Tue, Nov 25, 2014 at 11:58:21AM +0000, James Cowgill wrote:

> > So for all boards with bootloaders that supply a device tree, there 
> > should never be any reason to patch in the hacky board identifiers to 
> > the kernel sources.
> 
> Yep you're right - everything does seem to work. I think I must have
> messed up different kernel versions or something when I tested this
> before. Sorry for the spam, you can ignore this patch.

I already dropped it from patchwork yesterday.

  Ralf
