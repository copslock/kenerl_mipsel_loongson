Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 00:37:44 +0100 (CET)
Received: from mail-qc0-f170.google.com ([209.85.216.170]:64877 "EHLO
        mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006952AbaKYXhnUb4yY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 00:37:43 +0100
Received: by mail-qc0-f170.google.com with SMTP id x3so1325795qcv.29
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 15:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zjhr7pB/7BAqf5qyx/rRQEAxdodnzqyAr/msqy+J8ko=;
        b=MmrFeA8QaV8qRWhpySgaTg+u6KidIzM19sNEznKYM/YFg4DF+3ob8mX01xGxjxpiie
         ugu21qRrvcl3C3y85tC/DjmI2NIhdiLyyO2Ou6i5aAYutHLaLAmcD/DMUt2bWRzP56xi
         3Toa+UNOcHPkMFFGlXv54l1sGgyH1i1NrqWvxDUfLSx+EABkX+b3L/PBM5d9sinx4G4K
         iPfOLltWbi/VlmmAix9NCGouw7oUoH5dHhmpFlPmfpjQAIR6RI14vzNUQC5WPC8Vho24
         4uSwuzC0PbWlXRseQ3TZJriPfwo5jI/JXKHcR0aYen2Orn4zkvtq8Ho+H6GRvhzGZUVS
         o3Sw==
X-Received: by 10.224.121.1 with SMTP id f1mr21213919qar.76.1416958656870;
 Tue, 25 Nov 2014 15:37:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Tue, 25 Nov 2014 15:37:16 -0800 (PST)
In-Reply-To: <20141125203431.GA9385@kroah.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
 <1415825647-6024-2-git-send-email-cernekee@gmail.com> <20141125203431.GA9385@kroah.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Tue, 25 Nov 2014 15:37:16 -0800
Message-ID: <CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com>
Subject: Re: [PATCH V2 01/10] tty: Fallback to use dynamic major number
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, daniel@zonque.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        tushar.b@samsung.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Tue, Nov 25, 2014 at 12:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Nov 12, 2014 at 12:53:58PM -0800, Kevin Cernekee wrote:
>> From: Tushar Behera <tushar.behera@linaro.org>
>
> This email bounces, so I'm going to have to reject this patch.  I can't
> accept a patch from a "fake" person, let alone something that touches
> core code like this.
>
> Sorry, I can't accept anything in this series then.

Oops, guess I probably should have updated his address after the V1
emails bounced...

Before I send a new version, what do you think about the overall
approach?  Should we try to make serial8250 coexist with the other
"ttyS / major 4 / minor 64" drivers (possibly at the expense of
compatibility) or is it better to start with a simpler, cleaner driver
like serial/pxa?
