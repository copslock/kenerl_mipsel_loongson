Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 21:55:04 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:43170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeCVUy5ajO2x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Mar 2018 21:54:57 +0100
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.71])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 518B110F9;
        Thu, 22 Mar 2018 20:54:49 +0000 (UTC)
Date:   Thu, 22 Mar 2018 13:54:48 -0700
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
Subject: Re: [RFC PATCH v2 2/2] Architecture defined limit on memory region
 random shift.
Message-Id: <20180322135448.046ada120ecd1ab3dd8f94aa@linux-foundation.org>
In-Reply-To: <1521736598-12812-3-git-send-email-blackzert@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
        <1521736598-12812-3-git-send-email-blackzert@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63158
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


Please add changelogs.  An explanation of what a "limit on memory
region random shift" is would be nice ;) Why does it exist, why are we
doing this, etc.  Surely there's something to be said - at present this
is just a lump of random code?
