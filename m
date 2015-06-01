Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 09:36:14 +0200 (CEST)
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:40356 "EHLO
        e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006840AbbFAHgMyVH44 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2015 09:36:12 +0200
Received: from /spool/local
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Mon, 1 Jun 2015 08:36:05 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 1 Jun 2015 08:36:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B9851B0807D;
        Mon,  1 Jun 2015 08:36:55 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t517a1Y821627092;
        Mon, 1 Jun 2015 07:36:01 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t517Zw7k028390;
        Mon, 1 Jun 2015 01:36:01 -0600
Received: from oc1450873852.ibm.com (dyn-9-152-224-118.boeblingen.de.ibm.com [9.152.224.118])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t517ZvRx028372;
        Mon, 1 Jun 2015 01:35:57 -0600
Message-ID: <556C0B5D.40205@de.ibm.com>
Date:   Mon, 01 Jun 2015 09:35:57 +0200
From:   Christian Borntraeger <borntraeger@de.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Dominik Dingel <dingel@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
CC:     Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Zhen <zhenzhang.zhang@huawei.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nathan Lynch <nathan_lynch@mentor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Jason J. Herne" <jjherne@linux.vnet.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/5] Remove s390 sw-emulated hugepages and cleanup
References: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
In-Reply-To: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15060107-0041-0000-0000-0000049E36A0
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47759
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

Am 28.05.2015 um 13:52 schrieb Dominik Dingel:
> Hi everyone,
> 
> there is a potential bug with KVM and hugetlbfs if the hardware does not
> support hugepages (EDAT1).
> We fix this by making EDAT1 a hard requirement for hugepages and 
> therefore removing and simplifying code.

The cleanup itself is nice and probably the right thing to do. 
Emulating large pages makes the code more complex and asks for
trouble (as outlined above)

The only downside that I see is that z/VM as of today does not
announce EDAT1 for its guests so the "emulated" large pages for
hugetlbfs would be useful in that case. The current code allocates
the page table only once and shares it for all mappers - which is
useful for some big databases that spawn hundreds of processes with
shared mappings of several hundred GBs. In these cases we do save
a decent amount of page table memory. 

Not sure if that case is actually important, though.

Christian
