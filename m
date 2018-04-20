Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2018 09:54:29 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990757AbeDTHyWQAucU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2018 09:54:22 +0200
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3K7r4F7101166
        for <linux-mips@linux-mips.org>; Fri, 20 Apr 2018 03:54:19 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hfbh3241e-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 20 Apr 2018 03:54:19 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <heiko.carstens@de.ibm.com>;
        Fri, 20 Apr 2018 08:54:16 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 20 Apr 2018 08:54:09 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w3K7s99h56164576;
        Fri, 20 Apr 2018 07:54:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 555574C044;
        Fri, 20 Apr 2018 08:46:36 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94A284C050;
        Fri, 20 Apr 2018 08:46:35 +0100 (BST)
Received: from osiris (unknown [9.152.212.94])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 20 Apr 2018 08:46:35 +0100 (BST)
Date:   Fri, 20 Apr 2018 09:54:07 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, tglx@linutronix.de,
        deepa.kernel@gmail.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, albert.aribaud@3adev.fr,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, x86@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 04/17] y2038: s390: Remove unneeded ipc uapi header
 files
References: <20180419143737.606138-1-arnd@arndb.de>
 <20180419143737.606138-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419143737.606138-5-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 18042007-0044-0000-0000-0000054A493A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042007-0045-0000-0000-0000288A6979
Message-Id: <20180420075407.GA7119@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200079
Return-Path: <heiko.carstens@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko.carstens@de.ibm.com
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

On Thu, Apr 19, 2018 at 04:37:24PM +0200, Arnd Bergmann wrote:
> The s390 msgbuf/sembuf/shmbuf header files are all identical to the
> version from asm-generic.
> 
> This patch removes the files and replaces them with 'generic-y'
> statements, to avoid having to modify each copy when we extend sysvipc
> to deal with 64-bit time_t in 32-bit user space.
> 
> Note that unlike alpha and ia64, the ipcbuf.h header file is slightly
> different here, so I'm leaving the private copy.
> 
> To deal with 32-bit compat tasks, we also have to adapt the definitions
> of compat_{shm,sem,msg}id_ds to match the changes to the respective
> asm-generic files.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/include/asm/compat.h      | 32 ++++++++++++------------
>  arch/s390/include/uapi/asm/Kbuild   |  3 +++
>  arch/s390/include/uapi/asm/msgbuf.h | 38 ----------------------------
>  arch/s390/include/uapi/asm/sembuf.h | 30 -----------------------
>  arch/s390/include/uapi/asm/shmbuf.h | 49 -------------------------------------
>  5 files changed, 19 insertions(+), 133 deletions(-)
>  delete mode 100644 arch/s390/include/uapi/asm/msgbuf.h
>  delete mode 100644 arch/s390/include/uapi/asm/sembuf.h
>  delete mode 100644 arch/s390/include/uapi/asm/shmbuf.h

FWIW,

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
