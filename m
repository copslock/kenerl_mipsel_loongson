Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 14:23:07 +0100 (CET)
Received: from mail-fx0-f209.google.com ([209.85.220.209]:40999 "EHLO
        mail-fx0-f209.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492304Ab0A1NXC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jan 2010 14:23:02 +0100
Received: by fxm1 with SMTP id 1so656410fxm.24
        for <multiple recipients>; Thu, 28 Jan 2010 05:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EvV/A6GhuWF8tpwwf22lwYIJz0AACtANKTjoAcyRNrk=;
        b=UWFFvqcHN9RZfO0HPoL4+sOFFnpMGtqoiNP9dat0eEvu7Eb8ckuPRT4th8tVhoNyEo
         CNdJi4YMia4oiY9NVlgJzCmSqP+pmzcvfuNrtoumdb4ixSRi43dP/crObY5CUsq3J33F
         lYloLo51rd4KbGRhBztJtTbn7to43labL70bE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vnZsXD6jOyuXYJL+6ztyrSZ4R6grSbEg/rAMKnbdB/zUh3U6kegYokxfGJqO/9PMtG
         539MqhJiQELVCs7aXCVPmUDDrKQluT0bia+hkTEbYgwo/qZaPPxuPcxXzTk+Xq2nr7o3
         5IX6kcIf7UpAE+4aLoJOfY9FlOp18Hpimke/0=
MIME-Version: 1.0
Received: by 10.223.94.211 with SMTP id a19mr5176039fan.59.1264684975801; Thu, 
        28 Jan 2010 05:22:55 -0800 (PST)
In-Reply-To: <20100128131858.GA13807@linux-mips.org>
References: <hhq35v$m1q$1@ger.gmane.org>
         <f861ec6f1001261246y545e7a9ahe11eaf16fd587959@mail.gmail.com>
         <i8xpr4wftsy.fsf@pabr.org> <20100128131858.GA13807@linux-mips.org>
Date:   Thu, 28 Jan 2010 14:22:55 +0100
Message-ID: <f861ec6f1001280522u5689e1f5i4527101a48e5f347@mail.gmail.com>
Subject: Re: [RFC] Support 36-bit iomem on 32-bit Au1x00
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     pascal@pabr.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 25711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18207

On Thu, Jan 28, 2010 at 2:18 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jan 26, 2010 at 10:19:22PM +0100, pascal@pabr.org wrote:
>
> The whole fixing up of I/O addresses was necessary because the generic
> code was written to assume that sizeof(unsigned long) == sizeof(void *)
> and that mostly because it was handy for Linus' i386 world.
>
> Today I think it would be preferable to get rid of the the fixups, pay the
> small price for the larger resources and get sanity in exchange.  My gut
> feeling is that the bloat factor should be small.  Either way, I'll let
> you two sort this out for Alchemy and mark this patch as defered.

I'm fine with it as-is; it doesn't break anything.  I was experimenting with
extending the PCMCIA socket code to pass on 36bit addresses and got
bitten by the driver core.

Manuel
