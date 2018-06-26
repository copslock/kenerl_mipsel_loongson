Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2018 09:13:42 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:50670 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992442AbeFZHNdhgjkA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jun 2018 09:13:33 +0200
Subject: Re: [PATCH 10/25] dt-bindings: PCI: qcom,ar7100: adds binding doc
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20180625171549.4618-1-john@phrozen.org>
 <20180625171549.4618-11-john@phrozen.org>
 <5926a597-b2fd-47f8-3a58-bf05d0b7da97@cogentembedded.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <0d386f69-5f28-edad-e6a7-587a8ed99622@phrozen.org>
Date:   Tue, 26 Jun 2018 09:13:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5926a597-b2fd-47f8-3a58-bf05d0b7da97@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 25/06/18 20:06, Sergei Shtylyov wrote:
> On 06/25/2018 08:15 PM, John Crispin wrote:
>
>> With the driver being converted from platform_data to pure OF, we need to
>> also add some docs.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: John Crispin <john@phrozen.org>
>> ---
>>   .../devicetree/bindings/pci/qcom,ar7100-pci.txt    | 36 ++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt b/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
>> new file mode 100644
>> index 000000000000..97be7b0c4cf9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
>> @@ -0,0 +1,36 @@
>> +* Qualcomm Atheros AR7100 PCI express root complex
>> +
>> +Required properties:
>> +- compatible: should contain "qcom,ar7100-pci" to identify the core.
>> +- reg: Should contain the register ranges as listed in the reg-names property.
>> +- reg-names: Definition: Must include the following entries
>> +	- "cfg_base"	IO Memory
>> +- #address-cells: set to <3>
>> +- #size-cells: set to <2>
>> +- ranges: ranges for the PCI memory and I/O regions
>> +- interrupt-map-mask and interrupt-map: standard PCI
>> +	properties to define the mapping of the PCIe interface to interrupt
>> +	numbers.
>> +- #interrupt-cells: set to <1>
>> +- interrupt-parent: phandle to the MIPS IRQ controller
>     Never a required prop, can be "inherited" from the parent node.
>
>> +- interrupt-controller: define to enable the builtin IRQ cascade.
>> +
>> +* Example for ar7100
>> +	pcie0: pcie-controller@180c0000 {
>     Name it just "pcie@180c0000", please.
>
> [...]
>
> MBR, Sergei
>

Thanks, fixed in my local tree, also for the ar7240 doc. I'll wait to 
see what other feedback i get before sending a V2
     John
