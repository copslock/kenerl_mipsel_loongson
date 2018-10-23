Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2018 13:32:44 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:37730 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991532AbeJWLcladOem (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Oct 2018 13:32:41 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FD66AEBC;
        Tue, 23 Oct 2018 11:32:35 +0000 (UTC)
Date:   Tue, 23 Oct 2018 13:32:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
Message-ID: <20181023113234.GH32333@dhcp22.suse.cz>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-2-rick.p.edgecombe@intel.com>
 <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
 <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

On Fri 12-10-18 17:04:46, Edgecombe, Rick P wrote:
[...]
> Any thoughts on if instead of all this there was just a system wide limit on BPF
> JIT module space usage?

We do allow to charge vmalloc memory to a memory cgroup. Isn't that a
way forward?
-- 
Michal Hocko
SUSE Labs
