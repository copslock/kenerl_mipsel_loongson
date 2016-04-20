Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 19:53:44 +0200 (CEST)
Received: from e06smtp08.uk.ibm.com ([195.75.94.104]:53398 "EHLO
        e06smtp08.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026017AbcDTRxmmbPDD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 19:53:42 +0200
Received: from localhost
        by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Wed, 20 Apr 2016 18:53:37 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp08.uk.ibm.com (192.168.101.138) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 20 Apr 2016 18:53:34 +0100
X-IBM-Helo: d06dlp01.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 46D7B17D805A
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 18:54:21 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3KHrX4B1573268
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 17:53:33 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3KHrWcU018542
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 13:53:33 -0400
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3KHrWnU018539;
        Wed, 20 Apr 2016 13:53:32 -0400
Received: from bahia.huguette.org (sig-9-83-160-41.evts.uk.ibm.com [9.83.160.41])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 348F6220333;
        Wed, 20 Apr 2016 19:53:31 +0200 (CEST)
Date:   Wed, 20 Apr 2016 19:53:29 +0200
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>, mingo@redhat.com,
        linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160420195329.23c8982c@bahia.huguette.org>
In-Reply-To: <20160420172706.GA4044@potion>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
        <20160420170209.GA11071@potion>
        <20160420170924.GA7859@jhogan-linux.le.imgtec.org>
        <20160420172706.GA4044@potion>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042017-0033-0000-0000-0000124C308E
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gkurz@linux.vnet.ibm.com
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

On Wed, 20 Apr 2016 19:27:06 +0200
Radim Krčmář <rkrcmar@redhat.com> wrote:

> 2016-04-20 18:09+0100, James Hogan:
> > On Wed, Apr 20, 2016 at 07:02:10PM +0200, Radim Krčmář wrote:  
> >> 2016-04-20 17:44+0200, Greg Kurz:  
> >> > diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> >> > index 70ef1a43c114..0278ea146db5 100644
> >> > --- a/arch/mips/kvm/mips.c
> >> > +++ b/arch/mips/kvm/mips.c
> >> > @@ -248,9 +248,14 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
> >> >  	int err, size, offset;
> >> >  	void *gebase;
> >> >  	int i;
> >> > +	struct kvm_vcpu *vcpu;
> >> >  
> >> > -	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
> >> > +	if (id >= KVM_MAX_VCPUS) {
> >> > +		err = -EINVAL;
> >> > +		goto out;  
> >> 
> >> 'vcpu' looks undefined at this point, so kfree in 'out:' may bug.  
> > 
> > Thats out_free_cpu I think?  
> 
> My bad, it is.  Thank you!
> 

I kept the goto based construct because it was done this way for kzalloc().
but I agree that 'return ERR_PTR(-EINVAL)' may look more explicit.

Worth a v4 ?

Cheers.

--
Greg
