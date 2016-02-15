Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 18:53:03 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.15]:52673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012393AbcBORxAzyqSr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Feb 2016 18:53:00 +0100
Received: from [192.168.123.49] ([37.24.8.189]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0Lfjxq-1aBBzX0z3C-00pJyj; Mon, 15 Feb 2016 18:52:33
 +0100
Subject: Re: [PATCH 1/1] MIPS: DTS: cavium-octeon: provide model attribute
To:     Arnd Bergmann <arnd@arndb.de>
References: <1455513977-934-1-git-send-email-xypron.glpk@gmx.de>
 <56C1B3A0.4090301@cogentembedded.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Enigmail-Draft-Status: N1110
Message-ID: <56C21054.4070702@gmx.de>
Date:   Mon, 15 Feb 2016 18:52:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
In-Reply-To: <56C1B3A0.4090301@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:QUJsLHNWzrTwM2fZ4TskgWDbFLmyk/zhTnEaBBQ0PBXKAYcDKF3
 cu/aedVP35eeNq5WrvCQB0UV/8QIYL1D0nmu8J7eFKR8a9lFQC3pG11fJ4VWAyPrC75O06f
 cIV3NxMlhwdf67AJjQGS29qOFkzTAslM03g0dJ4AH5tJWMT86JnUT/S5zelwLpBisZAJO7h
 whhoqQj8Xv2fHyqYthjAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j0cqIy0fYGY=:n2NHV2D1xDS6wfpBQDP1My
 FgC14VBJigotXh6D5xgq2I8OttUmEmrLgOquiBPbvHywsVWwYqCS11CVhjWMGCzfkxF80TA5A
 zwhYKxIIGzMRux0lSENDGjFWJaSLp99XqknUWXwkoxkqIc0kvXpcA3m19xCFgn3qLaRUzTk6h
 dpvw2hpr3j0JQaPwWwFz0dfkHGDnfmrJ+e3dj/0jWbAbwqEZ8x0oahSN0HqzieVPcfO5TbLpB
 nBfYgTL1LkWKhLuZSBDFdzNFYb1Nr3aZm64I21MmdW6RJSb6VsbR8WWIciYYusAF2wNosQHh7
 Y2yAT228vQJpmzVnAlUPwS93HDQpyNljAURgTOmaUTXom7Jkjm208w7qHecFbZVRSkUPCXICo
 UHxzMEE+tWzD9jdQxVgY7vt9tu0nHQSUEpL2KU/DlykDxfQ2a0ojheO05trNeGDSMvVnSGuhk
 0NCtAoB/693Uw+1u5Zisac3UJwgcGyJUpXJadprl7IkQr8wHeSG3YozoyxuD1eywgubq7m0O9
 VgCR2u8QPyq12ICPdl6WTRXbV6GQr7B7tBamx3qiiPuc1e6ThlFK2j7Xe2XOVJXl0euXU8agk
 D0c42Pow5Pdh8lkY+TT1X9PdMb0Zbg7+Fd8ErYXimU3eYGjRFv8FwWjvws8zdM/0LwU13iZu5
 xS+Gcl4XDrZsY7YMRk5mVH1IW9CW7hZyT1z2Kvlw7fjNtKalJ293z4a+VehLZIPMT3ZlMOVCM
 sqDC7Hg3ZFidL4p/X8sgRZDjU7/qG1dVyPmphbro7pvwW6IikrAWNfCZIJJ+VaJVVv8JtT9pW
 N8Qnr/0
Return-Path: <xypron.glpk@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xypron.glpk@gmx.de
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

On 02/15/2016 12:16 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 2/15/2016 8:26 AM, Heinrich Schuchardt wrote:
> 
>> Downstream packages like Debian flash-kernel rely on
>> /proc/device-tree/model
>> to determine how to install an updated kernel image.
>>
>> Most dts files provide this property.
>> It is suggested by IEEE Std 1275-1994.
>>
>> This patch adds a model attribute for Octeon CPUs.
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>   arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts | 1 +
>>   arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
>> b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
>> index 9c48e05..a746678 100644
>> --- a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
>> +++ b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
>> @@ -8,6 +8,7 @@
>>    */
>>   / {
>>       compatible = "cavium,octeon-3860";
>> +    model = "Cavium Octeon 3XXX";
>>       #address-cells = <2>;
>>       #size-cells = <2>;
>>       interrupt-parent = <&ciu>;
>> diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
>> b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
>> index 79b46fc..c8a292a 100644
>> --- a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
>> +++ b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
>> @@ -8,6 +8,7 @@
>>    */
>>   / {
>>       compatible = "cavium,octeon-6880";
>> +    model = "Cavium Octeon 68XX";
>>       #address-cells = <2>;
>>       #size-cells = <2>;
>>       interrupt-parent = <&ciu2>;
> 
>     The ePAPR 1.1 standard says:
> 
> 2.3.2 model
> 
> Property: model
> Value type: <string>
> Description:
>     The model property value is a <string> that specifies the
>      manufacturer’s model number of the device.
> 
>     The recommended format is: “manufacturer,model”, where manufacturer
>     is a string describing the name of the manufacturer (such as a stock
>     ticker symbol), and model specifies the model number.
> 
> Example:
>     model = “fsl,MPC8349EMITX”;
> 
> MBR, Sergei
> 
> 

Hello Sergei, hello Arnd,

thank you for reviewing.

IEEE Std 1275-1994 says stock symbols should be in upper case.

I guess international standards should have precedence over papers valid
for a single architecture (power.org).

Would you support a patch having the following strings?

model = "CAVM, Octeon 3860";
model = "CAVM, Octeon 6880";

Otherwise, please, make a suggestion.

Best regards

Heinrich Schuchardt
