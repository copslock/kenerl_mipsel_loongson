Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Mar 2013 18:43:25 +0100 (CET)
Received: from mail.nanl.de ([217.115.11.12]:41715 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823059Ab3CRQFSr1jO- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Mar 2013 17:05:18 +0100
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com [209.85.223.169])
        by mail.nanl.de (Postfix) with ESMTPSA id 7F90940969;
        Mon, 18 Mar 2013 16:05:16 +0000 (UTC)
Received: by mail-ie0-f169.google.com with SMTP id 13so7205297iea.14
        for <multiple recipients>; Mon, 18 Mar 2013 09:05:12 -0700 (PDT)
X-Received: by 10.42.145.137 with SMTP id f9mr9148359icv.52.1363622712686;
 Mon, 18 Mar 2013 09:05:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.142.193 with HTTP; Mon, 18 Mar 2013 09:04:52 -0700 (PDT)
In-Reply-To: <1363313356-32435-1-git-send-email-sanjayl@kymasys.com>
References: <1363313356-32435-1-git-send-email-sanjayl@kymasys.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 18 Mar 2013 17:04:52 +0100
Message-ID: <CAOiHx=nSm_bX13YWU0P0NjKkwdEE2cOe4fU+o5H+Z+S3h6LktQ@mail.gmail.com>
Subject: Re: [PATCH] KVM/MIPS32: Sync up with latest KVM API changes
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35908
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On 15 March 2013 03:09, Sanjay Lal <sanjayl@kymasys.com> wrote:
> - Rename KVM_MEMORY_SLOTS -> KVM_USER_MEM_SLOTS
> - Fix kvm_arch_{prepare,commit}_memory_region()
> - Also remove kvm_arch_set_memory_region which was unused.

I just stumbled upon the build issue caused by the first item and can
confirm that this patch fixes it.

I guess this is a replacement for "KVM/MIPS32: define
KVM_USER_MEM_SLOTS" (which doesn't apply anyway because of missing
spaces)? If yes, then you should mark the old one as superseded in
http://patchwork.linux-mips.org/. And maybe include here that it fixes
a build issue.


Regards
Jonas
