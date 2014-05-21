Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 13:46:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43469 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837162AbaEULqTZYEGX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 13:46:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3F5B878D7D4DA;
        Wed, 21 May 2014 12:46:10 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 21 May
 2014 12:46:12 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 21 May 2014 12:46:12 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 21 May
 2014 12:46:11 +0100
Message-ID: <537C913C.1060903@imgtec.com>
Date:   Wed, 21 May 2014 12:42:52 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 11/15] MIPS: paravirt: Add pci controller for virtio
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-12-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1400597236-11352-12-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40214
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

On 20/05/14 15:47, Andreas Herrmann wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>  arch/mips/Kconfig                |    1 +
>  arch/mips/paravirt/Kconfig       |    6 ++
>  arch/mips/pci/Makefile           |    2 +-
>  arch/mips/pci/pci-virtio-guest.c |  140 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 148 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/paravirt/Kconfig
>  create mode 100644 arch/mips/pci/pci-virtio-guest.c

If I understand correctly this just drives a simple PCI controller for a
PCI bus that a virtio device happens to be usually plugged in to, yeh?

It sounds like it would make sense to take advantage of Will Deacon's
recent efforts to make a generic pci controller driver for this sort of
thing which specifically mentions emulation by kvmtool? Is it
effectively the same PCI controller that is being emulated?

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/thread.html#233491

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233491.html

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233490.html

Cheers
James
