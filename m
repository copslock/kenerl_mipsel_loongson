Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2018 18:02:21 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993849AbeGBQCPI0t9Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Jul 2018 18:02:15 +0200
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62G19BX006812
        for <linux-mips@linux-mips.org>; Mon, 2 Jul 2018 12:02:12 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jyktc92f1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Mon, 02 Jul 2018 12:02:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 17:02:09 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 17:02:03 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62G22TZ27394104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 16:02:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BF61A4065;
        Mon,  2 Jul 2018 17:01:45 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 268A3A404D;
        Mon,  2 Jul 2018 17:01:42 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  2 Jul 2018 17:01:41 +0100 (BST)
Date:   Mon, 2 Jul 2018 09:01:58 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18070216-4275-0000-0000-000002945260
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070216-4276-0000-0000-0000379BCCE4
Message-Id: <20180702160158.GD65296@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=967 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020182
Return-Path: <srikar@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srikar@linux.vnet.ibm.com
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

> Implement the reference counter logic in core uprobe. User will be
> able to use it from trace_uprobe as well as from kernel module. New
> trace_uprobe definition with reference counter will now be:
> 
>     <path>:<offset>[(ref_ctr_offset)]
> 
> where ref_ctr_offset is an optional field. For kernel module, new
> variant of uprobe_register() has been introduced:
> 
>     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
> 

Sorry for bringing this again, but I would actually think the ref_ctr is
a consumer property. i.e the ref_ctr_offset should be part of
uprobe_consumer.

The advantages of doing that would be
1. Dont need to expose uprobe structure and just update our
uprobe_consumer which is already an exported structure.
- Exporting uprobe structure would expose some of our internal
  implementation details, basically reduce the freedom of changing stuff
  internally.
- we came up with uprobe_arch for the parts that we wanted to expose
  to archs. exposing uprobe and uprobe_arch looks weird.

2. ref_ctr_offset is necessarily a consumer property, its not a uprobe
property at all.

3. We dont need to change/add new uprobe_register functions.

The way I look at it is.

Based on the ref_ctr_offset field in consumer, we update_ref_ctr()
around install_breakpoint/remove_breakpoint.

> +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
> +{
> +	struct delayed_uprobe *du;
> +
> +	if (delayed_uprobe_check(uprobe, mm))
> +		return 0;
> +
> +	du  = kzalloc(sizeof(*du), GFP_KERNEL);
> +	if (!du)
> +		return -ENOMEM;
> +
> +	du->uprobe = uprobe;
> +	du->mm = mm;
> +	list_add(&du->list, &delayed_uprobe_list);
> +	return 0;
> +}
> +

If I understood the delayed_uprobe stuff, its when we could insert a
breakpoint but the vma that has the ref_ctr_offset is not loaded. Is
that correct?

> 
> -- 
> 2.14.4
> 
