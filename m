Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 00:17:42 +0200 (CEST)
Received: from imap.thunk.org ([IPv6:2600:3c02::f03c:91ff:fe96:be03]:56288
        "EHLO imap.thunk.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993945AbeC0WRd1K0kQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 00:17:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qj2I7BshdUHsbFfEKXQ0bFfkdiDTRJGc48sJd/7D8gQ=; b=btEd/5pMdHT1reg7t3RBaUE+uy
        /Bdw3z7jY7XeWJoswHfXhWDplC89IpsQG/vDQ6v1dDJtSejjuTff8lZCXoolBOru0ZDECFa4i2Sel
        +sLj1kXCx8bmRRzTvzjDMJZe+nV+SxziLAYDIYo7YWW9gxNtak2ZhetNJJWJVDEUw5as=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1f0wtU-0006Tk-8V; Tue, 27 Mar 2018 22:16:40 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 980CD7A0158; Tue, 27 Mar 2018 18:16:35 -0400 (EDT)
Date:   Tue, 27 Mar 2018 18:16:35 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ilya Smith <blackzert@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
        linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, jejb@parisc-linux.org,
        Helge Deller <deller@gmx.de>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
        Hugh Dickins <hughd@google.com>, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, Andrew Morton <akpm@linux-foundation.org>,
        steve.capper@arm.com, punit.agrawal@arm.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        Kees Cook <keescook@chromium.org>, bhsharma@redhat.com,
        riel@redhat.com, nitin.m.gupta@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, ross.zwisler@linux.intel.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180327221635.GA3790@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ilya Smith <blackzert@gmail.com>, Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
        linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, jejb@parisc-linux.org,
        Helge Deller <deller@gmx.de>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org,
        deepa.kernel@gmail.com, Hugh Dickins <hughd@google.com>,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        Andrew Morton <akpm@linux-foundation.org>, steve.capper@arm.com,
        punit.agrawal@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        npiggin@gmail.com, Kees Cook <keescook@chromium.org>,
        bhsharma@redhat.com, riel@redhat.com, nitin.m.gupta@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        ross.zwisler@linux.intel.com, Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Return-Path: <tytso@thunk.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tytso@mit.edu
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

On Tue, Mar 27, 2018 at 04:51:08PM +0300, Ilya Smith wrote:
> > /dev/[u]random is not sufficient?
> 
> Using /dev/[u]random makes 3 syscalls - open, read, close. This is a performance
> issue.

You may want to take a look at the getrandom(2) system call, which is
the recommended way getting secure random numbers from the kernel.

> > Well, I am pretty sure userspace can implement proper free ranges
> > tracking…
> 
> I think we need to know what libc developers will say on implementing ASLR in 
> user-mode. I am pretty sure they will say ‘nether’ or ‘some-day’. And problem 
> of ASLR will stay forever.

Why can't you send patches to the libc developers?

Regards,

						- Ted
