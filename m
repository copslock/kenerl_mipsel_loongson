Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 15:55:19 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:51342 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904113Ab1KROzL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Nov 2011 15:55:11 +0100
Received: by wwp14 with SMTP id 14so4416274wwp.24
        for <multiple recipients>; Fri, 18 Nov 2011 06:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4Kw54x16eybZ2/ThkzxWavMkZy7417sAB+2oD2doZpA=;
        b=igjPA6XqjRDH5DOrMW+YJVjNnkVuOWhzW3N5q626pGUPcKo9RF5xGg/pnoyBorO3Jn
         HToczO/hCPXh3+9pv7eDKmUbzNpOu7Jo5MPF9W1mYG1bbQTI8bdAAdtEJBIl8Bu3E9O2
         mWp64XS8WhBZbjGgBaO5uTGCW1xL4Y0u/kVZE=
MIME-Version: 1.0
Received: by 10.181.13.5 with SMTP id eu5mr3434273wid.55.1321628105640; Fri,
 18 Nov 2011 06:55:05 -0800 (PST)
Received: by 10.216.45.11 with HTTP; Fri, 18 Nov 2011 06:55:05 -0800 (PST)
In-Reply-To: <20111118144600.GA12409@linux-mips.org>
References: <CAJd=RBBTx8zWrFfVQGMK=aj=iPO_+i6nvqkhGDfYp_9=d1hyEw@mail.gmail.com>
        <20111118144600.GA12409@linux-mips.org>
Date:   Fri, 18 Nov 2011 22:55:05 +0800
Message-ID: <CAJd=RBCBhmctuNACxAs-Uw6w+u88v1XVwUp89ybZN7yDn5jFuQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Flush huge TLB
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15502

On Fri, Nov 18, 2011 at 10:46 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Nov 18, 2011 at 09:15:39PM +0800, Hillf Danton wrote:
>
>> When flushing TLB, if @vma is backed by huge page, we could flush huge TLB,
>> due to that huge page is defined to be far from normal page.
>>
>> Signed-off-by: Hillf Danton <dhillf@gmail.com>
>
> It seems this patch is identical to
> https://patchwork.linux-mips.org/patch/2825/ which I've already applied?
>

Maybe you forget the following message:)

btw, I want to change
+			size = (end - start) >> HPAGE_SHIFT;
to
+			size = (end - start) / HPAGE_SIZE;

if it is not too late.

Best regards
Hillf

On Wed, Nov 16, 2011 at 10:52 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Oct 14, 2011 at 09:09:37PM +0800, Hillf Danton wrote:
>
>> Subject: Flush huge TLB
>> From: Hillf Danton <dhillf@gmail.com>
>>
>> When flushing TLB, if @vma is backed by huge page, we could flush huge TLB,
>> due to that huge page is defined to be far from normal page.
>>
>> Signed-off-by: Hillf Danton <dhillf@gmail.com>
>> Acked-by: David Daney <david.daney@cavium.com>
>
> I assume this 2nd version was actually meant to be applied, not just for RFC
> so I've queued it for 3.3.  But you better remove that RFC from subject and
> start a fresh mail thread when posting a patch to avoid confusion!
>
> Thanks,
>
>  Ralf
>
