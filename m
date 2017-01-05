Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jan 2017 19:28:41 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:53639 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992328AbdAES2dZ-xxa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Jan 2017 19:28:33 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id B5FD12E6E0;
        Thu,  5 Jan 2017 19:28:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Hywul1CVwbWG; Thu,  5 Jan 2017 19:28:26 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bes.se.axis.com (Postfix) with ESMTPS id 5B4402E6DD;
        Thu,  5 Jan 2017 19:28:26 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23EA21E074;
        Thu,  5 Jan 2017 19:28:26 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 183CF1E072;
        Thu,  5 Jan 2017 19:28:26 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Thu,  5 Jan 2017 19:28:26 +0100 (CET)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
        by thoth.se.axis.com (Postfix) with ESMTP id 0B13F76E;
        Thu,  5 Jan 2017 19:28:26 +0100 (CET)
Received: from [10.88.4.10] (10.0.5.60) by XBOX02.axis.com (10.0.5.16) with
 Microsoft SMTP Server (TLS) id 15.0.1210.3; Thu, 5 Jan 2017 19:28:25 +0100
Subject: Re: Re: [PATCH] MIPS: NI 169445 board support
To:     Nathan Sullivan <nathan.sullivan@ni.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <1480693329-22265-1-git-send-email-nathan.sullivan@ni.com>
 <20161220163434.GA15962@linux-mips.org>
 <20170104163836.GA18069@nathan3500-linux-VM>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Lars Persson <larper@axis.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
From:   Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <5d5a087f-68ec-e633-0232-0248edf11ee0@axis.com>
Date:   Thu, 5 Jan 2017 19:28:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170104163836.GA18069@nathan3500-linux-VM>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX01.axis.com (10.0.5.15) To XBOX02.axis.com (10.0.5.16)
X-TM-AS-GCONF: 00
Return-Path: <niklas.cassel@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: niklas.cassel@axis.com
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

On 01/04/2017 05:38 PM, Nathan Sullivan wrote:
> On Tue, Dec 20, 2016 at 05:34:34PM +0100, Ralf Baechle wrote:
>> On Fri, Dec 02, 2016 at 09:42:09AM -0600, Nathan Sullivan wrote:
>>> Date:   Fri, 2 Dec 2016 09:42:09 -0600
>>> From: Nathan Sullivan <nathan.sullivan@ni.com>
>>> To: ralf@linux-mips.org, mark.rutland@arm.com, robh+dt@kernel.org
>>> CC: linux-mips@linux-mips.org, devicetree@vger.kernel.org,
>>>  linux-kernel@vger.kernel.org, Nathan Sullivan <nathan.sullivan@ni.com>
>>> Subject: [PATCH] MIPS: NI 169445 board support
>>> Content-Type: text/plain
>>>
>>> Support the National Instruments 169445 board.
>> Nathan,
>>
>> I assume you're going to repost the changes Rob asked for in
>> https://patchwork.linux-mips.org/patch/14641/#26924 and resubmit?
>>
>> Thanks,
>>
>>   Ralf
> Hmm, I found the issue with the generic MIPS config and dwc_eth_qos.  The NIC
> driver attempts to cache align a descriptor ring using the ___cacheline_aligned
> attribute on the descriptor struct, in combination with a "skip" feature in
> hardware.  However, the skip feature only has a three bit field, and the generic
> MIPS config selects MIPS_L1_CACHE_SHIFT_7.  So, the line size is 128, and with a
> 64-bit bus, that means the NIC descriptor skip field would need to be set to
> 14 to align the 16-byte descriptors...
>
> I guess it makes sense for a generic MIPS kernel to align everything for 128 byte
> cache lines, and for me to fix the dwc_eth_qos driver to handle cases where the
> line size is too big for the hardware skip feature, right?

I don't know if you've been following the discussion regarding
dwc_eth_qos on netdev, but Joao Pinto from Synopsys is
planning on removing the driver (since the stmmac driver
now supports the same version of the IP, together with older
versions of the IP).

Since device tree bindings are treated as an ABI,
Joao has implemented a glue layer for stmmac that parses
the dwc_eth_qos binding, but uses stmmac under the hood.

You can use any of the bindings, but since the dwc_eth_qos
binding will be marked as deprecated, you might want to
consider moving to the stmmac binding.

>
> Thanks,
>
>    Nathan
>
>
