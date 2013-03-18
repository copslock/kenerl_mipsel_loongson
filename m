Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Mar 2013 17:10:54 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:46886 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6823054Ab3CRQKxemAju (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Mar 2013 17:10:53 +0100
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Mon, 18 Mar 2013 09:10:44 -0700
Subject: Re: [PATCH] KVM/MIPS32: Sync up with latest KVM API changes
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <CAOiHx=nSm_bX13YWU0P0NjKkwdEE2cOe4fU+o5H+Z+S3h6LktQ@mail.gmail.com>
Date:   Mon, 18 Mar 2013 12:10:46 -0400
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7EFF141B-B25B-4844-BA6D-A7D0BE2423B9@kymasys.com>
References: <1363313356-32435-1-git-send-email-sanjayl@kymasys.com> <CAOiHx=nSm_bX13YWU0P0NjKkwdEE2cOe4fU+o5H+Z+S3h6LktQ@mail.gmail.com>
To:     Jonas Gorski <jogo@openwrt.org>
X-Mailer: Apple Mail (2.1283)
X-archive-position: 35906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>


On Mar 18, 2013, at 12:04 PM, Jonas Gorski wrote:

> On 15 March 2013 03:09, Sanjay Lal <sanjayl@kymasys.com> wrote:
>> - Rename KVM_MEMORY_SLOTS -> KVM_USER_MEM_SLOTS
>> - Fix kvm_arch_{prepare,commit}_memory_region()
>> - Also remove kvm_arch_set_memory_region which was unused.
> 
> I just stumbled upon the build issue caused by the first item and can
> confirm that this patch fixes it.
> 
> I guess this is a replacement for "KVM/MIPS32: define
> KVM_USER_MEM_SLOTS" (which doesn't apply anyway because of missing
> spaces)? If yes, then you should mark the old one as superseded in
> http://patchwork.linux-mips.org/. And maybe include here that it fixes
> a build issue.
> 
> 
> Regards
> Jonas
> 

Hi Jonas, will do.

Regards and thanks
Sanjay
