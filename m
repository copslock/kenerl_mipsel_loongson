Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2018 10:30:56 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994661AbeCEJarrM9cp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Mar 2018 10:30:47 +0100
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w259SsrS092074
        for <linux-mips@linux-mips.org>; Mon, 5 Mar 2018 04:30:41 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gh2uu97xc-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Mon, 05 Mar 2018 04:30:40 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Mon, 5 Mar 2018 09:30:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp10.uk.ibm.com (192.168.101.140) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 5 Mar 2018 09:30:28 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w259US1T58458212;
        Mon, 5 Mar 2018 09:30:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF93CA4055;
        Mon,  5 Mar 2018 09:23:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5701DA4059;
        Mon,  5 Mar 2018 09:23:25 +0000 (GMT)
Received: from oc7330422307.ibm.com (unknown [9.152.224.177])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Mar 2018 09:23:25 +0000 (GMT)
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
To:     Deepa Dinamani <deepa.kernel@gmail.com>, tglx@linutronix.de,
        john.stultz@linaro.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, acme@kernel.org, benh@kernel.crashing.org,
        catalin.marinas@arm.com, cmetcalf@mellanox.com, cohuck@redhat.com,
        davem@davemloft.net, deller@gmx.de, devel@driverdev.osuosl.org,
        gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org,
        heiko.carstens@de.ibm.com, hoeppner@linux.vnet.ibm.com,
        hpa@zytor.com, jejb@parisc-linux.org, jwi@linux.vnet.ibm.com,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, mpe@ellerman.id.au,
        oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        rostedt@goodmis.org, rric@kernel.org, schwidefsky@de.ibm.com,
        sebott@linux.vnet.ibm.com, sparclinux@vger.kernel.org,
        sth@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com,
        will.deacon@arm.com, x86@kernel.org
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Mon, 5 Mar 2018 10:30:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030509-0040-0000-0000-0000041AD39A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030509-0041-0000-0000-0000261DE199
Message-Id: <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803050113
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62805
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

On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
> All the current architecture specific defines for these
> are the same. Refactor these common defines to a common
> header file.
> 
> The new common linux/compat_time.h is also useful as it
> will eventually be used to hold all the defines that
> are needed for compat time types that support non y2038
> safe types. New architectures need not have to define these
> new types as they will only use new y2038 safe syscalls.
> This file can be deleted after y2038 when we stop supporting
> non y2038 safe syscalls.

You are now include a <linux/*.h> from several asm files
(
 arch/arm64/include/asm/stat.h   
 arch/s390/include/asm/elf.h     
 arch/x86/include/asm/ftrace.h   
 arch/x86/include/asm/sys_ia32.h 
)
It works, and it is done in many places, but it looks somewhat weird.
Would it make sense to have an asm-generic/compate-time.h instead? Asking for
opinions here.

> 
> The patch also requires an operation similar to:
> 
> git grep "asm/compat\.h" | cut -d ":" -f 1 |  xargs -n 1 sed -i -e "s%asm/compat.h%linux/compat.h%g"

some comments from the s390 perspective:

> --- a/arch/s390/hypfs/hypfs_sprp.c
> +++ b/arch/s390/hypfs/hypfs_sprp.c
ok.
[...]
> --- a/arch/s390/include/asm/elf.h
> +++ b/arch/s390/include/asm/elf.h
> @@ -126,7 +126,7 @@
>   */
> 
>  #include <asm/ptrace.h>
> -#include <asm/compat.h>
> +#include <linux/compat.h>
>  #include <asm/syscall.h>
>  #include <asm/user.h>

see above.
[...]
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
ok
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
ok
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
ok 
> --- a/drivers/s390/char/fs3270.c
> +++ b/drivers/s390/char/fs3270.c
ok
> --- a/drivers/s390/char/sclp_ctl.c
> +++ b/drivers/s390/char/sclp_ctl.c
ok
> --- a/drivers/s390/char/vmcp.c
> +++ b/drivers/s390/char/vmcp.c
ok
> --- a/drivers/s390/cio/chsc_sch.c
> +++ b/drivers/s390/cio/chsc_sch.c
ok

> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -32,7 +32,7 @@
>  #include <asm/chpid.h>
>  #include <asm/io.h>
>  #include <asm/sysinfo.h>
> -#include <asm/compat.h>
> +#include <linux/compat.h>
>  #include <asm/diag.h>
>  #include <asm/cio.h>
>  #include <asm/ccwdev.h>

Can you move that into the other includes (where all the other <linux/*> includes are.
