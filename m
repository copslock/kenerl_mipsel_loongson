Return-Path: <SRS0=vpel=OO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871E5C04EB9
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 22:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55716206B7
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 22:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55716206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeLEWZy (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:25:54 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:35128 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeLEWZx (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 5 Dec 2018 17:25:53 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id B9900B0044;
        Thu,  6 Dec 2018 00:25:51 +0200 (EET)
Date:   Thu, 6 Dec 2018 00:25:51 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 0/6] MIPS: OCTEON: cleanups, part II
Message-ID: <20181205222551.GB19520@darkstar.musicnaut.iki.fi>
References: <20181204201220.12667-1-aaro.koskinen@iki.fi>
 <20181205220918.GA19520@darkstar.musicnaut.iki.fi>
 <20181205222010.77ckzxfblnt3b6n2@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205222010.77ckzxfblnt3b6n2@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Wed, Dec 05, 2018 at 10:20:12PM +0000, Paul Burton wrote:
> On Thu, Dec 06, 2018 at 12:09:18AM +0200, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Tue, Dec 04, 2018 at 10:12:14PM +0200, Aaro Koskinen wrote:
> > >   MIPS: OCTEON: delete redundant register definitions
> > [...]
> > >  39 files changed, 15 insertions(+), 7935 deletions(-)
> > 
> > Looks like the last patch didn't get through (around 500 KB, maybe hit
> > some limit). Please disregard this series for now, I'll rework the series
> > to do changes with smaller patches.
> 
> I actually applied this already - patch 6 didn't make it through the
> mailing list but I did receive it personally.

OK, that's fine then, thanks!

> Let me know ASAP if you'd prefer that I drop it.

No need to drop.

A.
