Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Oct 2010 19:50:43 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:44465 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491179Ab0JQRuj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Oct 2010 19:50:39 +0200
Received: by qyk35 with SMTP id 35so3479628qyk.15
        for <linux-mips@linux-mips.org>; Sun, 17 Oct 2010 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mBCp2PwaUB6qiC1i5fVOfUQtyFdUI6ueyZz6fhdy1JY=;
        b=IjkmLSpAgY1+SjPkMVIn5UNRx2OOD7sValqY6wy+ESKIEUlT+zqFOvdvNJsOkJBf6D
         Pu83GuqJjR00l4BGK7fTQ86JiOOUkGfeU5CPCFMk2vCTuQmTkw1GZAIL8X1LsnyfhZOc
         0UJ9XaT38gkg3fiBjQE+pW99ubUjXgQhOsY6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=il1Y7XQqAPndZ+guz51AMpp8e5jTyrWrRaNT2+FFC1H3/i62ApzEP174Uaoe+AekpM
         LPvBO0uVPjzZ0+IPBeI320ayDbvjKai27g325Ls8YoTlUZ0K0tMzMK+UyF/gq7UCYAYj
         w2G1HCVTwZUbwZllbaEVHGVlHgqWAApMqgIBo=
MIME-Version: 1.0
Received: by 10.224.89.11 with SMTP id c11mr1902612qam.25.1287337830897; Sun,
 17 Oct 2010 10:50:30 -0700 (PDT)
Received: by 10.224.45.148 with HTTP; Sun, 17 Oct 2010 10:50:30 -0700 (PDT)
In-Reply-To: <AANLkTikP=77Tq=QzFVwexr8fMHg5qmX8fbRjfdkoNSGr@mail.gmail.com>
References: <AANLkTikP=77Tq=QzFVwexr8fMHg5qmX8fbRjfdkoNSGr@mail.gmail.com>
Date:   Sun, 17 Oct 2010 10:50:30 -0700
Message-ID: <AANLkTikbw1F+jBhsFFyX0vT6CCAqckzLHK3MK2WtTZiA@mail.gmail.com>
Subject: Re: Question about Context register in TLB refilling
From:   Kevin Cernekee <cernekee@gmail.com>
To:     "wilbur.chan" <wilbur512@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, Oct 17, 2010 at 8:51 AM, wilbur.chan <wilbur512@gmail.com> wrote:
> 1) In linux ,esspecially in TLB refilling,  is Context[PTEBase] used
> to store cpuid? (refer to build_get_pgde32 in tlbex.c)

On 32-bit systems, PTEBase stores a byte offset that can be added to
&pgd_current[0].  i.e. smp_processor_id() * sizeof(unsigned long)

So the TLB refill handler can find pgd for the current CPU using code
that looks something like this:

   0:   401b2000        mfc0    k1,c0_context
   4:   3c1a8054        lui     k0,0x8054
   8:   001bddc2        srl     k1,k1,0x17
   c:   035bd821        addu    k1,k0,k1
...
  14:   8f7b5008        lw      k1,20488(k1)

where pgd_current is at 0x8054_5008, and PTEBase is 0, 4, 8, 12, ...

See also: TLBMISS_HANDLER_SETUP().

For 64-bit systems with CONFIG_MIPS_PGD_C0_CONTEXT, it looks like a
direct pgd pointer is now being stored in Context, to speed up the TLB
handlers.
