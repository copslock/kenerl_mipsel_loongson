Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Nov 2017 10:11:14 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:46815
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbdKZJLFv9iZx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 Nov 2017 10:11:05 +0100
Received: by mail-wr0-x243.google.com with SMTP id r2so17239842wra.13
        for <linux-mips@linux-mips.org>; Sun, 26 Nov 2017 01:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AVx3yNPLt8bn1vbK3u9EbRelEJ6Pk4HFMHCRbGfeTAE=;
        b=JnrUHygT05xO7KTvbufLuo1LvNZ/ikW7cT7O/BecGh0LKYxZGdIEsdj/PKOiDlRuC2
         a/Vw5A3JT1ppBGts9nrBMh7/6TLCqIPDKZ56pLAGJCCLvq0vw3L5weeadRiL4YSUD56/
         ghMJey940FsHorbrU/B4K+iP51yMcDi+D7RQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AVx3yNPLt8bn1vbK3u9EbRelEJ6Pk4HFMHCRbGfeTAE=;
        b=t62nEkfLfAVRyudlyb2Rx1vxWucjf6HNMME7sM2QUIh1JcZ9RfwNmANQpfCkkuM2fZ
         U0r5Jcv6TK55gTkl6pEk/glTLW1pPDyNPeuKAAIHV9OEwwbRa59v5N7zPaULRAN4Gv33
         OcfWE3smmZmh5JJ4euE830IWYxa88s6qVUI8lBm3iD2fpH4Q2ESnrq4E+WwFqqmftWlU
         iBUuz3605W0tGsZ86bsi5R24tULVCbUXjdZlN5tdZGrrIJc36aJ6+IU8meTor/W3Mv0+
         aQU0kP2rtoSuwgOnnqskSs8lCjq5HzYJb4t4c7mHDxhBP+b9p8hMIVLOW2j3gKlNwjYP
         okuA==
X-Gm-Message-State: AJaThX5Nt5q21+DimOLWxYeSwAbiq8DvRXbIDyu7Yx3482y/1wOeIn3l
        J2f8Bq8KkjDVGGWGnxKAWM3f7Q==
X-Google-Smtp-Source: AGs4zMadr4GyTeEa/8emLF9ZihHFq+VFwUSIGqfGT5ApybEAr2hPxApL0/NO0cJAVSOBOJ1vg/t7Sg==
X-Received: by 10.223.185.107 with SMTP id b40mr563756wrg.264.1511687460438;
        Sun, 26 Nov 2017 01:11:00 -0800 (PST)
Received: from localhost (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id t91sm16439444wrc.74.2017.11.26.01.10.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 26 Nov 2017 01:10:59 -0800 (PST)
Date:   Sun, 26 Nov 2017 10:11:08 +0100
From:   Christoffer Dall <cdall@linaro.org>
To:     Christoffer Dall <christoffer.dall@linaro.org>
Cc:     kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 00/15] Move vcpu_load and vcpu_put calls to arch code
Message-ID: <20171126091108.GI28855@cbox>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cdall@linaro.org
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

On Sat, Nov 25, 2017 at 09:57:03PM +0100, Christoffer Dall wrote:
> Some architectures may decide to do different things during
> kvm_arch_vcpu_load depending on the ioctl being executed.  For example,
> arm64 is about to do significant work in vcpu load/put when running a
> vcpu, but it's problematic to do this for any other vcpu ioctl than
> KVM_RUN.
> 
> Further, while it may be possible to call kvm_arch_vcpu_load() for a
> number of non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult
> to reason about, especially after my optimization series, because a lot
> of things can now happen, where we have to consider if we're really in
> the process of running a vcpu or not.
> 
> This series will first move the vcpu_load() and vcpu_put() calls in the
> arch generic dispatch function into each case of the switch statement
> and then, one-by-one, pushed the calls down into the architecture
> specific code making the changes for each ioctl as required.
> 
And the patches are also available at:

git://git.kernel.org/pub/scm/linux/kernel/git/cdall/linux.git vcpu-load-put

Thanks,
-Christoffer
