Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2018 05:28:51 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbeF2D2oeaGp8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jun 2018 05:28:44 +0200
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5T3Scdk049197
        for <linux-mips@linux-mips.org>; Thu, 28 Jun 2018 23:28:42 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jw7jnucj8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 28 Jun 2018 23:28:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 29 Jun 2018 04:23:45 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Jun 2018 04:23:41 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5T3NeNa29949958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jun 2018 03:23:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C68C8AE057;
        Fri, 29 Jun 2018 04:23:31 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C35BDAE04D;
        Fri, 29 Jun 2018 04:23:22 +0100 (BST)
Received: from [9.79.204.50] (unknown [9.79.204.50])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jun 2018 04:23:22 +0100 (BST)
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180628195106.GA3952@redhat.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 29 Jun 2018 08:53:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628195106.GA3952@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18062903-0020-0000-0000-000002A11786
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062903-0021-0000-0000-000020ED18A0
Message-Id: <cd95a4cc-4301-0dca-5fdd-53cc016dcfe1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806290036
Return-Path: <ravi.bangoria@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64499
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

On 06/29/2018 01:21 AM, Oleg Nesterov wrote:
> I have to admit that after a quick glance I can't understand this patch
> at all... I'll try to read it again tomorrow, but could you at least explain
> how find_node_in_range/build_probe_list can work if off_type==REF_CTR_OFFSET?
> 
> On 06/28, Ravi Bangoria wrote:
>>
>> -find_node_in_range(struct inode *inode, loff_t min, loff_t max)
>> +find_node_in_range(struct inode *inode, int off_type, loff_t min, loff_t max)
>>  {
>>  	struct rb_node *n = uprobes_tree.rb_node;
>>  
>>  	while (n) {
>>  		struct uprobe *u = rb_entry(n, struct uprobe, rb_node);
>> +		loff_t offset = uprobe_get_offset(u, off_type);
>>  
>>  		if (inode < u->inode) {
>>  			n = n->rb_left;
>>  		} else if (inode > u->inode) {
>>  			n = n->rb_right;
>>  		} else {
>> -			if (max < u->offset)
>> +			if (max < offset)
>>  				n = n->rb_left;
>> -			else if (min > u->offset)
>> +			else if (min > offset)
>>  				n = n->rb_right;
>>  			else
>>  				break;
> 
> To simplify, lets forget about uprobe->inode (which acts as a key too). So uprobes_tree
> is a binary tree sorted by uprobe->offset key and that is why the binary search works.
> 
> But it is not sorted by uprobe->ref_ctr_offset. So for example n->rb_left can have the
> n->ref_ctr_offset key that is greater than the n's ref_ctr_offset. So how we can use the
> binary search if REF_CTR_OFFSET?
> 
> I must have missed something, I assume you tested this patch and it works somehow...
> 

Right, I've misinterpreted that code. Will check it.

Thanks for explaining,
Ravi
