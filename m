Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 16:45:32 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:54141 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492059Ab0KXPp3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Nov 2010 16:45:29 +0100
Received: by gwj20 with SMTP id 20so68253gwj.36
        for <linux-mips@linux-mips.org>; Wed, 24 Nov 2010 07:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=izmDHcLl3LXvScpoQg5EGVu+GyLsoSJWtYXgT4sM7Hc=;
        b=XDJFzAdrdJOOLe/p1XAJaMtfWRe9YCixVn+8e5dMur/aXJP8v+s9WXyLQqOdM8CMAL
         +tOJZ2pJnWK5aZZTrfhS7k8MK3eHKYeGucsu5GhfYr0L1cRbDLdwwJOFXPIOg+AT4l/v
         krr0NUqZROpGylqyunjLaRD7tcNRr7Mz6ie/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=W2ik5UkIN9WFDmhpTVpBJ1PwvFLAMYET6qvpwjpk1bwcKQM3vgEBp7lWkIeVzvd6uw
         NSmHBRyMLpwctPLTC2saBlyRaWEN/IHu6/8B9AtWA7/UbHriZEiTC8IOqnbs8oaSV2dn
         F3SBega076dLaCKDjWsaT6UH+nB3OYjb9Y5GU=
Received: by 10.150.211.5 with SMTP id j5mr1080662ybg.425.1290613522663; Wed,
 24 Nov 2010 07:45:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.231.30.74 with HTTP; Wed, 24 Nov 2010 07:44:52 -0800 (PST)
In-Reply-To: <1290607413.12457.44.camel@concordia>
References: <1290607413.12457.44.camel@concordia>
From:   Timur Tabi <timur@freescale.com>
Date:   Wed, 24 Nov 2010 09:44:52 -0600
X-Google-Sender-Auth: v2M0gZXh0aSUfveuAKJWuLav6xU
Message-ID: <AANLkTikiTdw1rTxO-wxmutm=vvcxGdTKKCs_roEA7uE-@mail.gmail.com>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
To:     michael@ellerman.id.au
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <timur.tabi@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: timur@freescale.com
Precedence: bulk
X-list: linux-mips

On Wed, Nov 24, 2010 at 8:03 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:

> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
> it would be nice to get rid of, but it's a lot of churn.
>
> So I'm hoping people with either say "YES this is a great idea", or "NO
> this is stupid".

Well, my vote is "no".  I wouldn't call it stupid, but I do think it's
a bad idea.

In general, I don't like renaming functions, because it causes
complications with merges and porting code across kernel versions.  It
also forces me to re-remember things.

And especially in this case, the churn is too great.  You're affecting
files across multiple subsystems and architectures.

-- 
Timur Tabi
Linux kernel developer at Freescale
