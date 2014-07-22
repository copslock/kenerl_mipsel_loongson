Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 19:57:00 +0200 (CEST)
Received: from mail-vc0-f169.google.com ([209.85.220.169]:61278 "EHLO
        mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6863081AbaGVRl5HCWJN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 19:41:57 +0200
Received: by mail-vc0-f169.google.com with SMTP id hu12so15698365vcb.0
        for <multiple recipients>; Tue, 22 Jul 2014 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2tSKfxATN+HEMbUS0abm1sGHRHEdev+be7qBL+dNOHk=;
        b=EZesITB+dFvlkjlpICaGvJR7ZDpkKXiNchRvIn9GK9OvwoBiIo84TMsmhf80SJVkBD
         IRnQC+VIP1/0lZS6V3b/d2wOfDlJ3uN7+2uw9pL0sOWiW+v/TDt04dbNYW5Bap3V2A4O
         +1HUlr1GCOvv5CiWaVBxreYX5cN49uTAwpgIj9Xv4y56owFexNHdf3dpWwqTHWhwFAYL
         rFVzkKECIEfFJ04WZ4c7hpYSxDjBIpK0FgJebFaT/yNWoVohGjJ7Iv/td/RO5zqKg1gM
         IETcrQ3qNefNr3vg+iX2kHeQXO0wVtKQMsf6IVvEQMBlyBE6KnQRfYkY6h6qCm0yk7jI
         YG2w==
MIME-Version: 1.0
X-Received: by 10.52.120.38 with SMTP id kz6mr12882054vdb.86.1406050910666;
 Tue, 22 Jul 2014 10:41:50 -0700 (PDT)
Received: by 10.220.187.133 with HTTP; Tue, 22 Jul 2014 10:41:50 -0700 (PDT)
In-Reply-To: <CAGVrzcb665srrVTojY+E1Raec5=E6oK+CAdPrP3Fx15Zt+piBQ@mail.gmail.com>
References: <CAPDOMVhUkF49L1jJgfXdRdMW2qkGsbPfGVwrdaETqTUs3bEcsQ@mail.gmail.com>
        <CAGVrzcb665srrVTojY+E1Raec5=E6oK+CAdPrP3Fx15Zt+piBQ@mail.gmail.com>
Date:   Tue, 22 Jul 2014 13:41:50 -0400
Message-ID: <CAPDOMViiiqQAvOFeYoG+h4gX-mV71HsgMNgEEbmdOtqDomshSg@mail.gmail.com>
Subject: Re: decompress.c : Add cache support
From:   Nick Krause <xerofoify@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        John Crispin <blogic@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

On Tue, Jul 22, 2014 at 1:14 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 2014-07-21 21:24 GMT-07:00 Nick Krause <xerofoify@gmail.com>:
>> Hey Ralf and others
>> We seem to be flushing this cache after decompressing the kernel on
>> mips. Can't we cache this?
>
> I am not sure I fully understand what you mean here. What would we be
> caching, instruction, data, both?
>
>> If anyone has any advice on how to fix this it would be great:).
>> Nick
>
> One patch that I carried locally and which works for a bunch of
> MIPS32r1 compatible platforms out there is this one, I tried to
> address some of Ralf's comment as well about the code duplication
> (maybe I can get around to resubmit it):
>
> http://patchwork.linux-mips.org/patch/1565/
> --
> Florian

Florian,
You should resubmit this patch as it seems to be correct and fix this issue.
Cheers Nick
