Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 11:17:19 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:38846
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994839AbdHQJRIz8p5u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 11:17:08 +0200
Received: by mail-wr0-x242.google.com with SMTP id 49so1174898wrw.5
        for <linux-mips@linux-mips.org>; Thu, 17 Aug 2017 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aGrWoV4a5tShLYF+RUolwBbiCN//fMcNqXIqTitMB3s=;
        b=SpcD5cbXqGYev2jvwBD0Pc/pacPM9d7EHZi2RjxKjWakSayW/JD3EYSb3RAz1vX+jg
         jczluiqne3u6X3nwWvgSYBsaKBdJ3d4JckHx2DJ7ULpHgkmk+PSfWfbvzwbEuB+eTHFs
         8PMdat6bYH3ADjdwImFYhVH0rIe6+SzdShRckX0DLiTbiaq2v8ckhFqh2CtrauXzKln3
         T3c9F6XperQU36PsxuligZzi9swyhH4x9zn633UFTc4juIsyo3OHTy8IPCEZFxz1rq/G
         dbqvY84IzPRr9C9isQLlNXm/nzRZx8QDYWjPHZYcT98HPV797zD5BnHnYvt18WqmV7aO
         tNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aGrWoV4a5tShLYF+RUolwBbiCN//fMcNqXIqTitMB3s=;
        b=K6kRT4rMon1aO3c9Fabm72alUeyX/j9UlNEhrjyFwDRReJN/oeZvdSb8MYL5LSppxE
         L9fdCQiYcnbelpoQSWDlZUahLaNEnA/c1NLEb7r0qiHgbWfX7ePB93SGIMQarKQH20Yn
         WPw6ScD0gP38jUXByZf0sf1U1eFctUEa+ZbzooQjN6QvfEpd9gDvhOa59Yri/7zcGJhh
         VDYQulnjFbvcyAsQ2NQLU48/q3aMtFqbknKz/Pu4yOdCbHdz+Op7bAKE27p2FNeb9Hs8
         mj5/0MpGUP3ukRajWslGlytyd8I85Gs7o1kQNcHLA7070XTiyaAkLhtZwPLTY7g4hzxu
         IOnw==
X-Gm-Message-State: AHYfb5hZE4w1cyR9KtPYxOZP3GHi5Y5qkw0VGA61CRolILq5bJfNtMdX
        cqNW4urSaAxczA==
X-Received: by 10.28.232.132 with SMTP id f4mr872824wmi.163.1502961423601;
        Thu, 17 Aug 2017 02:17:03 -0700 (PDT)
Received: from [192.168.10.150] (94-39-192-75.adsl-ull.clienti.tiscali.it. [94.39.192.75])
        by smtp.googlemail.com with ESMTPSA id v9sm2834603wmg.41.2017.08.17.02.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2017 02:17:02 -0700 (PDT)
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
To:     Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Christoffer Dall <cdall@linaro.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        David Hildenbrand <david@redhat.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
 <20170817093612.024cc4bc.cohuck@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b69bc1e0-9d7b-5412-ba56-a5261d539a5b@redhat.com>
Date:   Thu, 17 Aug 2017 11:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170817093612.024cc4bc.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59611
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

On 17/08/2017 09:36, Cornelia Huck wrote:
>> What if we just sent a "vcpu move" request to all vcpus with the new 
>> pointer after it moved? That way the vcpu thread itself would be 
>> responsible for the migration to the new memory region. Only if all 
>> vcpus successfully moved, keep rolling (and allow foreign get_vcpu again).
>>
>> That way we should be basically lock-less and scale well. For additional 
>> icing, feel free to increase the vcpu array x2 every time it grows to 
>> not run into the slow path too often.
> 
> I'd prefer the rcu approach: This is a mechanism already understood
> well, no need to come up with a new one that will likely have its own
> share of problems.

What Alex is proposing _is_ RCU, except with a homegrown
synchronize_rcu.  Using kvm->srcu seems to be the best of both worlds.

Paolo
