Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Oct 2015 06:51:24 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33696 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008338AbbJXEvT7fucW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Oct 2015 06:51:19 +0200
Received: by pabrc13 with SMTP id rc13so135138940pab.0;
        Fri, 23 Oct 2015 21:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TgvVFd4R/34rMdoHU7XOCjoTwV0axC7bP5TG/BGCveM=;
        b=YoQwwvIyJz4HEFGi7zNrb1S31r+nPIId+/o99HdENhIFfSWQQJJq/VR4mRxNS+2zZX
         gRx/gROZWx3esJ+EKL6slBa9bhCl0Veuk7VBhPQraZ7vcE4IzuiiUWgZAODX2tIehbkj
         lMAaq7/S+Y2a3ETn4X4UDvER3jzK9f3sTA/++V7pu/zahbB6IIDNhjDvR1HPB5Mp6qMx
         Zu8Q2BeIsNfFFSzF2P26/pfGDtCLdtD5whrre38PjokmdPWJRXo+Gqaa6T5NBnb/Lp3E
         /TSfTAgtsS0WKhNEmQfguV1+1kKj1x0wDcipOZOOZBItcblQwXvOS087nkgNQcXTsX9P
         1LzA==
X-Received: by 10.69.2.164 with SMTP id bp4mr9118821pbd.109.1445662273986;
        Fri, 23 Oct 2015 21:51:13 -0700 (PDT)
Received: from [192.168.0.105] ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id im9sm21814786pbc.1.2015.10.23.21.51.10
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Oct 2015 21:51:13 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 00/10] add support SATA for BMIPS_GENERIC
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
Date:   Sat, 24 Oct 2015 13:51:10 +0900
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <E3E038D1-BD83-49D8-887A-B215AA685701@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <20151023035817.GA18907@mtj.duckdns.org> <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

On Oct 23, 2015, at 1:51 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> 2015-10-22 20:58 GMT-07:00 Tejun Heo <tj@kernel.org>:
>> On Fri, Oct 23, 2015 at 10:44:13AM +0900, Jaedon Shin wrote:
>>> Hi all,
>>> 
>>> This patch series adds support SATA for BMIPS_GENERIC.
>>> 
>>> Ralf,
>>> I request you to drop already submitted patches for NAND device nodes.
>>> It is merge conflicts with this patches.
>>> http://patchwork.linux-mips.org/patch/10577/
>>> http://patchwork.linux-mips.org/patch/10578/
>>> http://patchwork.linux-mips.org/patch/10579/
>>> http://patchwork.linux-mips.org/patch/10580/
>>> 
>>> Jaedon Shin (10):
>>>  ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
>>>  ata: ahch_brcmstb: add data for port offset
>>>  ata: ahci_brcmstb: add support 40nm platforms
>> 
>> ata part looks fine to me.  Let me know when the other parts get in.
>> I'll apply the ata ones to libata/for-4.4.
> 
> There are a few comments coming on the ATA and Device Tree part, and I
> also would like Brian Norris (who submitted the patches) to take a
> look at these. But overall, this looks great.
> 
> I think we have a bit too many compatible strings defined, I need to
> lookup tomorrow when I am back in the office which BCM7xxx started
> featuring a SATA3 AHCI compliant core, it might be 7420, but I am not
> sure
> 

I agree with you. If you have good opinion, I want you to tell me.

> Thanks!
> -- 
> Florian

I will review carefully and submit v2 revision.

Regards,

Jaedon
