Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2018 11:20:55 +0200 (CEST)
Received: from userp2130.oracle.com ([156.151.31.86]:37676 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990471AbeJNJUwjnGIA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Oct 2018 11:20:52 +0200
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9E9JMlx173978;
        Sun, 14 Oct 2018 09:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=05aD9b0I3N3/wDsl3G63PtCqLhzcjnbZvj4TP1v3z6Q=;
 b=a3saD1UhUdXuDuQCVlXFzaHb7xL1UeEvThQ7j1YSnEJm+Ss1x9YNtelHPEM9jbraqyhG
 sWDN18+GZeG702VM3IhGAInbg/wcS4i55KReLkR8EQT+ZSA8U8WyTdKOCoghnIeeGaoR
 qepHpaPBPyPtvACg199H3ipuM80R5RgInxENp4Lqu/YjzSmJGI6iRcFw1vrKUJ66uvfc
 UFolgaJyJEmvozuzcmPlkLovOhPOn8fa+jc/sB6UjHT89wtShMDKaNZvESdZ6hcO2oDS
 jcff5EXhRLYFXrSWroeJhyYZPDI0P2RkzQ6L7dmOPH98Ge8ARUcATCc/Igu81D3TYufb Qg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2n384tmv5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Oct 2018 09:20:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9E9KKUX011508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Oct 2018 09:20:21 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9E9KAq9004060;
        Sun, 14 Oct 2018 09:20:12 GMT
Received: from [192.168.14.112] (/79.182.224.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Oct 2018 09:20:10 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
Date:   Sun, 14 Oct 2018 12:20:00 +0300
Cc:     lantianyu1986@gmail.com, Lan Tianyu <Tianyu.Lan@microsoft.com>,
        christoffer.dall@arm.com, marc.zyngier@arm.com, linux@armlinux.org,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@linuxdriverproject.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Content-Transfer-Encoding: 8BIT
Message-Id: <1BDC7949-CFED-46C2-9D05-42864B0AD0F0@oracle.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9045 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810140091
Return-Path: <liran.alon@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liran.alon@oracle.com
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



> On 14 Oct 2018, at 11:16, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Sun, 14 Oct 2018, Liran Alon wrote:
>>> On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
>>> 
>>> +
>>> +static inline bool kvm_available_flush_tlb_with_range(void)
>>> +{
>>> +	return kvm_x86_ops->tlb_remote_flush_with_range;
>>> +}
>> 
>> Seems that kvm_available_flush_tlb_with_range() is not used in this patch…
> 
> What's wrong with that? 
> 
> It provides the implementation and later patches make use of it. It's a
> sensible way to split patches into small, self contained entities.
> 
> Thanks,
> 
> 	tglx
> 	

I guess it’s a matter of taste, but I prefer to not add dead-code for patches
in order for each commit to compile nicely without warnings of declared and unused functions.
I would prefer to just add this utility function on the patch that actually use it.

-Liran
