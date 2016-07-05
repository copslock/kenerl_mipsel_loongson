Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 14:51:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49824 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992833AbcGEMvSN6xuh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jul 2016 14:51:18 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u65CpG2V016189;
        Tue, 5 Jul 2016 14:51:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u65CpCkM016188;
        Tue, 5 Jul 2016 14:51:12 +0200
Date:   Tue, 5 Jul 2016 14:51:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
Subject: Re: [PATCH 8/9] MIPS: KVM: Decode RDHWR more strictly
Message-ID: <20160705125112.GJ7075@linux-mips.org>
References: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
 <1467657315-19975-9-git-send-email-james.hogan@imgtec.com>
 <24b4b1b6-2a58-63f8-f2c2-78ecc6eceb4e@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24b4b1b6-2a58-63f8-f2c2-78ecc6eceb4e@cogentembedded.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jul 05, 2016 at 02:16:48PM +0300, Sergei Shtylyov wrote:

> > When KVM emulates the RDHWR instruction, decode the instruction more
> > strictly. The rs field (bits 25:21) should be zero, as should bits 10:9.
> > Bits 8:6 is the register select field in MIPSr6, so we aren't strict
> > about those bits (no other operations should use that encoding space).
> > 
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: kvm@vger.kernel.org
> > ---
> >  arch/mips/kvm/emulate.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> > index 62e6a7b313ae..be18dfe9ecaa 100644
> > --- a/arch/mips/kvm/emulate.c
> > +++ b/arch/mips/kvm/emulate.c
> > @@ -2357,7 +2357,9 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
> >  	}
> > 
> >  	if (inst.r_format.opcode == spec3_op &&
> > -	    inst.r_format.func == rdhwr_op) {
> > +	    inst.r_format.func == rdhwr_op &&
> > +	    inst.r_format.rs == 0 &&
> > +	    (inst.r_format.re >> 3) == 0) {
> 
>    Inner parens not necessary here.

While I often strip unnecessary parens from patches I apply my guideline for
leaving them in is that nobody should need to know all C operator priorities
by heart.

  Ralf
