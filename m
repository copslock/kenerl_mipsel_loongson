Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 23:17:44 +0200 (CEST)
Received: from mail-da0-f54.google.com ([209.85.210.54]:35531 "EHLO
        mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835050Ab3ESVRoAPCXW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 May 2013 23:17:44 +0200
Received: by mail-da0-f54.google.com with SMTP id z17so3468617dal.27
        for <multiple recipients>; Sun, 19 May 2013 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=J1Em+WJ16uuviAyLMz4YYEhIW4lbo4wvlyAsXVVKJfk=;
        b=LKk714X3W3gNYuOUeEX9b5vQn8m9jDGXVfhVclX2kg17yL3ViGVPhi3FVR+3hoN1eT
         huEwbSdGWdU6xbawb3JwEShFsaMEvo1UTauWU+O2qRhOQAtrPtp0sr6SWPiD3yEniZXt
         yqlEM3eLTgIq9ZVK6C4BepdjEUSp4+N/ie9wWd+iK1xi8/Gu+5N05sSsdM4BJWtm6hF9
         FgJHCT2FATbVrbGpeGPfR3FR9j60wzXz3XYeSPUy4/ccg1Y+ctvRtrInWbKw0OI98fYT
         s8aRCjT3oM96P5Pw60SS0xgDgNN3gRTxA7uVi5Ku3e8Gn/1OSdcpLtwKTr5JJrFqNfpA
         exYw==
X-Received: by 10.68.1.34 with SMTP id 2mr25005398pbj.3.1368998256910;
        Sun, 19 May 2013 14:17:36 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-124-149-141.dsl.pltn13.pacbell.net. [67.124.149.141])
        by mx.google.com with ESMTPSA id rn7sm20994664pbc.12.2013.05.19.14.17.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 14:17:35 -0700 (PDT)
Message-ID: <5199416D.1010200@gmail.com>
Date:   Sun, 19 May 2013 14:17:33 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Gleb Natapov <gleb@redhat.com>
CC:     Sanjay Lal <sanjayl@kymasys.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, ralf@linux-mips.org, mtosatti@redhat.com,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 4/4] KVM/MIPS32: Bring in patch from David Daney with
 new 64 bit compatible ABI.
References: <n> <1368885266-8619-1-git-send-email-sanjayl@kymasys.com> <1368885266-8619-5-git-send-email-sanjayl@kymasys.com> <20130519141712.GL4725@redhat.com>
In-Reply-To: <20130519141712.GL4725@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
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

On 05/19/2013 07:17 AM, Gleb Natapov wrote:
> On Sat, May 18, 2013 at 06:54:26AM -0700, Sanjay Lal wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> There are several parts to this:
>>
>> o All registers are 64-bits wide, 32-bit guests use the least
>>    significant portion of the register storage fields.
>>
>> o FPU register formats are defined.
>>
>> o CP0 Registers are manipulated via the KVM_GET_MSRS/KVM_SET_MSRS
>>    mechanism.
>>
>> The vcpu_ioctl_get_regs and vcpu_ioctl_set_regs function pointers
>> become unused so they were removed.
>>
>> Some IOCTL functions were moved to kvm_trap_emul because the
>> implementations are only for that flavor of KVM host.  In the future, if
>> hardware based virtualization is added, they can be hidden behind
>> function pointers as appropriate.
>>
> David, can you please divide this one big patch to smaller patches
> with each one having only one of the changes listed above?

Expanding the registers to 64 bits changes only four lines. Defining the 
FPU registers is an additional seven lines.  The rest really has to be 
an atomic change.

The point here is that we change the ABI.  Any userspace tools have to 
change too.  So is it better to have a multi-part patch set where the 
interface is unusable in the intermediate patches?  Or is it preferable 
to do an 'atomic' switch?

It wasn't out of laziness that I chose to do it this way, it was because 
I thought it was cleaner.

So to directly answer your question:  I prefer not to split this up, and 
would want to have a better reason than an orthodox interpretation of 
SubmittingPatches sec. 3.

David Daney
