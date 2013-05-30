Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 20:35:54 +0200 (CEST)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:39122 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825726Ab3E3SfthJ-0A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 May 2013 20:35:49 +0200
Received: by mail-pb0-f41.google.com with SMTP id xb12so835963pbc.14
        for <multiple recipients>; Thu, 30 May 2013 11:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=58HeNHrYGEMUSBIXaL7lB0O+79OzVc+9hZ7mZ0H2dSk=;
        b=00I6NbMVjBv5umxf4ZMtlTj2DGT24XMD8Et17Bjy+db3sSFW87fCinkJDc8VGE2dFZ
         C3X7JZ3zIy23SCpgbHHCn7carr3XFUhewRG91ua8T0PJSMhwAhfTRiBQDvmv3hJNWOxS
         SuJD37qzSDvpIjMFQ52barn3l1zMW+v9pt8Ht02tCcqYvZXG8sVkxXpkdIC9muh/NuGZ
         Fhli04bCZZGMXhNbBH+ey0f303qAvWuOFftrTgiXmUGqZTjEP5119eKHrhulKL55UQtf
         Hu7cAodCSgIRxI0y60Ph/1wnhn00Zf3ZNUoMvOHp3U3fu/XcJHPmQMKEqY/j992W2SoF
         4gEg==
X-Received: by 10.66.122.130 with SMTP id ls2mr9712855pab.128.1369938943054;
        Thu, 30 May 2013 11:35:43 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id qh4sm45912844pac.8.2013.05.30.11.35.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 11:35:42 -0700 (PDT)
Message-ID: <51A79BFC.6060204@gmail.com>
Date:   Thu, 30 May 2013 11:35:40 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Sanjay Lal <sanjayl@kymasys.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 10/18] KVM/MIPS32-VZ: Add API for VZ-ASE Capability
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-11-git-send-email-sanjayl@kymasys.com> <51A4DC99.7040706@redhat.com> <51A7875F.4080606@gmail.com> <51A79193.6080908@redhat.com>
In-Reply-To: <51A79193.6080908@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/30/2013 10:51 AM, Paolo Bonzini wrote:
> Il 30/05/2013 19:07, David Daney ha scritto:
>> On 05/28/2013 09:34 AM, Paolo Bonzini wrote:
>>> Il 19/05/2013 07:47, Sanjay Lal ha scritto:
>>>> - Add API to allow clients (QEMU etc.) to check whether the H/W
>>>>     supports the MIPS VZ-ASE.
>>>
>>> Why does this matter to userspace?  Do the userspace have some way to
>>> detect if the kernel is unmodified or minimally-modified?
>>>
>>
>> There are (will be) two types of VM presented by MIPS KVM:
>>
>> 1) That provided by the initial patch where a faux-MIPS is emulated and
>> all kernel code must be in the USEG address space.
>>
>> 2) Real MIPS, addressing works as per the architecture specification.
>>
>> Presumably the user-space client would like to know which of these are
>> supported, as well as be able to select the desired model.
>
> Understood.  It's really two different machine types.
>
>> I don't know the best way to do this, but I agree that
>> KVM_CAP_MIPS_VZ_ASE is probably not the best name for it.
>>
>> My idea was to have the arg of the KVM_CREATE_VM ioctl specify the
>> desired style
>
> Ok.  How complex is it?  Do you plan to do this when the patches are
> "really ready" for Linus' tree?

I am currently working on preparing a patch set that implements MIPS-VZ 
in a slightly different manner than Sanjay's patches.  So there will 
likely be some back and forth getting everything properly integrated 
into a sane implementation

So I don't know exactly how to answer this question other than to say, 
that I don't think things should go into Linus's tree until they are 
"really ready", which would include resolving this issue.

David Daney
