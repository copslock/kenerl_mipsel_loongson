Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 19:27:23 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:51228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026017AbcDTR1UHjkuD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Apr 2016 19:27:20 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD95EC04B304;
        Wed, 20 Apr 2016 17:27:11 +0000 (UTC)
Received: from potion (dhcp-1-215.brq.redhat.com [10.34.1.215])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3KHR7SZ016254;
        Wed, 20 Apr 2016 13:27:07 -0400
Received: by potion (sSMTP sendmail emulation); Wed, 20 Apr 2016 19:27:06 +0200
Date:   Wed, 20 Apr 2016 19:27:06 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Greg Kurz <gkurz@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, mingo@redhat.com,
        linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160420172706.GA4044@potion>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
 <20160420170209.GA11071@potion>
 <20160420170924.GA7859@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160420170924.GA7859@jhogan-linux.le.imgtec.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53137
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

2016-04-20 18:09+0100, James Hogan:
> On Wed, Apr 20, 2016 at 07:02:10PM +0200, Radim Krčmář wrote:
>> 2016-04-20 17:44+0200, Greg Kurz:
>> > diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
>> > index 70ef1a43c114..0278ea146db5 100644
>> > --- a/arch/mips/kvm/mips.c
>> > +++ b/arch/mips/kvm/mips.c
>> > @@ -248,9 +248,14 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
>> >  	int err, size, offset;
>> >  	void *gebase;
>> >  	int i;
>> > +	struct kvm_vcpu *vcpu;
>> >  
>> > -	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
>> > +	if (id >= KVM_MAX_VCPUS) {
>> > +		err = -EINVAL;
>> > +		goto out;
>> 
>> 'vcpu' looks undefined at this point, so kfree in 'out:' may bug.
> 
> Thats out_free_cpu I think?

My bad, it is.  Thank you!
