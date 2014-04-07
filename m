Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 20:05:05 +0200 (CEST)
Received: from mail-pb0-f42.google.com ([209.85.160.42]:53204 "EHLO
        mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816199AbaDGSFC0lsSL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 20:05:02 +0200
Received: by mail-pb0-f42.google.com with SMTP id rr13so7113033pbb.29
        for <multiple recipients>; Mon, 07 Apr 2014 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5GcOuJCgCtEPDvKF2ddo1DLoUjlyHHZU4YjiYWzmLjw=;
        b=sn0ORI5VLbmpyqJwkCnvyq02FGoKbqINntL4Z67S6dYhxL3xeUi+PvKYx7JzJxSB91
         UrQBiymqRQrEW//U0M4LplVJTNQlmYS+pwB/rWOlz/kvOWkA8R2bXcZBPFgv+Z+Ngb30
         gtMr7b2zxXxkrJfmyqvNgP/usFS0UQCpclDT7kwxRJIBXjnCjfKrMUCNnXR2niXTpDrH
         AN41tCi3eF/4rofptFEDvQB4ZEyUlGqPd3AguWOyM9P8XfstsiElVC0pPZVFbCRHLkbT
         TRIj0+7DAaA3RSHtqK+eqYYtwabIOIjqdsQjFonsBGmbn3Mh099KzDplU7acdS4ab/kp
         6NRQ==
X-Received: by 10.68.159.228 with SMTP id xf4mr32486385pbb.74.1396893882591;
 Mon, 07 Apr 2014 11:04:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.186.101 with HTTP; Mon, 7 Apr 2014 11:04:01 -0700 (PDT)
In-Reply-To: <20140407180246.GR17197@linux-mips.org>
References: <1396868224-252888-1-git-send-email-manuel.lauss@gmail.com>
 <1396868224-252888-2-git-send-email-manuel.lauss@gmail.com>
 <20140407135315.GX14803@pburton-linux.le.imgtec.org> <20140407162857.GQ17197@linux-mips.org>
 <CAGVrzcbV0sta4PyOoO+jMyOGc6rbT=hNjZTY_iDbi77ZjfUTfQ@mail.gmail.com> <20140407180246.GR17197@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Mon, 7 Apr 2014 11:04:01 -0700
Message-ID: <CAGVrzcZbFwhN90mYZC3aGQ71iEiBGfLEv21nTDxFDU9yXUqRdg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/2] MIPS: make FPU emulator optional
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2014-04-07 11:02 GMT-07:00 Ralf Baechle <ralf@linux-mips.org>:
> On Mon, Apr 07, 2014 at 09:37:42AM -0700, Florian Fainelli wrote:
>
>> There are some braindead bootloaders out there that will only allow
>> for a small kernel partition, while the rootfs partition can virtually
>> span the remainder of the available flash space... and all sorts of
>> crazy designs like these.
>
> In a case like that 50k are going to buy you a release or two of Moore's
> law applied to kernel bloat.
>
> How making the FPU emu a module?

busybox's init uses the FPU for some operations (can't remember the
details), which sort of creates a chicken and egg problem here.
-- 
Florian
