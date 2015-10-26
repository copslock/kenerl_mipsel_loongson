Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2015 18:47:39 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35717 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011264AbbJZRrg2yazb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2015 18:47:36 +0100
Received: by pasz6 with SMTP id z6so194453321pas.2;
        Mon, 26 Oct 2015 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y1M0mUP7o4QIIuQv7vXtFKSwD8MUVAEZXf4/zfVD+AA=;
        b=DG2mIjDMGoCPXJDU8IW7LNryTyJZ06jfBvMBf78Sy1xVhzWQKgwOUmDRLME00Ezbd1
         g0YT72NQ9Ikvg1ZpXLKlacjYwuBt6ZCEH/XD72kP3dTIPAbkQ9f0EvLMjS3fYOhO1Y77
         1JapaznntiPlsamolBuAOHyMm0HjG4YErnRAqwaAsSNox5Sqteq2+5KExpuCJCrswXTw
         SckKEoL6Y5x1crfMjftOsosQOY9xmL7RUgoAOFZH+Kgm36D2IK8Ajg8wYoJseClI5bmi
         xIDbAgttkBgm8ccGE3/sppHPTEDXF6GEOnKBVmAV+NJVLBjVpgJS1IVzSD2b291727/c
         X+fQ==
X-Received: by 10.68.255.37 with SMTP id an5mr23079197pbd.163.1445881650423;
        Mon, 26 Oct 2015 10:47:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:493:9c13:2386:b1f3])
        by smtp.gmail.com with ESMTPSA id zn9sm35324707pac.48.2015.10.26.10.47.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Oct 2015 10:47:29 -0700 (PDT)
Date:   Mon, 26 Oct 2015 10:47:27 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 03/10] ata: ahci_brcmstb: add support 40nm platforms
Message-ID: <20151026174727.GZ13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
 <20151023212558.GS13239@google.com>
 <DE776F55-6D75-4AD7-B3AA-52E45C9D99C0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE776F55-6D75-4AD7-B3AA-52E45C9D99C0@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49702
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

Hi Jaedon,

On Sat, Oct 24, 2015 at 01:50:54PM +0900, Jaedon Shin wrote:
> On Oct 24, 2015, at 6:25 AM, Brian Norris <computersforpeace@gmail.com> wrote:
> > On Fri, Oct 23, 2015 at 10:44:16AM +0900, Jaedon Shin wrote:
> > So, your patch gets phy control 1 correct for both ports, but it doesn't
> > get phy control 2 correct. (Or at least, even if my guess at the 40nm
> > layout is wrong, your patch makes "port 0, phy control 2" collide with
> > "port 1, phy control 1", which is most certainly a bug.)
> > 
> > Are you sure you're testing this properly? Did you try using both ports
> > at the same time? And please, apply the same scrutiny to the PHY driver.
> > (e.g., did you test SSC? did you test both ports?)
> > 
> > Brian
> > 
> 
> You are right. This must be changed. 
> 
> I found the 28nm chipsets have four phy interface control registers. But, 
> the the 40nm chipsets have only three registers. I did not testing with 
> two ports at the same time. It seems we should check more.

OK. So you don't just need more testing, you need to make sure the code
actually matches the documentation at all. If there are only 3 PHY
control registers for 40nm, then this driver (as patched by you) doesn't
make any sense. It will need a much different patch than what you gave.

Brian
