Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 14:40:11 +0200 (CEST)
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38130 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992227AbcGEMkF0nL4h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jul 2016 14:40:05 +0200
Received: by mail-wm0-f51.google.com with SMTP id r201so150848380wme.1;
        Tue, 05 Jul 2016 05:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=vvuJzLnq8IdtmiARswhaeH1tBvMOaz92109zNW+qwMo=;
        b=CnWm8uu1y5ybFGQrtdk3uiDv/LFL73WDpFM9HNOECHg4sepTJljlHXVrhyVvzVBKDj
         2feRVCDJ/fYdHaiE+hMfKSj4cBtL7YFulj+zN/Ha8950Z/KUiMM5PrwWPoROKgAGuAL6
         mkhCqEhSHdw+zIshjIB92dDjSnzNm4SJwSvveInxzUp1WWXRM6hb3vua34QK6bNkh0wx
         WaIqIa61VxFNaOB6Y8ns6O2P/AGzg20RnrD9uOxtP/UG9i1EzcIYOEV4z+rG8NMJgYqV
         2CboxNu1wrjjNEQNyJ41qpMlDc66xIlE5U1hmHwVBn2C6iXlNXITnYlUIVSFIksWnm5V
         9w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=vvuJzLnq8IdtmiARswhaeH1tBvMOaz92109zNW+qwMo=;
        b=h42N3xT9ZLQuQDFr2b+r4TT0Wq7CS78GuyE1GFonaUEBO8z1yYeL9E58h5xwR9VGk+
         f+qJl080dajAqWQhspm1xCqiWNGurbEDQ7iSV7SvM6QBJy41ZycUk/BC98tZ1uPyRwNT
         nV003fOZwAC7q+ISeFD0YGQXSuzCKYP/JQi9i71WpG9Dguhno12bLiiY+7X9QCokG6ad
         3fEj6xioPOFLvyzoh2tSsZJJ9RloqbnDUTa9/Klyc8HMX/P8+rBBF0FTO0hgWPLcrKiM
         p0wBDKlg0rxBl8wjtEkrGIvWAwra6uj4e/53/d50eFkaW6L0fC7aEKPFr1NQ1HXuu3P4
         IzEg==
X-Gm-Message-State: ALyK8tLtalrP6rrQXFYsEyHEhNwnU6m+3HZ2yHlP0TWlOlzTZy5kIsxlVBMyp58CfSyxDQ==
X-Received: by 10.194.39.6 with SMTP id l6mr4504991wjk.139.1467722400049;
        Tue, 05 Jul 2016 05:40:00 -0700 (PDT)
Received: from [192.168.10.165] (94-39-188-118.adsl-ull.clienti.tiscali.it. [94.39.188.118])
        by smtp.googlemail.com with ESMTPSA id k3sm4554240wju.29.2016.07.05.05.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2016 05:39:59 -0700 (PDT)
Subject: Re: [PATCH 8/9] MIPS: KVM: Decode RDHWR more strictly
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
 <1467657315-19975-9-git-send-email-james.hogan@imgtec.com>
 <24b4b1b6-2a58-63f8-f2c2-78ecc6eceb4e@cogentembedded.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4bd15b0-ec72-14d4-7bc4-e71e6b2accc3@redhat.com>
Date:   Tue, 5 Jul 2016 14:39:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <24b4b1b6-2a58-63f8-f2c2-78ecc6eceb4e@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54217
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



On 05/07/2016 13:16, Sergei Shtylyov wrote:
>>      if (inst.r_format.opcode == spec3_op &&
>> -        inst.r_format.func == rdhwr_op) {
>> +        inst.r_format.func == rdhwr_op &&
>> +        inst.r_format.rs == 0 &&
>> +        (inst.r_format.re >> 3) == 0) {
> 
>    Inner parens not necessary here.

They are nicer though.

Paolo
