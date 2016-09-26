Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2016 17:29:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58944 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991859AbcIZP3cqv1Js (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Sep 2016 17:29:32 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8QFTV3b012174;
        Mon, 26 Sep 2016 17:29:31 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8QFTUBH012173;
        Mon, 26 Sep 2016 17:29:30 +0200
Date:   Mon, 26 Sep 2016 17:29:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [mips-sjhill:mips-for-linux-next 58/62]
 arch/mips/kernel/uprobes.c:304:15: error: variable or field 'kstart'
 declared void
Message-ID: <20160926152930.GE12981@linux-mips.org>
References: <201609240204.arLAdO5Z%fengguang.wu@intel.com>
 <20160926102437.GB12981@linux-mips.org>
 <5302CFBF-1016-4704-B3AE-3BD986E5DD3B@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5302CFBF-1016-4704-B3AE-3BD986E5DD3B@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55264
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

On Mon, Sep 26, 2016 at 02:07:03PM +0100, James Hogan wrote:

> My intention was I think for kstart to be void * (and to use void * arithmetic), but i'm indifferent if you prefer unsigned long for that. Apparently my build coverage was lacking for this patch, sorry about that!

Standard C doesn't allow arithmetic on void pointers; GCC does so as
an extension over standard C - and I tend to avoid such extensions, if
possible.  I also tend to prefer unsigned long at a low level for things
such as cache flush operations - but more importantly I try to keep the
number of casts down.

  Ralf
