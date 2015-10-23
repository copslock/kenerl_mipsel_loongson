Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 06:52:17 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35416 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008247AbbJWEwQWXnuk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 06:52:16 +0200
Received: by igbkq10 with SMTP id kq10so9092972igb.0;
        Thu, 22 Oct 2015 21:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=24iwnOi+DL8KbUlkCSrl+M2PsqMuJPqQKCtubFZGOEs=;
        b=F9zVr4yYiLzsAVxJ4ZUYPoK+RkOQVoWIM0UqRZiFE6iKhGdNY2eKtvlk7WRq/MZIjb
         cVWqq7AeV7MHsNzqNkReW5lF+VtXC8hLhezglYBJINynWd+glteEanlPMgqdY2lhoc0x
         pSKUNoi9XPib7Kdre7PGLBSRzxDb/2HnaUMwrrPiKdpikQ/V4a4Hib/kxShMa2IuTKRc
         DOf35MjbWnKcoJ+B+perkDUpvMIgc0uzAgR8GoRPql1dVZ23OcY2Qw0xf7/hEYIfkb9Z
         sRWpsn5262rj8n6pP7LJzfWhNjrfLZTXKFKGw+T+Mw/LNS775SrGSRxEwJcI6KS31NXw
         LwoA==
X-Received: by 10.50.43.162 with SMTP id x2mr2110912igl.82.1445575930130; Thu,
 22 Oct 2015 21:52:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.165 with HTTP; Thu, 22 Oct 2015 21:51:30 -0700 (PDT)
In-Reply-To: <20151023035817.GA18907@mtj.duckdns.org>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <20151023035817.GA18907@mtj.duckdns.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 22 Oct 2015 21:51:30 -0700
Message-ID: <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
Subject: Re: [PATCH 00/10] add support SATA for BMIPS_GENERIC
To:     Tejun Heo <tj@kernel.org>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49653
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

2015-10-22 20:58 GMT-07:00 Tejun Heo <tj@kernel.org>:
> On Fri, Oct 23, 2015 at 10:44:13AM +0900, Jaedon Shin wrote:
>> Hi all,
>>
>> This patch series adds support SATA for BMIPS_GENERIC.
>>
>> Ralf,
>> I request you to drop already submitted patches for NAND device nodes.
>> It is merge conflicts with this patches.
>> http://patchwork.linux-mips.org/patch/10577/
>> http://patchwork.linux-mips.org/patch/10578/
>> http://patchwork.linux-mips.org/patch/10579/
>> http://patchwork.linux-mips.org/patch/10580/
>>
>> Jaedon Shin (10):
>>   ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
>>   ata: ahch_brcmstb: add data for port offset
>>   ata: ahci_brcmstb: add support 40nm platforms
>
> ata part looks fine to me.  Let me know when the other parts get in.
> I'll apply the ata ones to libata/for-4.4.

There are a few comments coming on the ATA and Device Tree part, and I
also would like Brian Norris (who submitted the patches) to take a
look at these. But overall, this looks great.

I think we have a bit too many compatible strings defined, I need to
lookup tomorrow when I am back in the office which BCM7xxx started
featuring a SATA3 AHCI compliant core, it might be 7420, but I am not
sure

Thanks!
-- 
Florian
