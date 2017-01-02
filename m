Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jan 2017 07:57:48 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39055 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991986AbdABG53XtGag (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Jan 2017 07:57:29 +0100
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v026sMmr077044
        for <linux-mips@linux-mips.org>; Mon, 2 Jan 2017 01:57:26 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27q407cres-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Mon, 02 Jan 2017 01:57:25 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <heiko.carstens@de.ibm.com>;
        Mon, 2 Jan 2017 06:57:23 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 2 Jan 2017 06:57:16 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id AFDD22190019;
        Mon,  2 Jan 2017 06:56:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v026vGMU14614816;
        Mon, 2 Jan 2017 06:57:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3853B42041;
        Mon,  2 Jan 2017 05:55:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B0C742042;
        Mon,  2 Jan 2017 05:55:14 +0000 (GMT)
Received: from osiris (unknown [9.152.212.54])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Jan 2017 05:55:14 +0000 (GMT)
Date:   Mon, 2 Jan 2017 07:57:13 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Dmitry Safonov <dsafonov@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org
Subject: Re: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
References: <20161230155634.8692-1-dsafonov@virtuozzo.com>
 <20161230155634.8692-2-dsafonov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161230155634.8692-2-dsafonov@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 17010206-0016-0000-0000-0000036E35ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17010206-0017-0000-0000-00002541C154
Message-Id: <20170102065713.GB4779@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-01-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1612050000
 definitions=main-1701020118
Return-Path: <heiko.carstens@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56140
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

On Fri, Dec 30, 2016 at 06:56:31PM +0300, Dmitry Safonov wrote:
> All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
> TASK_SIZE_MAX since:
> commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
> FSBASE/GSBASE upper limits"),
> commit a06db751c321 ("pagemap: check permissions and capabilities at
> open time"),
> 
> Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
> ---
...

> diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
> index 6bca916a5ba0..c53e8e2a51ac 100644
> --- a/arch/s390/include/asm/processor.h
> +++ b/arch/s390/include/asm/processor.h
> @@ -89,10 +89,9 @@ extern void execve_tail(void);
>   * User space process size: 2GB for 31 bit, 4TB or 8PT for 64 bit.
>   */
> 
> -#define TASK_SIZE_OF(tsk)	((tsk)->mm->context.asce_limit)
>  #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_31BIT) ? \
>  					(1UL << 30) : (1UL << 41))
> -#define TASK_SIZE		TASK_SIZE_OF(current)
> +#define TASK_SIZE		(current->mm->context.asce_limit)
>  #define TASK_MAX_SIZE		(1UL << 53)
> 
>  #define STACK_TOP		(1UL << (test_thread_flag(TIF_31BIT) ? 31:42))

FWIW, for the s390 part:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
