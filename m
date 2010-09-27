Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Sep 2010 19:39:24 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4173 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491931Ab0I0RjV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Sep 2010 19:39:21 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca0d6e80000>; Mon, 27 Sep 2010 10:39:52 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 27 Sep 2010 10:39:18 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 27 Sep 2010 10:39:18 -0700
Message-ID: <4CA0D6C2.7030901@caviumnetworks.com>
Date:   Mon, 27 Sep 2010 10:39:14 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        konrad.wilk@oracle.com, mingo@elte.hu, andre.goddard@gmail.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH 7/9] swiotlb: Make bounce buffer bounds non-static.
References: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>       <1285282051-24907-2-git-send-email-ddaney@caviumnetworks.com> <20100927141616S.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100927141616S.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2010 17:39:18.0510 (UTC) FILETIME=[E95FB8E0:01CB5E6A]
X-archive-position: 27834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 21482

On 09/26/2010 10:20 PM, FUJITA Tomonori wrote:
> On Thu, 23 Sep 2010 15:47:31 -0700
> David Daney<ddaney@caviumnetworks.com>  wrote:
>
>> Octeon PCI mapping has to be established to cover the bounce buffers,
>> so it has to have access to the bounds.
>
> Why can't you use swiotlb_init_with_tbl() instead?
>

Yes, as pointed out be several people, that would be better.

The swiotlb_init_with_tbl() didn't exist in earlier kernel versions and 
this simplification was missed when I forward ported the patch set.

By using this function, I think the entire patch set will be MIPS 
specific, making it unnecessary to touch the generic swiotlb code.

Thanks,
David Daney
