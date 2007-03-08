Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2007 12:49:25 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.230]:40872 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021734AbXCHMtV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Mar 2007 12:49:21 +0000
Received: by qb-out-0506.google.com with SMTP id e12so822992qba
        for <linux-mips@linux-mips.org>; Thu, 08 Mar 2007 04:48:11 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gJetEInnqI2PnzRBo5AC6cqG7Sv9wXgcJGM3dR51WrhDjRSDTWKvrEugMGb9xD7ZkAySHqR7hHOOQCgLRZV/TSsK7uOwCgCHfR8hLoVcEKOfvl+qL/QHBZPtWEz1tz7CfEmq3O/CO7oQEaGPkQS5Rq0PQj/NqHD3HffMhxZG+L8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qmvQkhAYNHcfweufxYnF5KcHynR8ugJdk2LuPE9eI6rNHMixxJ8LwgH8bXnkM7RrtC+Rynqv5kkPoIvrt1Z1mDWY5IIMCSyUwL+o8HiVAZYW+xGhm7KTVD23ZGxexH10L+0rTxJ8+GG+VhObXJPpQWZJ1YiwE9M66GZmVAwtIxM=
Received: by 10.114.152.17 with SMTP id z17mr133140wad.1173358090775;
        Thu, 08 Mar 2007 04:48:10 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Thu, 8 Mar 2007 04:48:10 -0800 (PST)
Message-ID: <cda58cb80703080448yca7fa21xb005e0685d42d318@mail.gmail.com>
Date:	Thu, 8 Mar 2007 13:48:10 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Jim Gifford" <maillist@jg555.com>
Subject: Re: Building 64 bit kernel on Cobalt
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Linux MIPS List" <linux-mips@linux-mips.org>
In-Reply-To: <45EFA92C.3070203@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45EB53D5.8060007@jg555.com>
	 <20070304232731.GA25039@linux-mips.org> <45EFA92C.3070203@jg555.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 3/8/07, Jim Gifford <maillist@jg555.com> wrote:
> Ralf Baechle wrote:
> > On Sun, Mar 04, 2007 at 03:18:45PM -0800, Jim Gifford wrote:
> >
> >
> >> Last working Kernel was 2.6.19 series.
> >>

It seems that I broke things again :(

> >> Some changes from 2.6.19 and the 2.6.20 make it impossible to build a 64
> >> bit kernel to boot on the cobalt. Ya, I know why, building a N32
> >> actually but need a 64 bit kernel in order to do that. Anyone got any
> >> suggestions. Looking through the difference between the kernels to
> >> figure this out, but it's like looking for a needle in a haystack. Any
> >> suggestions as to a starting point?
> >>
> >
> > Try git-bisect to track down the changeset that broke things.
> >
> >   Ralf
> >
> >
> We got it nailed down to arch/mips/kernel /setup.c. But we have not
> isolated which change is actually causing it.
>

Do you use any initrd ? If so how do you pass its address to the kernel ?

What is your kernel load address ?

can you send your .config file you're using ?

> We do know that reverting back to the 2.6.19.x arch/mips/kernel /setup.c
> will fix the issue. We will continue to dwindle it down until we come up
> with the offender.
>
>

What did the console say ? If nothing early console may help if available.

thanks
-- 
               Franck
