Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 20:49:13 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:43682 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491885Ab1HLStH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Aug 2011 20:49:07 +0200
Received: by gxk2 with SMTP id 2so2346793gxk.36
        for <multiple recipients>; Fri, 12 Aug 2011 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=sXexBySvEG8HjNWYqYTfdndQGxQsQvOrK29dczwfXlg=;
        b=rRoUIQu0GaRcZki8vxJCustHLyPi4WcBnzklcJOFxRNFFT+syIi3i3aelvTG6034+1
         pVu/X8QyEPtBnASYzoX6f2psENX/aaCxZo3oZjAKqfhsSdZGWi8kb4+W/crwd+oXnjfD
         KCgUJQf4h6TwN36cdt+gk4St9KntVaz1j1nuY=
Received: by 10.236.116.66 with SMTP id f42mr4293634yhh.13.1313174941118; Fri,
 12 Aug 2011 11:49:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.109.17 with HTTP; Fri, 12 Aug 2011 11:48:41 -0700 (PDT)
In-Reply-To: <20110812184227.GA17057@suse.de>
References: <1313172753-31088-1-git-send-email-manuel.lauss@googlemail.com> <20110812184227.GA17057@suse.de>
From:   Manuel Lauss <manuel.lauss@googlemail.com>
Date:   Fri, 12 Aug 2011 20:48:41 +0200
Message-ID: <CAOLZvyH3_UuJYUduhb5A+ziPrU+7M9WK8pCAr4P_7-QARYwchw@mail.gmail.com>
Subject: Re: [PATCH V2 1/8] MIPS: Alchemy: abstract USB block control register access
To:     Greg KH <gregkh@suse.de>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9633

On Fri, Aug 12, 2011 at 8:42 PM, Greg KH <gregkh@suse.de> wrote:
> On Fri, Aug 12, 2011 at 08:12:33PM +0200, Manuel Lauss wrote:
>> Alchemy chips have one or more registers which control access
>> to the usb blocks as well as PHY configuration.  I don't want
>> the OHCI/EHCI glues to know about the different registers and bits;
>> new code hides the gory details of USB configuration from them.
>>
>> Cc: linux-usb@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@suse.de>  (USB glue parts)
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>> ---
>> V2: moved the chip-specific parts from arch home to usb/host/alchemy-common.c
>>
>>  arch/mips/alchemy/common/dma.c             |   12 +-
>>  arch/mips/alchemy/common/power.c           |   42 ----
>>  arch/mips/include/asm/mach-au1x00/au1000.h |   84 ++------
>>  drivers/usb/host/Makefile                  |    1 +
>>  drivers/usb/host/alchemy-common.c          |  337 ++++++++++++++++++++++++++++
>>  drivers/usb/host/ehci-au1xxx.c             |   77 +------
>>  drivers/usb/host/ohci-au1xxx.c             |  110 +--------
>>  7 files changed, 382 insertions(+), 281 deletions(-)
>>  create mode 100644 drivers/usb/host/alchemy-common.c
>
> Much nicer, thanks.
>
> I can take this in the USB tree if the MIPS developers want, or if not,
> feel free to add:
>        Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> and take it through the MIPS tree.

Great, thanks.  Other patches to the  MIPS tree depend on this one, so
I hope Ralf will take it.

Manuel
