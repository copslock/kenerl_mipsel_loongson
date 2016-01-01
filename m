Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jan 2016 18:23:56 +0100 (CET)
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33879 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009102AbcAARXycVRm1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jan 2016 18:23:54 +0100
Received: by mail-lf0-f48.google.com with SMTP id y184so249879515lfc.1
        for <linux-mips@linux-mips.org>; Fri, 01 Jan 2016 09:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=2BJQA0QVeePVboF/Vmww9BmcToMac4EqtXr6sRSPi+U=;
        b=FASK9t8U7pZZHO0YesrDPCbr1gpmYqCXTefGmuZcjOe5fnlPCc2SgzzjJDZ/7duIFb
         0r4lg/qmhoFHuhMm3bVzSdv3ibRdRHMts2nYa+Xeue2iM2yzALsCRBO9lpedxm8tbiz3
         0b9CmWjbBqh9XWTnYsBlu+f4ZePQO1613dgSGw8H3gi23AlJah8ZGBHjaBEvL9Nj1cBD
         jfZ0c/JJdOEd3UnoZSlInMREzTWboOBAFBAFV3siuiF5S9MEHqoztdFASyO5flxQQmeB
         vZ79CynYByEr9ZdrydbGfQZOPuu92VQf7jTxq3NzhTbk7V99r7Kyz0jlZD04Dcibq3q5
         ncXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2BJQA0QVeePVboF/Vmww9BmcToMac4EqtXr6sRSPi+U=;
        b=Vo0XSGNw6EYSFPwJT4egMTmm3XFI6FivIG0RSOjwB/TquyBlAg5KKEHvVCcQoqhwom
         F0QRIEjiUxzuHRprswBh28IM7373NivdRd5vHoLBXpWX/TiItdYWXz1V9wpnZ2O4CxsC
         DEr8LIqZ7UlHNhLwUx6QOegcj8dnjbLMHtQHzGpfjVm1RSFzEwgGSmgZMhNu1XVygsQ8
         qAkiddSUwYZDq3oUKny9xz7wMCNauTrZT8GpGZgp6v0lXB3UyQRZ+Ab/Xj53AHFdmlOk
         /UONx1U7SpJCeBmugytHbg/wTs1dlRDyQExz9vH99hKAfq1f5cCdONmisC1LHQw4HFuW
         510w==
X-Gm-Message-State: ALoCoQkAXVndaZ1xR+6hodjmc6/nK5ZO1iOD3QlPesPDtdLa3MIfy6f8rYk36AZvIK3zeQhPNrRAKoxPuZcpRCeMQvNNLG+4bg==
X-Received: by 10.25.90.195 with SMTP id o186mr27641903lfb.9.1451669028104;
        Fri, 01 Jan 2016 09:23:48 -0800 (PST)
Received: from [192.168.4.126] ([31.173.84.162])
        by smtp.gmail.com with ESMTPSA id xo4sm8646949lbb.27.2016.01.01.09.23.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Jan 2016 09:23:47 -0800 (PST)
Subject: Re: [PATCH v2 32/32] virtio_ring: use virt_store_mb
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-33-git-send-email-mst@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5686B622.6070600@cogentembedded.com>
Date:   Fri, 1 Jan 2016 20:23:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1451572003-2440-33-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 12/31/2015 10:09 PM, Michael S. Tsirkin wrote:

> We need a full barrier after writing out event index, using
> virt_store_mb there seems better than open-coding.  As usual, we need a
> wrapper to account for strong barriers.
>
> It's tempting to use this in vhost as well, for that, we'll
> need a variant of smp_store_mb that works on __user pointers.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/linux/virtio_ring.h  | 12 ++++++++++++
>   drivers/virtio/virtio_ring.c | 15 +++++++++------
>   2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index f3fa55b..3a74d91 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -45,6 +45,18 @@ static inline void virtio_wmb(bool weak_barriers)
>   		wmb();
>   }
>
> +static inline void virtio_store_mb(bool weak_barriers,
> +				   __virtio16 *p, __virtio16 v)
> +{
> +	if (weak_barriers)
> +		virt_store_mb(*p, v);
> +	else
> +	{

    The kernel coding style dictates:

	if (weak_barriers) {
		virt_store_mb(*p, v);
	} else {

> +		WRITE_ONCE(*p, v);
> +		mb();
> +	}
> +}
> +
[...]

MBR, Sergei
