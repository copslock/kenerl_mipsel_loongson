Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 13:50:13 +0200 (CEST)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38040 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012261AbbD3LuLngxGK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2015 13:50:11 +0200
Received: by wiun10 with SMTP id n10so14657982wiu.1
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0Tp6cJJIK8KkNCh68d2jLZQecdrF9PWGLYRPHYEIa54=;
        b=ePeqz0aM/IvNICczBF5tLo1vAJkp+CUs3WyBp51FDjX7mtCzB4y+XvhVoc0g0/CXgE
         wmS3QkZSvIEvbu447jdHbbBlmJLjLmJheOaUnd6bg23E0w0Tt2wpRJU47AQ/YWJqMZ9G
         IJZz6z4AQghlq/mzc2AZusFUOL2WhdEtrPKlXbLqPo2r646VkVvUk6IBPFxJUZQU0E9k
         9RTg0VxiJ2NafhPme9uHKDxWjJHYvTDwi2JoDtS9XXN4DVjwSKZnpNbejjQjOEdtCQvU
         FlCs4q8YWYLgfh8EE/5UdVrHyMJVTGNnyCQaks4UKJR0PzSTSgRDgLS3hkW5KN9/1ObE
         2IPg==
X-Received: by 10.180.216.40 with SMTP id on8mr4966777wic.55.1430394608334;
        Thu, 30 Apr 2015 04:50:08 -0700 (PDT)
Received: from [192.168.10.165] (dynamic-adsl-94-39-185-241.clienti.tiscali.it. [94.39.185.241])
        by mx.google.com with ESMTPSA id u6sm2987611wjy.13.2015.04.30.04.50.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 04:50:07 -0700 (PDT)
Message-ID: <554216EC.6070406@redhat.com>
Date:   Thu, 30 Apr 2015 13:50:04 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Christian Borntraeger <borntraeger@de.ibm.com>
CC:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/2] KVM: provide irq_unsafe kvm_guest_{enter|exit}
References: <1430394211-25209-1-git-send-email-borntraeger@de.ibm.com> <1430394211-25209-2-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1430394211-25209-2-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 30/04/2015 13:43, Christian Borntraeger wrote:
> +/* must be called with irqs disabled */
> +static inline void __kvm_guest_enter(void)
>  {
> -	unsigned long flags;
> -
> -	BUG_ON(preemptible());

Please keep the BUG_ON() in kvm_guest_enter.  Otherwise looks good, thanks!

Paolo

> -	local_irq_save(flags);
>  	guest_enter();
> -	local_irq_restore(flags);
> -
>  	/* KVM does not hold any references to rcu protected data when it
>  	 * switches CPU into a guest mode. In fact switching to a guest mode
>  	 * is very similar to exiting to userspace from rcu point of view. In
> @@ -769,12 +763,27 @@ static inline void kvm_guest_enter(void)
>  	rcu_virt_note_context_switch(smp_processor_id());
>  }
>  
> +/* must be called with irqs disabled */
> +static inline void __kvm_guest_exit(void)
> +{
> +	guest_exit();
> +}
> +
> +static inline void kvm_guest_enter(void)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	__kvm_guest_enter();
> +	local_irq_restore(flags);
> +}
> +
