Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 13:25:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12747 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822185AbaETLY54i200 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2014 13:24:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EC6FBC7EBDFCF;
        Tue, 20 May 2014 12:24:47 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 20 May 2014 12:24:50 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 20 May
 2014 12:24:50 +0100
Message-ID: <537B3A8E.70801@imgtec.com>
Date:   Tue, 20 May 2014 12:20:46 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 00/12] kvm tools: Misc patches (mips support)
References: <1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 19/05/14 17:53, Andreas Herrmann wrote:
> Hi,
> 
> These patches contain changes that I am currently using on top of
> git://github.com/penberg/linux-kvm.git (as of v3.13-rc1-1427-gd9147fb)
> to run lkvm on MIPS.
> 
> The core is David's work for mips support and loading elf binaries.
> 
> I rebased his stuff, rearranged patches somewhat and split out general
> (non-mips-specific) modifications.
> 
> I used it to test a paravirtualized guest on a host running KVM with
> MIPS-VZ (on octeon3).
> 
> Changelog:
> v2:
>  - Removed superfluous includes in tools/kvm/Makefile (mips)
>  - Fixed debug output format for register dump (mips) (when using
>    32-bit lkvm with 64-bit guest)
>  - Added comment for guest type (KVM_VM_TYPE) (mips)
>  - Added check for upper bound of len in hypercall_write_cons (mips)
>  - Modified patch sequence to avoid temporary introduction of
>    load_bzimage (mips)
>  - Added patch to return number of bytes written by term_putc
> v1:
>  - http://marc.info/?i=1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com
> 
> Please apply -- if there are no additional comments or objections.

I don't know what Pekka's policy is for kvm tools, but to avoid
confusion I'd like to make clear that this patchset depends on a KVM
implementation (KVM_VM_TYPE==1 for VZ) which hasn't been accepted into
the mainline kernel yet.

Cheers
James
