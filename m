Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 15:54:46 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:30199 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819780Ab2KAOypIHXQ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Nov 2012 15:54:45 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA1Esfvd021551
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 1 Nov 2012 10:54:41 -0400
Received: from balrog.usersys.tlv.redhat.com (dhcp-4-121.tlv.redhat.com [10.35.4.121])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qA1EsdJD015188;
        Thu, 1 Nov 2012 10:54:39 -0400
Message-ID: <50928D2E.9090409@redhat.com>
Date:   Thu, 01 Nov 2012 16:54:38 +0200
From:   Avi Kivity <avi@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 01/20] KVM/MIPS32: Infrastructure/build files.
References: <6A87701A-F946-489D-AFC3-3BC8B7723CE0@kymasys.com>
In-Reply-To: <6A87701A-F946-489D-AFC3-3BC8B7723CE0@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-archive-position: 34844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: avi@redhat.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/31/2012 05:17 PM, Sanjay Lal wrote:
> - Add the KVM option to MIPS build files.
> - Add default config files for KVM host/guest kernels.
> - Change the link address for the Malta KVM Guest kernel to UM (0x40100000).
> - Add KVM Kconfig file with KVM/MIPS specific options
> 
> index dba9390..8ac1aa1 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1284,6 +1284,8 @@ config CPU_MIPS32_R2
>  	select CPU_HAS_PREFETCH
>  	select CPU_SUPPORTS_32BIT_KERNEL
>  	select CPU_SUPPORTS_HIGHMEM
> +    select HAVE_KVM
> +    
>  	help
>  	  Choose this option to build a kernel for release 2 or later of the
>  	  MIPS32 architecture.  Most modern embedded systems with a 32-bit
> @@ -1789,6 +1791,21 @@ config 64BIT
>  
>  endchoice
>  
> +config KVM_GUEST
> +   bool "KVM Guest Kernel"
> +   depends on HAVE_KVM 
> +   help
> +    Select this option if building a guest kernel for KVM (Trap & Emulate) mode


HAVE_KVM indicates that the host has virtualization support for KVM.  It
says nothing about the guest.  So KVM_GUEST need not depend on HAVE_KVM.

> +
> +config KVM_HOST_FREQ
> +    int "KVM Host Processor Frequency (MHz)"
> +    depends on HAVE_KVM 
> +    default 500
> +    help
> +      Select this option if building a guest kernel for KVM to skip
> +      RTC emulation when determining guest CPU Frequency.  Instead, the guest
> +      processor frequency is automatically derived from the host frequency.
> +

And this should depend on KVM_GUEST (or be avoided completely, why not
use it always?)



-- 
error compiling committee.c: too many arguments to function
