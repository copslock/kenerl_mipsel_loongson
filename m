Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 19:29:32 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36578 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824780Ab3ETR30f-Sx1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 May 2013 19:29:26 +0200
Received: by mail-pa0-f47.google.com with SMTP id kl13so5891316pab.34
        for <multiple recipients>; Mon, 20 May 2013 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=DZV5U2L5PHRIPNuV6P4znNknFbHD4eEv2Lu5IpgXvFg=;
        b=Xrgha8j64yy7qd0LoYB6m8z5ths5Aat1xY5bl2SFx57TpDUl9DJWN5jI/k//HlUzax
         tsx3aIc+MQQn2tmfawwO1LF+gCUlql8KUrGJwMPz257qa6qh9Pb+f9VfG8tWoWjpvrO7
         RT9rRGdBZmNbwpEPjtOoeRLHQWuyJbeeKDfb36qaBoTd0QGKLzMpsAZnoL8eTHbc7t8H
         4Pv7Dj4BlLXv/aEU1SDCjXnyAOSBSy8nMugrq0usyxV6wQPbGlofyLC55yArol+Zw79E
         oLa4ZepwVMoDmTIGYFwL/GjSrY9HhnQD7Bd1gCFMurexPjoH3wpp6FTjvlSuViLRwQZI
         9hMQ==
X-Received: by 10.68.226.225 with SMTP id rv1mr58659961pbc.55.1369070956313;
        Mon, 20 May 2013 10:29:16 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id xl10sm26636160pac.15.2013.05.20.10.29.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 10:29:15 -0700 (PDT)
Message-ID: <519A5D69.3070909@gmail.com>
Date:   Mon, 20 May 2013 10:29:13 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 00/18] KVM/MIPS32: Support for the new Virtualization
 ASE (VZ-ASE)
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <519A4640.6060202@gmail.com> <456B70C6-A896-4B94-B8EF-DE6ED26CE859@kymasys.com>
In-Reply-To: <456B70C6-A896-4B94-B8EF-DE6ED26CE859@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36485
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

On 05/20/2013 09:58 AM, Sanjay Lal wrote:
>
> On May 20, 2013, at 8:50 AM, David Daney wrote:
>
>> On 05/18/2013 10:47 PM, Sanjay Lal wrote:
>>> The following patch set adds support for the recently announced virtualization
>>> extensions for the MIPS32 architecture and allows running unmodified kernels in
>>> Guest Mode.
>>>
>>> For more info please refer to :
>>> 	MIPS Document #: MD00846
>>> 	Volume IV-i: Virtualization Module of the MIPS32 Architecture
>>>
>>> which can be accessed @: http://www.mips.com/auth/MD00846-2B-VZMIPS32-AFP-01.03.pdf
>>>
>>> The patch is agains Linux-3.10-rc1.
>>>
>>> KVM/MIPS now supports 2 modes of operation:
>>>
>>> (1) VZ mode: Unmodified kernels running in Guest Mode.  The processor now provides
>>>      an almost complete COP0 context in Guest mode. This greatly reduces VM exits.
>>
>> Two questions:
>>
>> 1) How are you handling not clobbering the Guest K0/K1 registers when a Root exception occurs?  It is not obvious to me from inspecting the code.
>>
>> 2) What environment are you using to test this stuff?
>>
>> David Daney
>>
>
> (1) Newer versions of the MIPS architecture define scratch registers for just this purpose, but since we have to support standard MIPS32R2 processors, we use the DDataLo Register (CP0 Register 28, Select 3) as a scratch register to save k0 and save k1 @ a known offset from EBASE.
>

Right, I understand that.  But I am looking at arch/mips/mm/tlbex.c, and 
I don't see the code that does that for TLBRefill exceptions.

Where is it done for interrupts?  I would expect code in 
arch/mips/kernel/genex.S and/or stackframe.h would handle this.  But I 
don't see where it is.

Am I missing something?

David Daney
