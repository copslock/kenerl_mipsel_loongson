Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 13:48:35 +0100 (CET)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:48034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990477AbeCWMs2ihMIX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 13:48:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7orINHI4+601Ya7KgoqsfTTqu+zqpdOM8kMSG4cJqJ4=; b=XGcfqtIqYEF0mTGJXW/En1OK2
        pvAiQiWtkUR7ZEzjkVdqB+GEcsHT5OxCOaCJNSuX922S0kqVD15UiPtIJhofIN2zNJEia+8VwF0IM
        YH4ihePwzXe+l2bNkQusG4ABKIUYg/kgvTA4fmI3EgjWGbKhT9qeytZ83dR/g5jR3k0sY4r/oWZAw
        CuIGD+YBm9gUyquiyK4yWZrJy8UnTCBKkoO8PIptU/KXmGiVb338A1DXauJxcfvcG4NaKpFVMe8HQ
        qQZr+TyFVbacqzYBHDdqCEhtx+lLSgMaEA7m1LbVJh1eeL3Cx2JbXNl0orzIa7BHQM35C2hOf/uID
        vDSEv0Yvw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ezM74-0002Ab-VV; Fri, 23 Mar 2018 12:48:06 +0000
Date:   Fri, 23 Mar 2018 05:48:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
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
        pombredanne@nexb.com, akpm@linux-foundation.org,
        steve.capper@arm.com, punit.agrawal@arm.com, paul.burton@mips.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
        nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, jack@suse.cz,
        ross.zwisler@linux.intel.com, jglisse@redhat.com,
        aarcange@redhat.com, oleg@redhat.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180323124806.GA5624@bombadil.infradead.org>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <willy@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willy@infradead.org
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

On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
> Current implementation doesn't randomize address returned by mmap.
> All the entropy ends with choosing mmap_base_addr at the process
> creation. After that mmap build very predictable layout of address
> space. It allows to bypass ASLR in many cases. This patch make
> randomization of address on any mmap call.

Why should this be done in the kernel rather than libc?  libc is perfectly
capable of specifying random numbers in the first argument of mmap.
