Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Nov 2016 12:18:41 +0100 (CET)
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40846 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993201AbcKMLSeBN9Dy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Nov 2016 12:18:34 +0100
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D86320605;
        Sun, 13 Nov 2016 06:18:33 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Sun, 13 Nov 2016 06:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=HGaBmVQvIO60pMrDAkpxvLNBHQw=; b=KllS/boy0q3nB78aKQUp
        sbxso4U4+JMC9fP8s/0iTqavZgymmRUFJ23X7nHZZj59P6iMbRlQWbjMbiPNmkW5
        qM8CFG8spOnOfn34k8I1QBMCqg1zxKHM0mgHQiNbql/8Mn63g5K5ully5DIdaZtu
        keto1hWCzNyVIJfqVHzp+Qs=
X-ME-Sender: <xms:CEwoWO6F3ESL0pm3d1hYv4lHWxiXMVVbrvZy5MOaKZDB6PNKIaYjzg>
X-Sasl-enc: 9IIWoCEWeb8FzARkASPXCZHXaupikngxK7axUcQ189do 1479035912
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 92EB325062;
        Sun, 13 Nov 2016 06:18:32 -0500 (EST)
Date:   Sun, 13 Nov 2016 12:18:44 +0100
From:   Greg KH <greg@kroah.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [BACKPORT PATCH 3.17..4.4] KVM: MIPS: Drop other CPU ASIDs on
 guest MMU changes
Message-ID: <20161113111844.GC10476@kroah.com>
References: <20161109144544.16608-1-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161109144544.16608-1-james.hogan@imgtec.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Wed, Nov 09, 2016 at 02:45:44PM +0000, James Hogan wrote:
> commit 91e4f1b6073dd680d86cdb7e42d7cccca9db39d8 upstream.
> 
> When a guest TLB entry is replaced by TLBWI or TLBWR, we only invalidate
> TLB entries on the local CPU. This doesn't work correctly on an SMP host
> when the guest is migrated to a different physical CPU, as it could pick
> up stale TLB mappings from the last time the vCPU ran on that physical
> CPU.
> 
> Therefore invalidate both user and kernel host ASIDs on other CPUs,
> which will cause new ASIDs to be generated when it next runs on those
> CPUs.
> 
> We're careful only to do this if the TLB entry was already valid, and
> only for the kernel ASID where the virtual address it mapped is outside
> of the guest user address range.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> Cc: <stable@vger.kernel.org> # 3.17.x-
> [james.hogan@imgtec.com: Backport to 3.17..4.4]
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> ---
> Unfortunately the original commit went in to v4.4.25 as commit
> d450527ad04a, without fixing up the references to tlb_lo[0/1] to
> tlb_lo0/1 which broke the MIPS KVM build, and I didn't twig that I
> already had a correct backport outstanding (sorry!). That commit should
> be reverted before applying this backport to 4.4.

Thanks for this, now fixed up.

greg k-h
