Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 23:08:48 +0200 (CEST)
Received: from mail-by2lp0243.outbound.protection.outlook.com ([207.46.163.243]:8275
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823043Ab3I3VIqSvWo2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Sep 2013 23:08:46 +0200
Received: from BLUPRD0712HT002.namprd07.prod.outlook.com (10.255.218.163) by
 BLUPR07MB225.namprd07.prod.outlook.com (10.141.22.16) with Microsoft SMTP
 Server (TLS) id 15.0.775.9; Mon, 30 Sep 2013 21:08:33 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.218.163) with Microsoft SMTP Server (TLS) id 14.16.359.1; Mon, 30 Sep
 2013 21:08:33 +0000
Message-ID: <5249E84F.2070008@caviumnetworks.com>
Date:   Mon, 30 Sep 2013 14:08:31 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     <devel@driverdev.osuosl.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>, <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] staging: octeon-ethernet: don't assume that CPU 0
 is special
References: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi> <5249B37E.4050000@caviumnetworks.com> <20130930193502.GE4572@blackmetal.musicnaut.iki.fi> <5249D407.2090904@caviumnetworks.com> <20130930195642.GF4572@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130930195642.GF4572@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 0985DA2459
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(24454002)(51704005)(377454003)(479174003)(189002)(199002)(31966008)(64126003)(76482001)(77096001)(53416003)(83506001)(81542001)(50466002)(56816003)(76796001)(76786001)(74662001)(47776003)(51856001)(66066001)(65956001)(83072001)(74706001)(74502001)(80022001)(47446002)(74366001)(74876001)(63696002)(56776001)(81342001)(80976001)(54316002)(79102001)(4396001)(81686001)(54356001)(77982001)(59766001)(46102001)(80316001)(83322001)(59896001)(65806001)(53806001)(69226001)(47976001)(81816001)(23756003)(50986001)(49866001)(47736001)(33656001)(36756003);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB225;H:BLUPRD0712HT002.namprd07.prod.outlook.com;CLIP:64.2.3.195;FPR:;RD:InfoNoRecords;MX:3;A:1;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 09/30/2013 12:56 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Sep 30, 2013 at 12:41:59PM -0700, David Daney wrote:
>> On 09/30/2013 12:35 PM, Aaro Koskinen wrote:
>>> No, the original logic was already broken. The code assumed that the
>>> NAPI scheduled by the driver init gets executed always on CPU 0. The
>>> IRQ got enabled just because we are lucky.
>>
>> No.  The default affinity for all irqs is CPU0 for just this reason.
>> So there was no luck involved.
>
> According the Kconfig, this driver can be compiled as a module:
>
>> config OCTEON_ETHERNET
>> 	tristate "Cavium Networks Octeon Ethernet support"
> [...]
>> 	To compile this driver as a module, choose M here.  The module
>> 	will be called octeon-ethernet.
>
> What guarantees that CPU0 is around (or the smp_affinity is at its
> default value) by the time user executes modprobe?

Nothing enforced by the kernel.  Just don't take CPU0 off-line and you 
should be good to go.

There is a lot of room for improvement in the driver.

Really this whole thing of starting NAPI on multiple CPUs for the same 
input queue is not good.  It leads to loss of packet ordering when 
forwarding.

What we really want is to have one POW group (input queue) per CPU and 
only run one CPU per group.  If we did that, we wouldn't have all these 
affinity issues.

David Daney
