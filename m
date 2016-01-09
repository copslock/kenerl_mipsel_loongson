Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jan 2016 01:27:48 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:35554 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010157AbcAIA1p1Em96 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Jan 2016 01:27:45 +0100
Received: from [10.14.4.125] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Fri, 8 Jan 2016
 17:27:37 -0700
Subject: Re: [PATCH v3 05/14] dt/bindings: Add bindings for PIC32/MZDA
 platforms
To:     Antony Pavlov <antonynpavlov@gmail.com>
References: <1452211389-31025-1-git-send-email-joshua.henderson@microchip.com>
 <1452211389-31025-6-git-send-email-joshua.henderson@microchip.com>
 <20160108133739.9a9c63c18fee346098354b21@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <569055C5.9040003@microchip.com>
Date:   Fri, 8 Jan 2016 17:35:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <20160108133739.9a9c63c18fee346098354b21@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50987
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

On 01/08/2016 03:37 AM, Antony Pavlov wrote:
> On Thu, 7 Jan 2016 17:00:20 -0700
> Joshua Henderson <joshua.henderson@microchip.com> wrote:
> 
>> This adds support for the Microchip PIC32 platform along with the
>> specific variant PIC32MZDA on a PIC32MZDA Starter Kit.
>>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../bindings/mips/pic32/microchip,pic32mzda.txt    |   33 ++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt b/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
>> new file mode 100644
>> index 0000000..bcf3e04
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
>> @@ -0,0 +1,33 @@
>> +* Microchip PIC32MZDA Platforms
>> +
>> +PIC32MZDA Starter Kit
>> +Required root node properties:
>> +    - compatible = "microchip,pic32mzda-sk", "microchip,pic32mzda"
>> +
>> +CPU nodes:
>> +----------
>> +A "cpus" node is required.  Required properties:
>> + - #address-cells: Must be 1.
>> + - #size-cells: Must be 0.
>> +A CPU sub-node is also required.  Required properties:
>> + - device_type: Must be "cpu".
>> + - compatible: Must be "mti,mips14KEc".
>> +Example:
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "mti,mips14KEc";
>> +		};
>> +	};
>> +
>> +Boot protocol
>> +--------------
>> +In accordance with the MIPS UHI specification[1], the bootloader must pass the
>> +following arguments to the kernel:
>> + - $a0: -2.
>> + - $a1: KSEG0 address of the flattened device-tree blob.
>> +
>> +[1] http://prplfoundation.org/wiki/MIPS_documentation
> 
> At the moment the link [1] does not work. It is redirected to nonexisting "http://wiki.prplfoundation.org//MIPS_documentation" (prplfoundation.org site problem?).
> 
> The http://wiki.prplfoundation.org/wiki/MIPS_documentation URL works.
> 
> The "MIPS documentation" wiki page contains many documents so can we use 
> more accurate URL, e.g. http://wiki.prplfoundation.org/wiki/MIPS_documentation#Unified_Hosting_Interface ?
> 
> Can we use more strict name for "MIPS UHI specification", e.g. "Unified Hosting Interface Reference Manual (MD01069)"?
> 

I agree.  I will reference the name of the complete specification as suggested, however, it looks like it may be safer to drop the URL.  Search does a better job here.

> -- 
> Best regards,
>   Antony Pavlov
> 

Josh
