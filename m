Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Mar 2014 03:29:17 +0100 (CET)
Received: from snt0-omc2-s41.snt0.hotmail.com ([65.54.61.92]:47351 "EHLO
        snt0-omc2-s41.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825821AbaCYC1Uzj-G0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Mar 2014 03:27:20 +0100
Received: from SNT145-W65 ([65.55.90.73]) by snt0-omc2-s41.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Mar 2014 19:27:05 -0700
X-TMN:  [lCYq4kqWEb7V74z6N1FYWLt3/rFfdptX]
X-Originating-Email: [nickkrause@sympatico.ca]
Message-ID: <SNT145-W659480DCC260415F2FA288A5650@phx.gbl>
From:   Nick Krause <nickkrause@sympatico.ca>
To:     "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RESEND: PATCH[60485 Bug adding breakpoint for msi-pci]
Date:   Tue, 25 Mar 2014 02:27:04 +0000
Importance: Normal
In-Reply-To: <SNT145-W3682AF4AA1AE6F941FDC1BA57A0@phx.gbl>
References: <SNT145-W982FA6E38A0213DE61456DA5780@phx.gbl>,<SNT145-W3682AF4AA1AE6F941FDC1BA57A0@phx.gbl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 25 Mar 2014 02:27:05.0288 (UTC) FILETIME=[B6841480:01CF47D1]
Return-Path: <nickkrause@sympatico.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nickkrause@sympatico.ca
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



----------------------------------------
> From: nickkrause@sympatico.ca
> To: alan@lxorguk.ukuu.org.uk
> CC: linux-mips@linux-mips.org; linux-kernel@vger.kernel.org; ralf@linux-mips.org
> Subject: RE: PATCH[60485 Bug adding breakpoint]
> Date: Mon, 24 Mar 2014 00:19:29 +0000
>
>
>
>
>
> Here is my new patch as corrected for the the bug 60845.
> https://bugzilla.kernel.org/show_bug.cgi?id=60845
> This is the link to the bug and my comments / conversation on to get the corrections needed.
>  Below is my patch for the bug, please let me know if it gets added finally Alan .
>
>  --- linux-3.13.6/arch/mips/pci/msi-octeon.c.orig    2014-03-22 17:32:44.762754254 -0400
>  +++ linux-3.13.6/arch/mips/pci/msi-octeon.c    2014-03-22 17:34:19.974753699 -0400
>  @@ -150,6 +150,7 @@ msi_irq_allocated:
>           msg.address_lo =
>               ((128ul << 20) + CVMX_PCI_MSI_RCV) & 0xffffffff;
>           msg.address_hi = ((128ul << 20) + CVMX_PCI_MSI_RCV)>> 32;
>  +        break;
>       case OCTEON_DMA_BAR_TYPE_BIG:
>         /* When using big bar, Bar 0 is based at 0 */
>           msg.address_lo = (0 + CVMX_PCI_MSI_RCV) & 0xffffffff; Signed-off-by: nickkrause@sympatico.ca
> Nick
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
 		 	   		  
From linus.walleij@linaro.org Tue Mar 25 15:07:03 2014
Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Mar 2014 15:07:19 +0100 (CET)
Received: from mail-oa0-f44.google.com ([209.85.219.44]:38043 "EHLO
        mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821284AbaCYOHC5MQqF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Mar 2014 15:07:02 +0100
Received: by mail-oa0-f44.google.com with SMTP id n16so616428oag.17
        for <linux-mips@linux-mips.org>; Tue, 25 Mar 2014 07:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CTge+HluogvYftZ/PMGQ6T+iVUOcAlYGdNseftG50yI=;
        b=Eg7+Vcq1bwQQA/WVhcQb5HWP+W7XWYdxjpDV62J/jjLbofSfYK3a2wtJ8MfsOZNpxQ
         cEdLxtXLDxqlJP62RN6stvkpcEktbyxveCiin3NotI5wiS76cDZWJvBjbdpmI1ny+2Ei
         pvyxCJLUGkzDNfLiQT1K7d2gACYhMOhahQ7nzGfmT/li/RqJkWzvXFE0WF2LOkLW8ev+
         87266GKcJ12k7xbBlqoOEwTfZ0zXDa6fJJ2a+48ySl9BY+gAxIWzwRYdM0PZ1nTzIUG7
         kuP3EHKklocPZdYOB++0CDj6+sEaEG906l8dRKcQKDOP4OgpjGQZotHbqFY1ke9ZLnDM
         nBFg==
X-Gm-Message-State: ALoCoQnMproRwgcXzuU5gdYJk6h91XiVxNF9o5B0I7oCMO3ReZ4tF48L+V0Utp9WTIbRmeuxptRe
MIME-Version: 1.0
X-Received: by 10.60.161.101 with SMTP id xr5mr1008984oeb.71.1395756413961;
 Tue, 25 Mar 2014 07:06:53 -0700 (PDT)
Received: by 10.182.85.202 with HTTP; Tue, 25 Mar 2014 07:06:53 -0700 (PDT)
In-Reply-To: <20140319170030.GH17197@linux-mips.org>
References: <1390518477-10020-1-git-send-email-linus.walleij@linaro.org>
        <20140319170030.GH17197@linux-mips.org>
Date:   Tue, 25 Mar 2014 15:06:53 +0100
Message-ID: <CACRpkdYownU1JcCi=iuWEDokdD22j6qH2kARHZiKTOBmpg0xUw@mail.gmail.com>
Subject: Re: [PATCH] gpio: vr41xx: mark GPIO lines used for IRQ
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        linux-mips@linux-mips.org, Yoichi Yuasa <yuasa@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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
Content-Length: 948
Lines: 29

On Wed, Mar 19, 2014 at 6:00 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Jan 24, 2014 at 12:07:57AM +0100, Linus Walleij wrote:
>
> Added Yoichi to cc.
>
>> When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
>> the gpiolib so we can keep track of the usage centrally.
>>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> It would be much appreciated if one of the MIPS people could
>> test this patch, thanks in advance. (I did compile-test it
>> with a MIPS cross compiler.)
>> ---
>
> I haven't received any test results but as it's looking good I'm queueing
> this for 3.15.

If it works I'd like to queue it through the GPIO tree actually,
as I need to tweak it a bit to use the new resource callbacks
from the IRQ tree.

(But no big deal if you've already prepped your queue,
I can fix this up later.)

Yours,
Linus Walleij
