Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 05:05:58 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:7264 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006153AbbKZEFyVejO9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Nov 2015 05:05:54 +0100
Received: from [127.0.0.1] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Wed, 25 Nov 2015
 21:05:46 -0700
Subject: Re: [PATCH 03/14] DEVICETREE: Add PIC32 clock binding documentation
To:     Arnd Bergmann <arnd@arndb.de>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-4-git-send-email-joshua.henderson@microchip.com>
 <7182714.6Xmo6Noc6V@wuerfel>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56568519.3060308@microchip.com>
Date:   Wed, 25 Nov 2015 21:05:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <7182714.6Xmo6Noc6V@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

Hi Arnd,

On 11/21/2015 1:49 PM, Arnd Bergmann wrote:
> On Friday 20 November 2015 17:17:15 Joshua Henderson wrote:
>> +/* PIC32 specific clks */
>> +pic32_clktree {
>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +       reg = <0x1f801200 0x200>;
>> +       compatible = "microchip,pic32-clk";
>> +       interrupts = <12>;
>> +       ranges;
>> +
>> +       /* secondary oscillator; external input on SOSCI pin */
>> +       SOSC:sosc_clk {
>> +               #clock-cells = <0>;
>> +               compatible = "microchip,pic32-sosc";
>> +               clock-frequency = <32768>;
>> +               reg = <0x1f801200 0x10   /* enable reg */
>> +                       0x1f801390 0x10>; /* status reg */
>> +               microchip,bit-mask = <0x02>; /* enable mask */
>> +               microchip,status-bit-mask = <0x10>; /* status-mask*/
>> +       };
>>
> 
> If you want to use the reg property in this way for each cell,
> at least use a 'ranges' that only translates the actual registers
> like this
> 
> 	ranges = <0 0x1f801200 0x200>
> 
> 	sosc_clk {
> 		...
> 		reg = <0x000 0x10>, <0x190 0x10>;
> 		...
> 	};
> 
> 	Arnd
> 

This does indeed seem to be the correct way to use ranges in this case.  Consider it done.

Thanks for the feedback,
Josh
