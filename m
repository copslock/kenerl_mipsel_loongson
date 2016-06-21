Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2016 07:30:52 +0200 (CEST)
Received: from smtprelay.synopsys.com ([198.182.47.9]:57501 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041988AbcFUFauFGjM- convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jun 2016 07:30:50 +0200
Received: from us02secmta2.synopsys.com (us02secmta2.synopsys.com [10.12.235.98])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4A4EC24E1EED;
        Mon, 20 Jun 2016 22:30:42 -0700 (PDT)
Received: from us02secmta2.internal.synopsys.com (us02secmta2.internal.synopsys.com [127.0.0.1])
        by us02secmta2.internal.synopsys.com (Service) with ESMTP id 3B98D55F13;
        Mon, 20 Jun 2016 22:30:42 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by us02secmta2.internal.synopsys.com (Service) with ESMTP id DF78E55F02;
        Mon, 20 Jun 2016 22:30:41 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id C5597590;
        Mon, 20 Jun 2016 22:30:41 -0700 (PDT)
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 55A4E58F;
        Mon, 20 Jun 2016 22:30:41 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.151]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0266.001; Mon, 20
 Jun 2016 22:30:40 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Alexandru Moise <00moses.alexander00@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "bamvor.zhangjian@linaro.org" <bamvor.zhangjian@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] devpts: remove DEVPTS_MULTIPLE_INSTANCES from all
 configs
Thread-Topic: [PATCH] devpts: remove DEVPTS_MULTIPLE_INSTANCES from all
 configs
Thread-Index: AQHRytQkYob+zAYmoUqEmxVLEG3r1g==
Date:   Tue, 21 Jun 2016 05:30:40 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750106944A83@us01wembx1.internal.synopsys.com>
References: <20160620091258.11233-1-00moses.alexander00@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

On Monday 20 June 2016 02:44 PM, Alexandru Moise wrote:
> As each mount of devpts is now an independent filesystem,
> the DEVPTS_MULTIPLE_INSTANCES config option no longer exists.
> So remove it.
>
> Signed-off-by: Alexandru Moise <00moses.alexander00@gmail.com>

For arch/arc

Acked-by: Vineet Gupta <vgupta@synopsys.com>
