Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 22:35:21 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33757 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008629AbbJWUfUB1NPI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 22:35:20 +0200
Received: by pabrc13 with SMTP id rc13so126880254pab.0;
        Fri, 23 Oct 2015 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=M42N84k1AEg5xLf9QPZiwmup+wgWUdq+Ov/LruwXpno=;
        b=q0aXNcDbK7J8hxa9PM810lwhHe4LNBAHz8sGBQxPzmvnHNhqKyYZ0iwN3XtQA1ryHc
         wdjWHymhigEduDbpzMylrykZWGBFP8e9Y9rIftaSeIx2RL9ALIqfp/xI0v70KGitBuoZ
         QQD8rXvNKKTkTkWQV8GGpcJ+08ps6aBBkbfdWCeC61oOBsnXGNctVShBWXTrL0pSrlbo
         MSsr0o5MF6vfqwRHN/D9tdtMIEVdZdWS/cf3a6A3HZhRs1c7iok7A41ZpFk/o5KiIosh
         jPGldb6x+6RA1l/IaWBQxyRSJnMKD04gU/yEtwIZ3oz6RPeAHTsAQFZKcREKZ9a2Sj4s
         roFw==
X-Received: by 10.68.57.137 with SMTP id i9mr25892047pbq.101.1445632513968;
        Fri, 23 Oct 2015 13:35:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:2c06:ba91:afc7:e14d])
        by smtp.gmail.com with ESMTPSA id ou1sm14763277pbc.7.2015.10.23.13.35.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Oct 2015 13:35:13 -0700 (PDT)
Date:   Fri, 23 Oct 2015 13:35:11 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 00/10] add support SATA for BMIPS_GENERIC
Message-ID: <20151023203511.GN13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <20151023035817.GA18907@mtj.duckdns.org>
 <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Thu, Oct 22, 2015 at 09:51:30PM -0700, Florian Fainelli wrote:
> 2015-10-22 20:58 GMT-07:00 Tejun Heo <tj@kernel.org>:
> I think we have a bit too many compatible strings defined, I need to
> lookup tomorrow when I am back in the office which BCM7xxx started
> featuring a SATA3 AHCI compliant core, it might be 7420, but I am not
> sure

I thought it was BCM7425, but you probably have the resources to check
better than I do.

There were also some small (probably mostly undocumented) bugfixes at
some point. I think the early cores actually had problems with the
upstream libahci. You might look at AHCI_HFLAG_DELAY_ENGINE for that, if
you care.

You might also notice that the "strict-ahci" stuff we were using got
dropped:

commit f1df8641e27b7edb978bdc7aaf50c235bc9e8be9
Author: Hans de Goede <hdegoede@redhat.com>
Date:   Sat Feb 22 17:22:53 2014 +0100

    ahci_platform: Drop support for ahci-strict platform device type

But that's less relevant, now that there's a proper brcmstb driver.

Brian
