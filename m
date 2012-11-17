Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Nov 2012 05:15:26 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:56922 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821443Ab2KQEPZyhDmK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Nov 2012 05:15:25 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id BEDF66234;
        Fri, 16 Nov 2012 21:16:45 -0700 (MST)
Received: from dart.wwwdotorg.org (unknown [IPv6:2001:470:bb52:63:5d70:fb63:5917:494d])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 52DEFE40EF;
        Fri, 16 Nov 2012 21:15:24 -0700 (MST)
Message-ID: <50A70F5C.3030205@wwwdotorg.org>
Date:   Fri, 16 Nov 2012 21:15:24 -0700
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
MIME-Version: 1.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] MIPS: BCM63XX: add Device Tree clock definitions
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com> <1352638249-29298-10-git-send-email-jonas.gorski@gmail.com> <50A1D452.2020904@wwwdotorg.org> <CAOiHx=m=OxDiXKozQG1_iUBDhWj3iJDd9b8LHP_6mPL=FOyGPQ@mail.gmail.com>
In-Reply-To: <CAOiHx=m=OxDiXKozQG1_iUBDhWj3iJDd9b8LHP_6mPL=FOyGPQ@mail.gmail.com>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 35031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/14/2012 05:11 AM, Jonas Gorski wrote:
> On 13 November 2012 06:02, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 11/11/2012 05:50 AM, Jonas Gorski wrote:
>>> Add definitions for the clocks found and used in all supported SoCs.
>>
>>> diff --git a/arch/mips/bcm63xx/dts/bcm6328.dtsi b/arch/mips/bcm63xx/dts/bcm6328.dtsi
>>
>>> +                     clocks {
>>> +                             #address-cells = <1>;
>>> +                             #size-cells = <0>;
>>> +
>>> +                             periph: pll {
>>> +                                     compatible = "brcm,bcm63xx-clock";
>>> +                                     #clock-cells = <0>;
>>> +                                     clock-frequency = <50000000>;
>>> +                                     clock-output-names = "periph";
>>> +                             };
>>
>> Here too, it seems like some reg properties would be required.
> 
> This is more or less a dummy clock with no real backing for it, but
> some of the drivers expect this clock to be present (even just to get
> the frequency).

Should compatible="fixed-clock" then if this is just a dummy? Ideally
though, nothing "dummy" would be added to the DT; the kernel would
continue to provide the dummy values via code until the DT was able to
fully represent the actual HW.
