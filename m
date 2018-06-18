Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 11:42:28 +0200 (CEST)
Received: from mga14.intel.com ([192.55.52.115]:34864 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994551AbeFRJmUbTyz- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jun 2018 11:42:20 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 02:42:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="58489031"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.15]) ([10.226.39.15])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2018 02:42:14 -0700
Subject: Re: [PATCH 1/7] MIPS: dts: Add aliases node for lantiq danube serial
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-2-songjun.wu@linux.intel.com>
 <CAK8P3a1=CBahrEE2uDRfdrSi=ALc5LBED1=KbLbLa40c9H8dmQ@mail.gmail.com>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <539411c1-82b7-cf76-71cf-d50f3303f50f@linux.intel.com>
Date:   Mon, 18 Jun 2018 17:42:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1=CBahrEE2uDRfdrSi=ALc5LBED1=KbLbLa40c9H8dmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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



On 6/14/2018 6:03 PM, Arnd Bergmann wrote:
> On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
>> Previous implementation uses a hard-coded register value to check if
>> the current serial entity is the console entity.
>> Now the lantiq serial driver uses the aliases for the index of the
>> serial port.
>> The lantiq danube serial dts are updated with aliases to support this.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
>>
>>   arch/mips/boot/dts/lantiq/danube.dtsi | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
>> index 2dd950181f8a..7a9e15da6bd0 100644
>> --- a/arch/mips/boot/dts/lantiq/danube.dtsi
>> +++ b/arch/mips/boot/dts/lantiq/danube.dtsi
>> @@ -4,6 +4,10 @@
>>          #size-cells = <1>;
>>          compatible = "lantiq,xway", "lantiq,danube";
>>
>> +       aliases {
>> +               serial0 = &asc1;
>> +       };
>> +
> You generally want the aliases to be part of the board specific file,
> not every board numbers their serial ports in the same way.
>
>         Arnd
In this chip only asc1 can be used as console,  so serial0 is defined in 
chip specific file.
