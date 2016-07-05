Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 16:34:40 +0200 (CEST)
Received: from mail-lf0-f44.google.com ([209.85.215.44]:32849 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992932AbcGEOeeeEIrm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jul 2016 16:34:34 +0200
Received: by mail-lf0-f44.google.com with SMTP id f6so136028325lfg.0
        for <linux-mips@linux-mips.org>; Tue, 05 Jul 2016 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7qXFd+MeVLs2yHBDiu3DM5bnBkfk10uB73iOtDoz4Cg=;
        b=T3rxlptQ2H6rlhf7uN0mcmHw77l0k5HkGVBeiBbHZF5gfqmiaw5mQcwfl7b/PjzeeS
         Nmkr/I7hnP0eByn8ivQv2p+AxrBC3WC9DVqDrF0VPNZEjtm9kIbSvqzvTYc4KRdMrUP/
         mb9bhU4WeMj8Wh1jYBNW9PsyM2AvgZusKZlo5K8auKr7KqFgXoPS3HUEqo73IyYyWp2Z
         9HJyvEO1rB1Gt2yLDNIli6zeQxOxjFpswOJ6hEWk7dxUNeaRkSQ6JxHARR+QzGSxTTnq
         31UswUa29Vre2v0gVxXoXPX9Ws+wEG7ax7E+SXKds1m2wj/dE1wKb6lR3htVhS1ewtPP
         P5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=7qXFd+MeVLs2yHBDiu3DM5bnBkfk10uB73iOtDoz4Cg=;
        b=SZEpvkwDtrlGkp4IKB8JguvhI53GzXVfkeEAsNMIoZwkkT7jl++XNfhqoWurkUwKaS
         JRdec2bCXfwYhtaprzney09RXlcOxxLFzEyEqMKdU4iy0dsNDx2T7aO1yhlufTw7TN61
         L+gjbb5h0eOtQcNgzUmGj9Ycj3QQ0UgbPM/iunovqaqEudHK8yosq8kW+fmdpm/Oc9M5
         ZdzCJ3cGHiSla3Yb9GVbbhCIN4kCtY/3aM58W1L/Dr6nNM/4uj6XIL/r3jpCov5hVYVX
         Q1Ibc3R6DJOIXebJQ1ADqwVp8b0fB5XueWLB90Jhtb4Rdq4AlRI+l1pZt38IpIeY+GsA
         KbqQ==
X-Gm-Message-State: ALyK8tK3cHVHU9/ycrgE/Vds2c8hemoFLUl+luayAHMxkmExwfVw7kRtb9cfZph/wpIp0Q==
X-Received: by 10.46.33.226 with SMTP id h95mr4435212lji.35.1467729269007;
        Tue, 05 Jul 2016 07:34:29 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.157])
        by smtp.gmail.com with ESMTPSA id 12sm5560348ljf.17.2016.07.05.07.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2016 07:34:27 -0700 (PDT)
Subject: Re: [PATCH 8/9] MIPS: KVM: Decode RDHWR more strictly
To:     Paolo Bonzini <pbonzini@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
 <1467657315-19975-9-git-send-email-james.hogan@imgtec.com>
 <24b4b1b6-2a58-63f8-f2c2-78ecc6eceb4e@cogentembedded.com>
 <e4bd15b0-ec72-14d4-7bc4-e71e6b2accc3@redhat.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <30f5d570-1133-839b-8175-ed47401c1e44@cogentembedded.com>
Date:   Tue, 5 Jul 2016 17:34:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <e4bd15b0-ec72-14d4-7bc4-e71e6b2accc3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54226
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

On 07/05/2016 03:39 PM, Paolo Bonzini wrote:

>>>      if (inst.r_format.opcode == spec3_op &&
>>> -        inst.r_format.func == rdhwr_op) {
>>> +        inst.r_format.func == rdhwr_op &&
>>> +        inst.r_format.rs == 0 &&
>>> +        (inst.r_format.re >> 3) == 0) {
>>
>>    Inner parens not necessary here.
>
> They are nicer though.

    I wouldn't say so...

> Paolo

MBR, Sergei
