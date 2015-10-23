Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 23:30:39 +0200 (CEST)
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33667 "EHLO
        mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010009AbbJWVahfdXQr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 23:30:37 +0200
Received: by qgeo38 with SMTP id o38so77790742qge.0;
        Fri, 23 Oct 2015 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h4I+Y6DTGfhiI64RD+gNs8ou2MoQt5OoRGrVAYid0jE=;
        b=WUn0NN3DwuZ1pbFTvlfWfHCPpICcTvROfMZYvImaynMtoKVtw4PiVtMxg6K0aSbumJ
         C9lrj0XrscdXcHeE0erBzXj3KNuCZSbQXg717xJrQRkmjksjf9MWTrMepE223OI6x7M5
         GbVRp5LuAPNWWlUkECdhNbhhyZfVVZFK3S/SHPXWtSPIMDgwL/uXTgCe5NT4WrfojgYK
         KdTb6d+ZNVE2FflcZLrkxoTy+BKqqHPeuliZWG+730UqQQcxcN3f/wSbyWWnn8VcO460
         l/fQCaElrOtMkZIBrikW50oRMJE82KW5pUEIlTfgNTN3yPhE5gwQAcgTlN/25yv1QAIH
         lvbA==
X-Received: by 10.140.150.4 with SMTP id 4mr28060916qhw.35.1445635831763; Fri,
 23 Oct 2015 14:30:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.34.173 with HTTP; Fri, 23 Oct 2015 14:30:12 -0700 (PDT)
In-Reply-To: <20151023203511.GN13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <20151023035817.GA18907@mtj.duckdns.org> <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
 <20151023203511.GN13239@google.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Fri, 23 Oct 2015 14:30:12 -0700
Message-ID: <CAJiQ=7A6L1m3nd4UfU_EYE+LGi0mz6Jq9yy6xkfnOvJBSmsL6A@mail.gmail.com>
Subject: Re: [PATCH 00/10] add support SATA for BMIPS_GENERIC
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49674
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

On Fri, Oct 23, 2015 at 1:35 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> On Thu, Oct 22, 2015 at 09:51:30PM -0700, Florian Fainelli wrote:
>> 2015-10-22 20:58 GMT-07:00 Tejun Heo <tj@kernel.org>:
>> I think we have a bit too many compatible strings defined, I need to
>> lookup tomorrow when I am back in the office which BCM7xxx started
>> featuring a SATA3 AHCI compliant core, it might be 7420, but I am not
>> sure
>
> I thought it was BCM7425, but you probably have the resources to check
> better than I do.

It was originally introduced on 7422 A0 (40nm) and the test chip that
preceded it.  The production rev of 7422 uses the 7425 die, so
"BCM7425" is a good enough answer for our purposes.

BCM7420, BCM7400, and other 65nm SoCs had a ServerWorks SATA2 core on
an internal PCI-X bus.  These ran a modified version of sata_svw.c,
and could support QDMA.
