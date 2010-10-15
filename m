Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 03:29:39 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:63588 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491107Ab0JOB3g convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Oct 2010 03:29:36 +0200
Received: by ywp6 with SMTP id 6so141577ywp.36
        for <linux-mips@linux-mips.org>; Thu, 14 Oct 2010 18:29:29 -0700 (PDT)
Received: by 10.151.109.3 with SMTP id l3mr550062ybm.56.1287106169670; Thu, 14
 Oct 2010 18:29:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.150.49.9 with HTTP; Thu, 14 Oct 2010 18:29:09 -0700 (PDT)
In-Reply-To: <20101014.191309.515504596.imp@bsdimp.com>
References: <4CB79D93.6090500@caviumnetworks.com> <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
 <20101014.191309.515504596.imp@bsdimp.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Thu, 14 Oct 2010 19:29:09 -0600
X-Google-Sender-Auth: ptbd-DfDaRtS2pQWEm3KmQlCH7Y
Message-ID: <AANLkTi=dqMHa04=-+RjnxuPGL3ZsqNCiaxUPT0VpV6kC@mail.gmail.com>
Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
To:     Warner Losh <imp@bsdimp.com>
Cc:     ddaney@caviumnetworks.com, prasun.kapoor@caviumnetworks.com,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Thu, Oct 14, 2010 at 7:13 PM, Warner Losh <imp@bsdimp.com> wrote:
> In message: <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
>            Grant Likely <grant.likely@secretlab.ca> writes:
> : Overall the plan makes sense, however I would suggest the following.
> : instead of 'live' modifying the tree, another option is to carry a set
> : of 'stock' device trees in the kernel; one per board.  Of course this
> : assumes that your current ad-hoc code is keying on the specific board.
> :  If it is interpreting data provided by the firmware, then your
> : suggestion of modifying a single stock tree probably makes more sense,
> : or possibly a combination of the too.  In general you should avoid
> : live modification as much as possible.
>
> The one draw back on this is that there's lots of different "stock"
> boards that the Cavium Octeon SDK supports.  These will be difficult
> to drag along for every kernel.  And they'd be mostly the same to,
> which is why I think that David is suggesting the live modification
> thing...

Okay.  Do what makes the most sense for your platform.

g.
