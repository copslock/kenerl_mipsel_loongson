Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 11:45:23 +0200 (CEST)
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54747 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993039AbcHRJpPgCaKP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 11:45:15 +0200
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CC447205EB;
        Thu, 18 Aug 2016 05:45:14 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 18 Aug 2016 05:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=KW2XdawgaGbj/l264tpNUY+vaIg=; b=dWOnE
        arSLkvOVABM+wj012tCSMDLtsXZ61M6oxHG6+4BEBCZy8ABEq3CgEPIBv+JAdxau
        MevxIfrI2avoiLb79T5QUOeoAeRRBDqjwD7TORVxpD3nbt0ssg4fkAAdUaFSpbal
        VvZUWEooR7oQKzwbIn82nmuCZNo3tOFa4m20sQ=
X-Sasl-enc: 02yE+Z7+e6f1gQeiydbVj//AscQ9rE6SNoeqGX165c71 1471513514
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 585A4F296F;
        Thu, 18 Aug 2016 05:45:14 -0400 (EDT)
Date:   Thu, 18 Aug 2016 11:45:25 +0200
From:   Greg KH <greg@kroah.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH BACKPORT 3.17-4.4 0/4] MIPS: KVM: Fix MMU/TLB management
 issues
Message-ID: <20160818094525.GA6508@kroah.com>
References: <cover.6970eb00e72f05828fc82d97b7283d20eac8951e.1471018436.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.6970eb00e72f05828fc82d97b7283d20eac8951e.1471018436.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54597
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

On Thu, Aug 18, 2016 at 10:05:28AM +0100, James Hogan wrote:
> These patches backport fixes for several issues in the management of
> MIPS KVM TLB faults to 4.4, and should apply back to 3.17 too.

All queued up for 4.4-stable, thanks.

greg k-h
