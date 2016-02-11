Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 17:11:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57445 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011283AbcBKQLbyDAGN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 17:11:31 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id A559C5A378BB6;
        Thu, 11 Feb 2016 16:11:23 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 11 Feb 2016 16:11:25 +0000
Received: from [192.168.154.45] (192.168.154.45) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 11 Feb
 2016 16:11:25 +0000
Subject: Re: [Patch v9] SATA: OCTEON: support SATA on OCTEON platform
To:     Tejun Heo <tj@kernel.org>
References: <1455198788-24754-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <20160211151551.GX3741@mtj.duckdns.org>
CC:     <hdegoede@redhat.com>, <david.daney@cavium.com>,
        <aleksey.makarov@caviumnetworks.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <56BCB28A.4070302@imgtec.com>
Date:   Thu, 11 Feb 2016 16:10:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20160211151551.GX3741@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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



On 11/02/16 15:15, Tejun Heo wrote:
> On Thu, Feb 11, 2016 at 01:53:08PM +0000, Zubair Lutfullah Kakakhel wrote:
>> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
>>
>> The OCTEON SATA controller is currently found on cn71XX devices.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>
> Applied to libata/for-4.6.

Thank-you very much everyone.

( ͡° ͜ʖ ͡°)

ZubairLK

>
> Thanks.
>
