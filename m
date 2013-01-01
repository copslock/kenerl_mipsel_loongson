Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jan 2013 12:29:15 +0100 (CET)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:48252 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815858Ab3AAL3OYW0qJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jan 2013 12:29:14 +0100
Received: by mail-wg0-f48.google.com with SMTP id dt10so5965815wgb.15
        for <multiple recipients>; Tue, 01 Jan 2013 03:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ltC5HGHh5ze4QK6BcCyO+5cXUbETgTd3JXZJopn1HEY=;
        b=MKc35v3GnQw+7vn1IPmMaoeuzsc+TJj/AGsJTYVbZ5nmfUNp5Vapwcl6/sB56yS8gw
         lJRE9Bdiq6F9IKNKKeSLmH4ra+heaDtdWaGBAfMYfSATOeiXHNoIcTsWxvo0jJnf8sfh
         XbcgtWx1MHeNB3/N5kuDB1LKwzbMD2EWQ9bk1SH+w68sbpggepWyN9MZFu1DAq7gnbp4
         DAJoHWbfSUo+9fHwujfkx+BRZfc8bP0xZduIWLr1BVmZ8Y9eg3vBEeS+gBgk0wfkiyKb
         9iyq89rnYLFOtc9zOxLLJv2IT8QjJAa4AB25LnuYGXkuff5HRi40lWefnK8bln9V+K8f
         347A==
X-Received: by 10.180.24.70 with SMTP id s6mr66705840wif.22.1357039749062;
        Tue, 01 Jan 2013 03:29:09 -0800 (PST)
Received: from pixies.home.jungo.com (212-150-239-254.bb.netvision.net.il. [212.150.239.254])
        by mx.google.com with ESMTPS id t17sm74595913wiv.6.2013.01.01.03.29.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Jan 2013 03:29:08 -0800 (PST)
Date:   Tue, 1 Jan 2013 13:29:05 +0200
From:   Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Regarding commit a16dad7 [MIPS: Fix potencial corruption]
Message-ID: <20130101132905.0c733b69@pixies.home.jungo.com>
In-Reply-To: <CAJiQ=7DZq7CO3FHtDe3OX12fZy70AUTJxAq90G5GXEewZdgqHw@mail.gmail.com>
References: <20130101112340.0a0e8c08@pixies.home.jungo.com>
        <CAJiQ=7DZq7CO3FHtDe3OX12fZy70AUTJxAq90G5GXEewZdgqHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 35354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shmulik.ladkani@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Kevin,

On Tue, 1 Jan 2013 01:47:52 -0800 Kevin Cernekee <cernekee@gmail.com> wrote:
> On Tue, Jan 1, 2013 at 1:23 AM, Shmulik Ladkani
> <shmulik.ladkani@gmail.com> wrote:
> > Following a8ca8b64, another commit was submitted, adding similar
> > 'cache_op' instructions to 'mips_sc_inv' - namely 96983ffe
> > (MIPS: MIPSxx SC: Avoid destructive invalidation on partial L2 cachelines).
> >
> > Its purpose was to extend a8ca8b64, aligning behavior of 'mips_sc_inv'
> > to be similar to 'r4k_dma_cache_inv'.
> >
> > Since the explicit 'cache_op' instrcutions are now removed from
> > 'r4k_dma_cache_inv' (as of a16dad77), it probably makes sense to remove
> > them from 'mips_sc_inv' as well.
> >
> > Any reason to keep these 'cache_op's? If not, I'll submit a patch.
> 
> There were a couple of USB drivers that stored DMA buffers inside a
> struct with other data, and invalidating the whole cacheline tended to
> clobber the other data.  For instance, intr_buff in
> drivers/net/usb/pegasus.h .

I see.

> Does CONFIG_DMA_API_DEBUG complain if it sees unaligned start
> addresses or sizes?  That would be a much nicer way of catching the
> problem, than troubleshooting random corruption.

Have no idea ;)
Hoping for Ralf to examine this.

I accidentally happened to notice an anomaly in the code: a revert was
executed (by Ralf Baechle in a16dad77), but it was incomplete:
(1) the comment was left, (2) revert wasn't executed on 'mips_sc_inv'.

Just pointing out the anomalies, for Ralf to acknowledge whether they
were deliberate or not.

Regards,
Shmulik
