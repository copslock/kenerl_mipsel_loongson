Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 21:27:08 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:60620 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008830AbbLMU1GV1TGA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 21:27:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=tao75H1Wib6kk5xz+3bl6Qs3Uu3MG5JpQUkMfMpcOJ8=;
        b=seM7qNsV0vzJcQb6Zf4F0Bdx8UEwJ7wic5NITiU9cgBBNOMmP57lcSu9gJwI5rWxNLSjrnLonSA8ccxZQZ6fhKMy/zvUZosmvD7OOFgik25lg87RgnsCtMAwBs02zj47ZN77nw+3FegezIeCDGcDRrSRaNZf4pztemxdZvxXvo6gxlKeDlvQmKrZ7TGWmpK4tE7Ze5xwhFhiubEtS0McWnLj/YQIoAxs/J2g1FSM/OHrAn5Jyf2u9zhIBF11quDjgT0XVMKZVVEZadrkRhdjAI3IWw+o51HCRrzahJT6r3OCyalTKaYC6EEBGfgMlbzYfKS1kIMqxSVhVDb9fG5iGQ==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44162 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8DER-00057c-T8 (Exim); Sun, 13 Dec 2015 20:27:00 +0000
Subject: Re: [PATCH linux-next (v3) 3/3] mtd: part: Add BCM962368 CFE
 partitioning support
To:     Jonas Gorski <jogo@openwrt.org>
References: <566B460F.1040603@simon.arlott.org.uk>
 <566B47D9.8020105@simon.arlott.org.uk>
 <CAOiHx==GSwCxWmaQfmHHumGu_ye6waf-DA_5+m8_Ukc1hVeBYg@mail.gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-api@vger.kernel.org
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <566DD491.4030902@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 20:26:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <CAOiHx==GSwCxWmaQfmHHumGu_ye6waf-DA_5+m8_Ukc1hVeBYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

On 11/12/15 23:12, Jonas Gorski wrote:
> On Fri, Dec 11, 2015 at 11:02 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
>> +#define BCM63XX_CFE_MAGIC_OFFSET       0x4e0
>> +#define BCM963XX_CFE_VERSION_OFFSET    0x570
>> +#define BCM963XX_NVRAM_OFFSET          0x580
> 
> You should decide whether you want to call it BCM63XX (the SoC) or
> BCM963XX (the Board using the SoC). Also probably better served in
> bcm963xx_nvram.h

I'm going to name the CFE locations, nvram and anything that is a
property of the flash layout BCM963XX_*, as a theoretical board using
BCM63XX with no flash wouldn't use these. The parser is still called
bcm63xxpart so that's currently an anomaly.

I'm working on making it support both NOR and NAND flash layouts.

-- 
Simon Arlott
