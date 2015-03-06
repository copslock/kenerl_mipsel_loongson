Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 17:25:15 +0100 (CET)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:44581 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012698AbbCFQZN5Jh-0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 17:25:13 +0100
Received: by iecar1 with SMTP id ar1so86707424iec.11
        for <linux-mips@linux-mips.org>; Fri, 06 Mar 2015 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KgiNMIyvHhKzB5u9FUJauXBWrM+5BG6X5rspnrx/6Pg=;
        b=MyrVwVX4sJDvz5J/oSzCWWjkp5mFKVYnFzdNPyW6yY28iNNboHtbOPPqvst/z5Nnft
         15aJzYOeye+9H6HgKoJ+f/s0OSqH/LpEXaf7y1x4x1ueNBfgoD4TN6taxR/rGheAX/sj
         FFxiB09mRV4bHwQyAUO4/gBIlTrpHF0n1vK9wvSwXJG14E0vRgUmVKPrcubjrTg92z6n
         4FZ1G/oWs6vkWuUzTFrJtaUghSkSSD7BUiXVmmBgKlRcVAIeBMLCSIZ7V1gujzZ7ci7G
         bSLaaFiYYeUAZXyDQGQoXl7oErX9ieHAV3T/Yfmm0ghC1CG+rIrvF0OC8bT0yHgf8oHb
         HvdA==
X-Received: by 10.50.114.4 with SMTP id jc4mr55189513igb.14.1425659108607;
        Fri, 06 Mar 2015 08:25:08 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id h15sm7215490ioh.27.2015.03.06.08.25.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 06 Mar 2015 08:25:08 -0800 (PST)
Message-ID: <54F9D4E2.20107@gmail.com>
Date:   Fri, 06 Mar 2015 08:25:06 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Aleksey Makarov <aleksey.makarov@auriga.com>,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Vinita Gupta <vgupta@caviumnetworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] SATA: OCTEON: support SATA on OCTEON platform
References: <1425567540-31572-1-git-send-email-aleksey.makarov@auriga.com> <54F97C27.508@redhat.com>
In-Reply-To: <54F97C27.508@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 03/06/2015 02:06 AM, Hans de Goede wrote:
> Hi,
>
> On 05-03-15 15:58, Aleksey Makarov wrote:
>> The OCTEON SATA controller is currently found on cn71XX devices.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>> ---
[...]
>> diff --git
>> a/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> new file mode 100644
>> index 0000000..59e86a7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> @@ -0,0 +1,28 @@
>> +* UCTL SATA controller glue
>> +
>> +Properties:
>> +- compatible: "cavium,octeon-7130-sata-uctl"
>> +
>> +  Compatibility with the cn7130 SOC.
>> +
>> +- reg: The base address of the UCTL register bank.
>> +
>> +- #address-cells, #size-cells, and ranges must be present and hold
>> +    suitable values to map all child nodes.
>> +
>> +Example:
>> +
>> +    uctl@118006c000000 {
>> +        compatible = "cavium,octeon-7130-sata-uctl";
>> +        reg = <0x11800 0x6c000000 0x0 0x100>;
>> +        ranges; /* Direct mapping */
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        sata: sata@16c0000000000 {
>> +            compatible = "cavium,octeon-7130-ahci";
>> +            reg = <0x16c00 0x00000000 0x0 0x200>;
>> +            interrupt-parent = <&cibsata>;
>> +            interrupts = <2 4>; /* Bit: 2, level */
>> +        };
>> +    };
>
> Sorry for jumping into this discussion a bit late, but this nonsense
> nesting of what clearly are 2 related but different hw blocks,
> both living at completely different register addresses is unacceptable,
> this is not a proper operating system dependent hw description as
> devicetree is supposed to be. This is an ugly hack to ensure a
> certain init ordering, and requiring manual instantiation of
> the platform device for the nested dt-node.
>
> NACK.

Can you point to the portion of the device tree specification that 
states that if a node has both "reg" *and* "ranges" properties, the 
parent-bus-address ranges must be a proper subset of the "reg" property 
ranges of the parent?   Because that seems like what you are saying 
here.  I would really like to read the documentation myself so that we 
can get a better understanding of the requirements.

For what it's worth, there are existing bindings that take the same 
form, and they don't seem to break anything.  See for example 
Documentation/devicetree/bindings/mips/cavium/uctl.txt

In any event, it is somewhat moot at this point.  The device tree being 
effectively being a frozen ABI, cannot really be changed.  We are merely 
documenting what is supplied by the preexisting system boot ROMs, not 
starting from scratch and discussing what the proper device tree binding 
for the device should be.

Thanks,
David Daney


[...]
