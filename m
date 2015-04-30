Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 14:28:31 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37347 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012257AbbD3M2ar13KX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2015 14:28:30 +0200
Received: by widdi4 with SMTP id di4so15898156wid.0
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gJKFzwRnk7pp8AuQu2Uy5Tc0nSjtzdhGlsqX+hthCXY=;
        b=KkX71ME3j6hrRR+0jBog7+yYfzBDFe0FJG4tUd2NqwKW+K2jV+gjrUrN6hCoxPq1jb
         DCgJztMlOrbIiQ2x7LrG0+bq+flz5z9EGjwk0sH3AerKkLwWJXdqtVqrxRrDEvnPKWWc
         eBmp+2Z0cqOh9gtN9uckI7Cq6yKkWfBFT94mzeRMVL2nkTdvCYYA5RkNmsk31HX/Y8LT
         Duxf73FxsvDBvrUld0Ca+0zNgU+4DeiGaKLscBqNHepucriWSItgNk/QKEWL3R3CURZH
         ZUuJcj3l4deHSB3Z+rP14JgaeHbnfLcP5dkfZgZhhULnT9SShGcDrldhR+T4Q0pLmCmq
         7iJw==
X-Received: by 10.194.80.5 with SMTP id n5mr8149005wjx.123.1430396907379;
        Thu, 30 Apr 2015 05:28:27 -0700 (PDT)
Received: from [192.168.10.165] (dynamic-adsl-94-39-185-241.clienti.tiscali.it. [94.39.185.241])
        by mx.google.com with ESMTPSA id js3sm3141812wjc.5.2015.04.30.05.28.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 05:28:26 -0700 (PDT)
Message-ID: <55421FE7.3060905@redhat.com>
Date:   Thu, 30 Apr 2015 14:28:23 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Christian Borntraeger <borntraeger@de.ibm.com>
CC:     linux-mips@linux-mips.org, KVM <kvm@vger.kernel.org>,
        kvm-ppc@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH 1/2] KVM: provide irq_unsafe kvm_guest_{enter|exit}
References: <1430394211-25209-1-git-send-email-borntraeger@de.ibm.com> <1430394211-25209-2-git-send-email-borntraeger@de.ibm.com> <554216EC.6070406@redhat.com> <554219A1.8050006@de.ibm.com> <554219F2.9020805@de.ibm.com> <55421B0A.2060606@de.ibm.com>
In-Reply-To: <55421B0A.2060606@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47175
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



On 30/04/2015 14:07, Christian Borntraeger wrote:
>>>>> >>>> +static inline void __kvm_guest_enter(void)
>>>>> >>>>  {
>>>>> >>>> -	unsigned long flags;
>>>>> >>>> -
>>>>> >>>> -	BUG_ON(preemptible());
>>>> >>>
>>>> >>> Please keep the BUG_ON() in kvm_guest_enter.  Otherwise looks good, thanks!
>> > 
>> > Ah, you mean have the BUG_ON in the non underscore version? Yes, makes sense.
> Hmmm, too quick.
> the BUG_ON was there to make sure that rcu_virt_note_context_switch is safe.
> The reworked code pulls the rcu_virt_note_context_switch within the irq_save
> section so we no longer need this BUG_ON, no?

Right.  I can apply the patches then!

Paolo
