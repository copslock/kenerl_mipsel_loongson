Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2012 03:25:31 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34705 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903690Ab2C2BZZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2012 03:25:25 +0200
Received: by pbcun4 with SMTP id un4so2867807pbc.36
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2012 18:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=4iFsy06VpXauzoVA7H0uhSV2FXtANiYy/ZCt1QupB5Y=;
        b=Xq7w36Mx75OL5Pwh5DmVImimO1dP0DlU9XztytxzESehLiCDFnT5dk5ELSFbp/30oT
         jI9A1BrG7A03rBnl4U03QPL9oZZbK32gJU0IJydBEv5YZsDLheQ/+Io+cN/C2yoeljeT
         vFqqR4HZxYBDkpA8hJ+tZgSAdNDc4JpMLB2y6/ym/p/h2NmHs+xttlRotqbwGi0UK1Ki
         l08vj5JqSci2n4heCogPRqPWu+fBbxZ4z2qksq2I5nhWh4nthmMjzaI6csRHjyyxO/pK
         zzP+8W+fegB+db2lesCiuV0f1mJLTsA9mBpxVMLWOzL7nLkg6/plZxA2guoKGvYmqPNC
         7pkQ==
Received: by 10.68.224.99 with SMTP id rb3mr10237300pbc.79.1332984318512;
        Wed, 28 Mar 2012 18:25:18 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id o2sm3815529pbb.45.2012.03.28.18.25.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 18:25:14 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 599E13E0C26; Wed, 28 Mar 2012 15:08:39 -0700 (MST)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 2/4] MIPS: Octeon: Setup irq_domains for interrupts.
To:     David Daney <david.daney@cavium.com>,
        Rob Herring <robherring2@gmail.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <4F733945.6000804@cavium.com>
References: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com> <1332790281-9648-3-git-send-email-ddaney.cavm@gmail.com> <4F711E69.1080302@gmail.com> <4F7205F3.3000108@cavium.com> <4F7239A4.7070905@gmail.com> <4F723FDD.4080708@cavium.com> <4F731E69.8030907@gmail.com> <4F733945.6000804@cavium.com>
Date:   Wed, 28 Mar 2012 16:08:39 -0600
Message-Id: <20120328220839.599E13E0C26@localhost>
X-Gm-Message-State: ALoCoQkuTlgbWmbJFCGolgat6uRSA2SCr5d4prDeUsuapNiq8zPH62G/sDjzUZCkcrJTQGtheaqu
X-archive-position: 32809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 28 Mar 2012 09:16:05 -0700, David Daney <david.daney@cavium.com> wrote:
> On 03/28/2012 07:21 AM, Rob Herring wrote:
> > On 03/27/2012 05:31 PM, David Daney wrote:
> >> On 03/27/2012 03:05 PM, Rob Herring wrote:
> >>> On 03/27/2012 01:24 PM, David Daney wrote:
> >>>> On 03/26/2012 06:56 PM, Rob Herring wrote:
> >>>>> On 03/26/2012 02:31 PM, David Daney wrote:
> >>>>>> From: David Daney<david.daney@cavium.com>
> >>>> [...]
> >>>>>> +static bool octeon_irq_ciu_is_edge(unsigned int line, unsigned int
> >>>>>> bit)
> >>>>>> +{
> >>>>>> +    bool edge = false;
> >>>>>> +
> >>>>>> +    if (line == 0)
> >>>>>> +        switch (bit) {
> >>>>>> +        case 48 ... 49: /* GMX DRP */
> >>>>>> +        case 50: /* IPD_DRP */
> >>>>>> +        case 52 ... 55: /* Timers */
> >>>>>> +        case 58: /* MPI */
> >>>>>> +            edge = true;
> >>>>>> +            break;
> >>>>>> +        default:
> >>>>>> +            break;
> >>>>>> +        }
> >>>>>> +    else /* line == 1 */
> >>>>>> +        switch (bit) {
> >>>>>> +        case 47: /* PTP */
> >>>>>> +            edge = true;
> >>>>>> +            break;
> >>>>>> +        default:
> >>>>>> +            break;
> >>>>>> +        }
> >>>>>> +    return edge;
> >>>>>
> >>>>> Moving in the right direction, but I still don't get why this is not in
> >>>>> the CIU binding as a 3rd cell?
> >>>>
> >>>> There are a several reasons, in no particular order they are:
> >>>>
> >>>> o There is no 3rd cell.  The bindings were discussed with Grant here:
> >>>>     http://www.linux-mips.org/archives/linux-mips/2011-05/msg00355.html
> >>>>
> >>>
> >>> Then add one.
> >>
> >> I can't.  The dtb is already programmed into the bootloader ROMs,
> >> changing the kernel code will not change that.  It is fait accompli.
> >>
> >>>
> >>>> o The edge/level thing cannot be changed, and the irq lines don't leave
> >>>> the SOC, so hard coding it is possible.
> >>>
> >>> Right, but DT describes h/w connections and this is an aspect of the
> >>> connection. This may be fixed for the SOC, but it's not fixed for the
> >>> CIU (i.e. could change in future chips), right?
> >>
> >> In theory yes.  However:
> >>
> >> 1) The chip designers will not change it.
> >>
> >> 2) There will likely be no more designs with either CIU or CIU2, so we
> >> know what all the different possibilities are today.
> >>
> >> When CIU3 is deployed, we will use the lessons we have learned to do
> >> things the Right Way.
> >>
> >>>
> >>> There's 2 reasons why you would not put this into DTS:
> >>>
> >>> - All irq lines' trigger type are the same, fixed and known.
> >>> - You can read a register to tell you the trigger type.
> >>>
> >>> Even if it's not going to change ever, it's still worth putting into the
> >>> DTS as it is well suited for holding that data and it is just data.
> >>
> >> Agreed that it could be in the DTS, and retrospect it probably should
> >> have been put in the DTS, but it wasn't.  So I think what we have now is
> >> a workable solution, and has the added attraction of working with
> >> already deployed boards.
> >
> > Aren't you building in the dtb to the kernel?
> 
> No.  This seems like a bit of a disconnect in this discussion.  From the 
> cover-letter:
> 
> o A device tree template is statically linked into the kernel image.
>    Based on SOC type and board type, legacy configuration probing code
>    is used to prune and patch the device tree template.
> 
> o New SOCs and boards will directly use a device tree passed by the
>    bootloader.

I think the real surprise here is that Octeron is depending on a
masked-in copy of the device tree.  It has alwasy been a strong
recommendation to store the .dtb along side the kernel in reflashable
storage for exactly the reason that updates may be required.  Review
is vitally important, but nobody can foresee all the implications
until the bindings are actually used.

I'm not going to harp over this, I understand that you're hamstrung
here, but please do pass on to the firmware engineers that storing the
.dtb in masked rom is risky.

> 
> 
> >
> > It could be argued it doesn't matter what you deployed without upstream
> > review.
> 
> A moot point, as all the bindings were reviewed with Grant Likely 
> precisely for the reason of minimizing surprises when merging upstream. 
>   In the intervening months, we have found a few rough edges like this, 
> but we cannot say that there was no upstream review.

Yes, you've been good about this and I much appreciate it.

g.
