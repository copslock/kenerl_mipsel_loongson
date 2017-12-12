Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 17:47:38 +0100 (CET)
Received: from mail-wr0-x230.google.com ([IPv6:2a00:1450:400c:c0c::230]:38026
        "EHLO mail-wr0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990718AbdLLQrbRJYyN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 17:47:31 +0100
Received: by mail-wr0-x230.google.com with SMTP id o2so21828137wro.5
        for <linux-mips@linux-mips.org>; Tue, 12 Dec 2017 08:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1tZhXIdBiK+/A9SzT0dCj8/InryiDXoncXLPhbikw4E=;
        b=s7HG9HhUA2LT5plZLYIPLZkle5W+xPhnII2pIRvCPv/RywAiNM47ZzUcGAv5dt+9zI
         gYi8HzjOoN5jU739mKQ+IoFLxJMMCMGOKaAJf0G7/bM07gGfygaN0n7c/3hxB4aSxVdP
         YB9lqdutjYa289gblIj1LMlfRxAnVHvIPIylBr+eVFprGFM7OYD5ycQHK3srTIVN1Fhb
         zKmo4G8vKw8Q7pYjMKY/WPFwzPoKNG1q+khxhCXACRL/dv1qLrIT845taOcUY5/hkpdb
         yDD2pYrjo1nP448Z0BgIaJeZKH/XRU65FETWkB9oiTAz8mV+he7Xjc/bmsmay3VRz64S
         JRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1tZhXIdBiK+/A9SzT0dCj8/InryiDXoncXLPhbikw4E=;
        b=Ybn0GzEyPEhu45g29aiKcTDI8nZbCYbe8eYDY4NoRwiCOag3dbz0WUG8zG7m0yXbqG
         I9nqYUkPFT68sUE6iRyLNWWzVowuO14ocn2wBVlrLmYf8FWCvNxqi32f5bNXUXjMQv/2
         eN0GU205UxvS2zFeUdmrcjLKBi0+TMFs5okn960wttW0/pJnKjh0Wy3Rms7WPksIqq/A
         dJLu/XrR1JGU7b2VH2Rx/HYClm+H4+4B9JM32LfBr2CrtQ8GnxGSyiRieAztPBrbSgtO
         hMczaA8btz3TT97iTbq3hmZRw4l+9A3rNDQNgnblydS7ImejAo746rr/AU7lNy+yn3+b
         ZU8A==
X-Gm-Message-State: AKGB3mJEmu8RJw8nrgOK712tW7YuYADo+R6ChIeWk92Flepl+m1xc1mC
        dJReNbbh5eZ5B510GfBJouM=
X-Google-Smtp-Source: ACJfBot+WWHBpnoR/EIhP1B3LvbYx/urdECXZ6BwGPgIJyvI/xOa3eHDmXxP2ua0vN6V52fSO8lXPg==
X-Received: by 10.223.135.77 with SMTP id 13mr4495132wrz.142.1513097244120;
        Tue, 12 Dec 2017 08:47:24 -0800 (PST)
Received: from [192.168.10.165] (dynamic-adsl-78-12-251-125.clienti.tiscali.it. [78.12.251.125])
        by smtp.googlemail.com with ESMTPSA id 43sm21077841wru.81.2017.12.12.08.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Dec 2017 08:47:23 -0800 (PST)
Subject: Re: [PATCH v3 14/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl
To:     Christoffer Dall <christoffer.dall@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Christoffer Dall <cdall@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-15-cdall@kernel.org>
 <20171211141241.2129a84c.cohuck@redhat.com> <20171211152226.GJ910@cbox>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a6052a0-29d3-5a5e-b0c2-1d99804bcba4@redhat.com>
Date:   Tue, 12 Dec 2017 17:47:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171211152226.GJ910@cbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61449
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

On 11/12/2017 16:22, Christoffer Dall wrote:
> I find the special casing with the immediate return a bit ugly. Maybe
> introduce a helper async_vcpu_ioctl() or so that sets -ENOIOCTLCMD in
> its default case and return here if ret != -ENOIOCTLCMD? Christian,
> what do you think?

I'll post my attempt at it shortly.

Thanks,

Paolo
