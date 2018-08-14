Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2018 10:57:08 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992492AbeHNI5EqQ4Zg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2018 10:57:04 +0200
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7E8sIqa125624
        for <linux-mips@linux-mips.org>; Tue, 14 Aug 2018 04:57:02 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kuu6hsvpk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Tue, 14 Aug 2018 04:57:02 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 14 Aug 2018 09:56:59 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 09:56:54 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7E8urhQ42467388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 08:56:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F01594204B;
        Tue, 14 Aug 2018 11:56:58 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A10E4203F;
        Tue, 14 Aug 2018 11:56:55 +0100 (BST)
Received: from [9.124.35.253] (unknown [9.124.35.253])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 11:56:55 +0100 (BST)
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, liu.song.a23@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 14 Aug 2018 14:26:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18081408-0020-0000-0000-000002B68545
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081408-0021-0000-0000-00002103AE6C
Message-Id: <2e55cc3b-a268-b66b-f75f-2a0fab02c6bf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=891 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140093
Return-Path: <ravi.bangoria@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65586
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


> +static int delayed_uprobe_install(struct vm_area_struct *vma)
> +{
> +	struct list_head *pos, *q;
> +	struct delayed_uprobe *du;
> +	unsigned long vaddr;
> +	int ret = 0, err = 0;
> +
> +	mutex_lock(&delayed_uprobe_lock);
> +	list_for_each_safe(pos, q, &delayed_uprobe_list) {
> +		du = list_entry(pos, struct delayed_uprobe, list);
> +
> +		if (!valid_ref_ctr_vma(du->uprobe, vma))
> +			continue;

I think we should compare mm here. I.e.:

    if (du->mm != vma->vm_mm || !valid_ref_ctr_vma(du->uprobe, vma))
            continue;

Otherwise things can mess up.

> +
> +		vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
> +		ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
> +		/* Record an error and continue. */
> +		if (ret && !err)
> +			err = ret;
> +		delayed_uprobe_delete(du);
> +	}
> +	mutex_unlock(&delayed_uprobe_lock);
> +	return err;
> +}
