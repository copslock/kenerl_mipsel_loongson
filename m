Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 09:47:06 +0200 (CEST)
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:43860 "EHLO
        e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006736AbbFBHrEmOrV4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 09:47:04 +0200
Received: from /spool/local
        by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <dingel@linux.vnet.ibm.com>;
        Tue, 2 Jun 2015 08:46:54 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp16.uk.ibm.com (192.168.101.146) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 2 Jun 2015 08:46:52 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id E21E217D8062;
        Tue,  2 Jun 2015 08:47:49 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t527kpW57405802;
        Tue, 2 Jun 2015 07:46:51 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t527kjAW019389;
        Tue, 2 Jun 2015 01:46:51 -0600
Received: from BR9TG4T3.de.ibm.com (sig-9-84-2-37.evts.de.ibm.com [9.84.2.37])
        by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t527kg45019291;
        Tue, 2 Jun 2015 01:46:42 -0600
Date:   Tue, 2 Jun 2015 09:46:40 +0200
From:   Dominik Dingel <dingel@linux.vnet.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove s390 sw-emulated hugepages and cleanup
Message-ID: <20150602094640.4fedc046@BR9TG4T3.de.ibm.com>
In-Reply-To: <556C0B5D.40205@de.ibm.com>
References: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
        <556C0B5D.40205@de.ibm.com>
Followup-To: linux-mm@kvack.org
Organization: IBM
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15060207-0025-0000-0000-0000056C922B
Return-Path: <dingel@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dingel@linux.vnet.ibm.com
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

On Mon, 01 Jun 2015 09:35:57 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 28.05.2015 um 13:52 schrieb Dominik Dingel:
> > Hi everyone,
> > 
> > there is a potential bug with KVM and hugetlbfs if the hardware does not
> > support hugepages (EDAT1).
> > We fix this by making EDAT1 a hard requirement for hugepages and 
> > therefore removing and simplifying code.
> 
> The cleanup itself is nice and probably the right thing to do. 
> Emulating large pages makes the code more complex and asks for
> trouble (as outlined above)
> 
> The only downside that I see is that z/VM as of today does not
> announce EDAT1 for its guests so the "emulated" large pages for
> hugetlbfs would be useful in that case. The current code allocates
> the page table only once and shares it for all mappers - which is
> useful for some big databases that spawn hundreds of processes with
> shared mappings of several hundred GBs. In these cases we do save
> a decent amount of page table memory. 

To limit the damage done, we could always allocate page tables with pgstes for that case.
That would allow one guest manipulating another guests storage keys,
but at least would prevent random memory overwrites in the host.

Another thing we could do, make software emulated large pages a kernel config option
and only if KVM is not selected allow it, visa versa.

@Martin what do you think?

Thanks,
	Dominik

> Not sure if that case is actually important, though.
> 
> Christian
> 
