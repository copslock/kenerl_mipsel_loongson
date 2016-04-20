Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 20:31:50 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:46977 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27027145AbcDTSbsf9MPY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Apr 2016 20:31:48 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E3A4C05E16B;
        Wed, 20 Apr 2016 18:31:47 +0000 (UTC)
Received: from potion (dhcp-1-215.brq.redhat.com [10.34.1.215])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3KIVhON032313;
        Wed, 20 Apr 2016 14:31:43 -0400
Received: by potion (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:31:42 +0200
Date:   Wed, 20 Apr 2016 20:31:42 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>, mingo@redhat.com,
        linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160420183142.GA7202@potion>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
 <20160420170209.GA11071@potion>
 <20160420170924.GA7859@jhogan-linux.le.imgtec.org>
 <20160420172706.GA4044@potion>
 <20160420195329.23c8982c@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160420195329.23c8982c@bahia.huguette.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2016-04-20 19:53+0200, Greg Kurz:
> On Wed, 20 Apr 2016 19:27:06 +0200
> Radim Krčmář <rkrcmar@redhat.com> wrote:
>> 2016-04-20 18:09+0100, James Hogan:
>> > On Wed, Apr 20, 2016 at 07:02:10PM +0200, Radim Krčmář wrote:  
>> >> 2016-04-20 17:44+0200, Greg Kurz:  
>> >> > diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
>> >> > index 70ef1a43c114..0278ea146db5 100644
>> >> > --- a/arch/mips/kvm/mips.c
>> >> > +++ b/arch/mips/kvm/mips.c
>> >> > @@ -248,9 +248,14 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
>> >> >  	int err, size, offset;
>> >> >  	void *gebase;
>> >> >  	int i;
>> >> > +	struct kvm_vcpu *vcpu;
>> >> >  
>> >> > -	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
>> >> > +	if (id >= KVM_MAX_VCPUS) {
>> >> > +		err = -EINVAL;
>> >> > +		goto out;  
>> >> 
>> >> 'vcpu' looks undefined at this point, so kfree in 'out:' may bug.  
>> > 
>> > Thats out_free_cpu I think?  
>> 
>> My bad, it is.  Thank you!
>> 
> 
> I kept the goto based construct because it was done this way for kzalloc().
> but I agree that 'return ERR_PTR(-EINVAL)' may look more explicit.
> 
> Worth a v4 ?

No, it is consistent with kzalloc fault handling this way.

I was going to queue it, but found an issue with kvm_get_vcpu_by_id()
that would allow the guest to create multiple VCPUs with the same id,
which led to an unfortunate discourse on KVM API.
(Please see a new thread.)
