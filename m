Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 23:43:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55842 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007158AbbBXWnFeUrGa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Feb 2015 23:43:05 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t1OMh1TQ012447;
        Tue, 24 Feb 2015 23:43:01 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t1OMgvg2012446;
        Tue, 24 Feb 2015 23:42:58 +0100
Date:   Tue, 24 Feb 2015 23:42:57 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/5] MIPS: Allow platforms to specify the decompressor
 load address
Message-ID: <20150224224257.GB9748@linux-mips.org>
References: <1424741507-8882-1-git-send-email-abrestic@chromium.org>
 <1424741507-8882-3-git-send-email-abrestic@chromium.org>
 <7814815.Q6KYv1fjo1@wuerfel>
 <CAL1qeaHSErgc=W4mGhDAm7cu_J4wrOik27joB0Rd-2P7dk=QuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1qeaHSErgc=W4mGhDAm7cu_J4wrOik27joB0Rd-2P7dk=QuA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45938
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

On Tue, Feb 24, 2015 at 01:39:03PM -0800, Andrew Bresticker wrote:

> It is the same sort of issue, though I think the only way to solve it
> on MIPS would be to copy the image to the address it was linked at,
> which could be problematic if there's overlap.  There's also the cache
> maintenance we'd have to do, which varies from CPU to CPU (and more so
> the ARM I believe).

On MIPS it's significantly less complex to implement than the in-kernel
cache maintenance code because only one flush operation needs to be
implemented that will be invoked only once so performance is less of
an issue.  Also oddball hardware such as the S-caches controlled by
an external controller can be ignored for purpose of kernel decomporession.
That pretty much leaves to treat the standard R4000 style of caches
and a few oddballs like R2000 class processors.

  Ralf
