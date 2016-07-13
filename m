Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 11:04:37 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39293 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23995126AbcGMJEbRiQ0F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 11:04:31 +0200
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6D93cGR109795
        for <linux-mips@linux-mips.org>; Wed, 13 Jul 2016 05:04:30 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 245hgaahyk-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 13 Jul 2016 05:04:29 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Wed, 13 Jul 2016 10:04:28 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 13 Jul 2016 10:04:12 +0100
X-IBM-Helo: d06dlp02.portsmouth.uk.ibm.com
X-IBM-MailFrom: borntraeger@de.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 21426219005F
        for <linux-mips@linux-mips.org>; Wed, 13 Jul 2016 10:03:40 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com [9.149.37.248])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u6D94BRw62324940
        for <linux-mips@linux-mips.org>; Wed, 13 Jul 2016 09:04:11 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u6D94Auu012952
        for <linux-mips@linux-mips.org>; Wed, 13 Jul 2016 05:04:11 -0400
Received: from oc1450873852.ibm.com (dyn-9-152-96-177.boeblingen.de.ibm.com [9.152.96.177])
        by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u6D949wM012903;
        Wed, 13 Jul 2016 05:04:09 -0400
Subject: Re: [PATCH V3 4/5] kvm/stats: Add provisioning for 64-bit vm and vcpu
 statistics
To:     Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
References: <1468400015-4834-1-git-send-email-sjitindarsingh@gmail.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        christoffer.dall@linaro.org, marc.zyngier@arm.com,
        james.hogan@imgtec.com, agraf@suse.com, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, cornelia.huck@de.ibm.com,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        linux-s390@vger.kernel.org
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Wed, 13 Jul 2016 11:04:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1468400015-4834-1-git-send-email-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16071309-0040-0000-0000-000002A99159
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 16071309-0041-0000-0000-00001C32BB2A
Message-Id: <57860408.1000203@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-07-13_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1604210000
 definitions=main-1607130103
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borntraeger@de.ibm.com
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

On 07/13/2016 10:53 AM, Suraj Jitindar Singh wrote:
> vms and vcpus have statistics associated with them which can be viewed
> within the debugfs. Currently it is assumed within the vcpu_stat_get() and
> vm_stat_get() functions that all of these statistics are represented as
> u32s, however the next patch adds some u64 statistics.
> 
> Thus modify these two functions, vcpu_stat_get() and vm_stat_get(), such
> that they expect u64 statistics and update vm and vcpu statistics to u64s
> accordingly.
> 
> ---
> Change Log:
> 
> V1 -> V2:
> 	- Nothing
> V2 -> V3:
> 	- Instead of implementing separate u32 and u64 functions keep the
> 	  generic functions and modify them to expect u64s. Thus update all
> 	  vm and vcpu statistics to u64s accordingly.

Have not looked into everything, but I agree with changing everything to 64bit.


> @@ -3583,8 +3583,8 @@ static const struct file_operations vcpu_stat_get_per_vm_fops = {
>  };
> 
>  static const struct file_operations *stat_fops_per_vm[] = {
> -	[KVM_STAT_VCPU] = &vcpu_stat_get_per_vm_fops,
> -	[KVM_STAT_VM]   = &vm_stat_get_per_vm_fops,
> +	[KVM_STAT_VCPU]		= &vcpu_stat_get_per_vm_fops,
> +	[KVM_STAT_VM]		= &vm_stat_get_per_vm_fops,
>  };
unrelated white space changes?

> 
>  static int vm_stat_get(void *_offset, u64 *val)
> @@ -3628,8 +3628,8 @@ static int vcpu_stat_get(void *_offset, u64 *val)
>  DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_fops, vcpu_stat_get, NULL, "%llu\n");
> 
>  static const struct file_operations *stat_fops[] = {
> -	[KVM_STAT_VCPU] = &vcpu_stat_fops,
> -	[KVM_STAT_VM]   = &vm_stat_fops,
> +	[KVM_STAT_VCPU]		= &vcpu_stat_fops,
> +	[KVM_STAT_VM]		= &vm_stat_fops,
>  };
> 
>  static int kvm_init_debug(void)
> 
