Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2015 14:08:29 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:35139 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011556AbbEEMI1RJo38 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 May 2015 14:08:27 +0200
Received: by labbd9 with SMTP id bd9so125650010lab.2
        for <linux-mips@linux-mips.org>; Tue, 05 May 2015 05:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=thOV6yKo93jKldDrzdmooAwfJXl/xhiFJrx6McdfYt8=;
        b=GmhPzP/VPHwccxCjMH0MqT5oLvOxzlzEbKq1jybnksl1d7Ya4QOXoAVhxOPcNyxEUn
         LBOuriG6KdVb1qbZlUAq3L5LklNdCDLWomIW22RhQQ7ozLr6taW3LOPT438xGrfF6CXx
         kjPq44WHvFMYytw4Xil4sp9KtAEnuArIxNCxEZpopfeK/E0HFNLSibihDzlYM/YxK8Qm
         y4jnWNA9449rclyioOW2SHjhWSeoLieVDbaRCdwrCzdw1NHNKPJkgSBOEo3CbZDD6sQ1
         C/sKfIy3fQz2ROcAAOd0fhI88X+r69yuBztkcvRdvGq2QpDD2M85TiHW4RUmsMYc9EbT
         Ik4g==
X-Gm-Message-State: ALoCoQmmw2gsJJfFnSB0wqv4AWXCuyCjP+/ToRmOqo4xulN5FUUzCDoltVZ3h1672YF8EBX3IIpJ
X-Received: by 10.152.42.141 with SMTP id o13mr23858198lal.33.1430827703795;
        Tue, 05 May 2015 05:08:23 -0700 (PDT)
Received: from localhost (188-178-240-98-static.dk.customer.tdc.net. [188.178.240.98])
        by mx.google.com with ESMTPSA id fb5sm4018631lbc.35.2015.05.05.05.08.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 05 May 2015 05:08:22 -0700 (PDT)
Date:   Tue, 5 May 2015 14:08:22 +0200
From:   Christoffer Dall <christoffer.dall@linaro.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>,
        kvm-ppc@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/2] KVM: arm/mips/x86/power use __kvm_guest_{enter|exit}
Message-ID: <20150505120822.GB19385@cbox>
References: <1430394211-25209-1-git-send-email-borntraeger@de.ibm.com>
 <1430394211-25209-3-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430394211-25209-3-git-send-email-borntraeger@de.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christoffer.dall@linaro.org
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

On Thu, Apr 30, 2015 at 01:43:31PM +0200, Christian Borntraeger wrote:
> Use __kvm_guest_{enter|exit} instead of kvm_guest_{enter|exit}
> where interrupts are disabled.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

For the ARM part:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
