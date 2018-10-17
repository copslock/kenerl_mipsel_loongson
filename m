Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2018 21:50:55 +0200 (CEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:44096 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbeJQTuxI6sQ9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2018 21:50:53 +0200
Received: from darkstar.musicnaut.iki.fi (85-76-99-103-nat.elisa-mobile.fi [85.76.99.103])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id A64A53000C;
        Wed, 17 Oct 2018 22:50:51 +0300 (EEST)
Date:   Wed, 17 Oct 2018 22:50:50 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: Re: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
Message-ID: <20181017195050.GA20347@darkstar.musicnaut.iki.fi>
References: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
 <CA+7wUszkduiKMVx5Et3Q2-2tz72CXUKE1_kndC6V1d45uEY2Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUszkduiKMVx5Et3Q2-2tz72CXUKE1_kndC6V1d45uEY2Aw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Wed, Oct 17, 2018 at 03:38:07PM +0200, Mathieu Malaterre wrote:
> Since CONFIG_PREEMPT has been 'y' since at least commit 0752f92934292
> could you confirm that the original mmc driver (kernel from imgtech
> people) did work ok with PREEMPT_NONE (sorry I did not do my homework)
> ?

Sorry, cannot confirm or test that. I have only used the mainline kernel
on this board, since v4.5 or so with my own custom config which has
been PREEMPT_NONE until now.

A.
