Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 10:54:20 +0200 (CEST)
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35702 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991826AbdIAIyMy401N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2017 10:54:12 +0200
X-IronPort-AV: E=Sophos;i="5.41,457,1498492800"; 
   d="scan'208";a="25108678"
Received: from localhost (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Sep 2017 16:54:04 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id BAA2B4724E70;
        Fri,  1 Sep 2017 16:54:03 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.319.2; Fri, 1 Sep 2017 16:54:04 +0800
Subject: Re: [PATCH v2 2/7] MIPS: numa: Remove the unused parent_node() macro
To:     Ralf Baechle <ralf@linux-mips.org>
References: <1504234599-29533-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1504234599-29533-3-git-send-email-douly.fnst@cn.fujitsu.com>
 <20170901084255.GA19890@linux-mips.org>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <8d57c5de-9965-3423-6325-89db6c798a51@cn.fujitsu.com>
Date:   Fri, 1 Sep 2017 16:54:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20170901084255.GA19890@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: BAA2B4724E70.AA1E3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Return-Path: <douly.fnst@cn.fujitsu.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: douly.fnst@cn.fujitsu.com
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

Hi Ralf,

At 09/01/2017 04:42 PM, Ralf Baechle wrote:
> On Fri, Sep 01, 2017 at 10:56:34AM +0800, Dou Liyang wrote:
>
>> Commit a7be6e5a7f8d ("mm: drop useless local parameters of
>> __register_one_node()") removes the last user of parent_node().
>>
>> The parent_node() macros in both IP27 and Loongson64 are unnecessary.
>>
>> Remove it for cleanup.
>
> I already applied v1.
>

Thank you very much. :-)

Maybe I missed some message, so I thought it was not yet accepted.

please ignore this patch.

Thanks,
	dou
> Thanks,
>
>   Ralf
>
>
>
