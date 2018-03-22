Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 21:57:49 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:44208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990422AbeCVU5iVqxbx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Mar 2018 21:57:38 +0100
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.71])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4ACD4E8F;
        Thu, 22 Mar 2018 20:57:30 +0000 (UTC)
Date:   Thu, 22 Mar 2018 13:57:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ilya Smith <blackzert@gmail.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
        fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
        mhocko@suse.com, hughd@google.com, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, steve.capper@arm.com, punit.agrawal@arm.com,
        paul.burton@mips.com, aneesh.kumar@linux.vnet.ibm.com,
        npiggin@gmail.com, keescook@chromium.org, bhsharma@redhat.com,
        riel@redhat.com, nitin.m.gupta@oracle.com,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        jack@suse.cz, ross.zwisler@linux.intel.com, jglisse@redhat.com,
        willy@infradead.org, aarcange@redhat.com, oleg@redhat.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-Id: <20180322135729.dbfd3575819c92c0f88c5c21@linux-foundation.org>
In-Reply-To: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Thu, 22 Mar 2018 19:36:36 +0300 Ilya Smith <blackzert@gmail.com> wrote:

> Current implementation doesn't randomize address returned by mmap.
> All the entropy ends with choosing mmap_base_addr at the process
> creation. After that mmap build very predictable layout of address
> space. It allows to bypass ASLR in many cases.

Perhaps some more effort on the problem description would help.  *Are*
people predicting layouts at present?  What problems does this cause? 
How are they doing this and are there other approaches to solving the
problem?

Mainly: what value does this patchset have to our users?  This reader
is unable to determine that from the information which you have
provided.  Full details, please.
