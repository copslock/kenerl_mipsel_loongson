Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 05:40:04 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbeGXDkBtNGYf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2018 05:40:01 +0200
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6O3d5b5018415
        for <linux-mips@linux-mips.org>; Mon, 23 Jul 2018 23:39:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kdqvph5v4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Mon, 23 Jul 2018 23:39:59 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 24 Jul 2018 04:34:55 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 04:34:51 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6O3YopF41222270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 03:34:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1593FAE055;
        Tue, 24 Jul 2018 06:35:00 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DC17AE045;
        Tue, 24 Jul 2018 06:34:57 +0100 (BST)
Received: from [9.124.31.70] (unknown [9.124.31.70])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 06:34:57 +0100 (BST)
Subject: Re: [PATCH v6 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
 <20180716084706.28244-4-ravi.bangoria@linux.ibm.com>
 <20180723162629.GA8584@redhat.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 24 Jul 2018 09:04:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180723162629.GA8584@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18072403-0012-0000-0000-0000028DDCE5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072403-0013-0000-0000-000020BFBBBF
Message-Id: <e722ee62-eaba-3abd-7f34-bf38ba3d4f95@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240037
Return-Path: <ravi.bangoria@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ravi.bangoria@linux.ibm.com
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

Hi Oleg,

On 07/23/2018 09:56 PM, Oleg Nesterov wrote:
> I have a mixed feeling about this series... I'll try to summarise my thinking
> tomorrow, but I do not see any obvious problem so far. Although I have some
> concerns about 5/6, I need to re-read it after sleep.

Sure.

> 
> 
> On 07/16, Ravi Bangoria wrote:
>>
>> +static int delayed_uprobe_install(struct vm_area_struct *vma)
>> +{
>> +	struct list_head *pos, *q;
>> +	struct delayed_uprobe *du;
>> +	unsigned long vaddr;
>> +	int ret = 0, err = 0;
>> +
>> +	mutex_lock(&delayed_uprobe_lock);
>> +	list_for_each_safe(pos, q, &delayed_uprobe_list) {
>> +		du = list_entry(pos, struct delayed_uprobe, list);
>> +
>> +		if (!du->uprobe->ref_ctr_offset ||
> 
> Is it possible to see ->ref_ctr_offset == 0 in delayed_uprobe_list?

I'll remove this check.

> 
>> @@ -1072,7 +1282,13 @@ int uprobe_mmap(struct vm_area_struct *vma)
>>  	struct uprobe *uprobe, *u;
>>  	struct inode *inode;
>>  
>> -	if (no_uprobe_events() || !valid_vma(vma, true))
>> +	if (no_uprobe_events())
>> +		return 0;
>> +
>> +	if (vma->vm_flags & VM_WRITE)
>> +		delayed_uprobe_install(vma);
> 
> Obviously not nice performance-wise... OK, I do not know if it will actually
> hurt in practice and probably we can use the better data structures if necessary.
> But can't we check MMF_HAS_UPROBES at least? I mean,
> 
> 	if (vma->vm_flags & VM_WRITE && test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
> 		delayed_uprobe_install(vma);
> 
> ?

Yes.

> 
> 
> Perhaps we can even add another flag later, MMF_HAS_DELAYED_UPROBES set by
> delayed_uprobe_add().

Yes, good idea.

Thanks for the review,
Ravi
