Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 May 2013 18:34:55 +0200 (CEST)
Received: from mail-qa0-f49.google.com ([209.85.216.49]:42126 "EHLO
        mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834873Ab3E1QevCNiIW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 May 2013 18:34:51 +0200
Received: by mail-qa0-f49.google.com with SMTP id j11so1603527qag.8
        for <multiple recipients>; Tue, 28 May 2013 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=X9b+f8gShUywG7EtH8NCyJaqj1qPNvPYQR2iMqmaqII=;
        b=LpsPrli0E3PVP2Gb1/4/FkQcpG+TOUf7DYI2+Mz9gb3q52llASd87lwGdlknKVFez9
         qfnrqAYIjBJOEoESItxPjVptJvvxdg0tx4byuNu+QLkWAZxL0FLvWFB+b5UvLThDqXL3
         Yrv1Q1rMuIIuyO72amS4Zr8smbXiwvfBDVhegKY2i4C2CHOh0cTDmhKMdxPwsnXD3kHD
         RfCngOjxRlqyaQdAZUXA5eKuOA7nwMp/ZS6W9MBnK8/LgwdvrgrnlhutR1xWpvxGC6nR
         HDKk7gXB5EhqOsoljqmLOOm+W2BdeSF1+lwJ5GJk7FM/4rBltGjs/0igK3snXaOPbD7n
         XKHw==
X-Received: by 10.224.3.10 with SMTP id 10mr25057231qal.85.1369758884950;
        Tue, 28 May 2013 09:34:44 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-117-138-128.cust.dsl.vodafone.it. [37.117.138.128])
        by mx.google.com with ESMTPSA id y1sm28608247qad.5.2013.05.28.09.34.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 09:34:44 -0700 (PDT)
Message-ID: <51A4DC99.7040706@redhat.com>
Date:   Tue, 28 May 2013 18:34:33 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 10/18] KVM/MIPS32-VZ: Add API for VZ-ASE Capability
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-11-git-send-email-sanjayl@kymasys.com>
In-Reply-To: <1368942460-15577-11-git-send-email-sanjayl@kymasys.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36625
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

Il 19/05/2013 07:47, Sanjay Lal ha scritto:
> - Add API to allow clients (QEMU etc.) to check whether the H/W
>   supports the MIPS VZ-ASE.

Why does this matter to userspace?  Do the userspace have some way to
detect if the kernel is unmodified or minimally-modified?

Paolo

> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>  include/uapi/linux/kvm.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index a5c86fc..5889e976 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -666,6 +666,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_IRQ_MPIC 90
>  #define KVM_CAP_PPC_RTAS 91
>  #define KVM_CAP_IRQ_XICS 92
> +#define KVM_CAP_MIPS_VZ_ASE 93
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> 
