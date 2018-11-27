Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2018 13:14:14 +0100 (CET)
Received: from userp2120.oracle.com ([156.151.31.85]:56504 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990850AbeK0MM2R6ZT2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2018 13:12:28 +0100
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wARC8sZU029296;
        Tue, 27 Nov 2018 12:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hgrV39oEh7Cv76Dlzsu3JLz3cLBFrs4YhFM49TEj/VU=;
 b=PDgTZ4VV51HYLmNy7nFAGBjE1YOQN54c9c/vIohDWAY0XPTFD/HU7p1GSRUqjtviGFlV
 PHtG2hBP/i62UW2Czr5J2w3hpx5bJemMNFqW9yInvyFFgTS15Xazv3ntp12OrIQ1l1He
 xPX8ndsZL7U0tSxE3oNN0/rvCpEOu4uioMJEXr4TEjGfLus68msIW9Z5N8Y/uFMieyZc
 15xZ8KXHdUjv76atf5ikDU6a+x3ysFpIRBLO+PvTCiz4pFxrffQv4tivjL863kOZCxK+
 W5U7LrXT9o+xYcnaOy1PBMVnhCEyNbixYnJ1iP5GoSqXkl1WYwJ2rhFWYoTffnNud9w6 Nw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nxy9r3h4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 12:11:53 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wARCBrBs018761
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 12:11:53 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wARCBlAJ029153;
        Tue, 27 Nov 2018 12:11:49 GMT
Received: from unbuntlaptop (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 04:11:47 -0800
Date:   Tue, 27 Nov 2018 15:11:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tianyu Lan <lantianyu1986@gmail.com>
Cc:     linux-mips@linux-mips.org, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, benh@kernel.crashing.org,
        will.deacon@arm.com, christoffer.dall@arm.com, paulus@ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvmarm@lists.cs.columbia.edu,
        sthemmin@microsoft.com, mpe@ellerman.id.au,
        the arch/x86 maintainers <x86@kernel.org>,
        linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
        Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com,
        jhogan@kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        marc.zyngier@arm.com, haiyangz@microsoft.com,
        kvm-ppc@vger.kernel.org, bp@alien8.de,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        ralf@linux-mips.org, paul.burton@mips.com,
        devel@linuxdriverproject.org, vkuznets@redhat.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 00/10] x86/KVM/Hyper-v: Add HV ept tlb range flush
 hypercall support in KVM
Message-ID: <20181127121129.GR3088@unbuntlaptop>
References: <20181108144259.10817-1-Tianyu.Lan@microsoft.com>
 <CAOLK0pyvtfhoGM+D7h=gXwNpNjXGZiDJKpuVi9HOwb++4asCXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLK0pyvtfhoGM+D7h=gXwNpNjXGZiDJKpuVi9HOwb++4asCXw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=966
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270106
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
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

On Tue, Nov 27, 2018 at 07:59:22PM +0800, Tianyu Lan wrote:
> Gentile Ping...
> 
> On Thu, Nov 8, 2018 at 10:43 PM <lantianyu1986@gmail.com> wrote:
> >
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > Sorry. Some patches was blocked and I try to resend via another account.

The patches were still blocked?  They didn't show up on driver-devel.

regards,
dan carpenter
