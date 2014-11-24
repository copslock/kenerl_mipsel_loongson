Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 19:02:59 +0100 (CET)
Received: from mail-qg0-f50.google.com ([209.85.192.50]:62310 "EHLO
        mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006897AbaKXSC6WzfY8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 19:02:58 +0100
Received: by mail-qg0-f50.google.com with SMTP id i50so4005992qgf.9
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 10:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SFbFfyv8R8VJQUwGWD3GVySGgGzO+Kp0sIRUo5yn2ss=;
        b=NexmQ5Ke7njbXtwneyXMkdmZvu0brZp+C8fDpn67399sLTuyyfRNupJsczpnr/DoTe
         FSGzGr8774Iu7lzSfjs8qwLx1KyZMTtbhkJNmG3GyjfWwCuAurI4ahfO1r/Yums9++qR
         gjB5IL2Ptrxy5C+c7eSBk/X1VOSDsnO0NQBaUDEJUP+Aco0C+d9Ulo+N8IPSWqottzDQ
         sSD/nHJV2/mhIOs/BD14hTVcsNCJQRlALm5TXiYUADT+y2pwJCuqYfIC92cjeZ9u52IX
         wj1PWYWJ3djCU6QT6kXMge31gznRlf6hkwWz90IdF8ZTy/Ghx06grh2hLTcxTxbDxd5D
         5opQ==
MIME-Version: 1.0
X-Received: by 10.140.20.175 with SMTP id 44mr29870790qgj.22.1416852172143;
 Mon, 24 Nov 2014 10:02:52 -0800 (PST)
Received: by 10.96.89.33 with HTTP; Mon, 24 Nov 2014 10:02:52 -0800 (PST)
In-Reply-To: <15567.1416835858@warthog.procyon.org.uk>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
        <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
        <15567.1416835858@warthog.procyon.org.uk>
Date:   Mon, 24 Nov 2014 10:02:52 -0800
Message-ID: <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-x86_64@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <alexei.starovoitov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexei.starovoitov@gmail.com
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

On Mon, Nov 24, 2014 at 5:30 AM, David Howells <dhowells@redhat.com> wrote:
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>> +#define get_scalar_volatile_pointer(x) ({ \
>> +     typeof(x) *__p = &(x); \
>> +     volatile typeof(x) *__vp = __p; \
>> +     (void)(long)*__p; __vp; })
>> +#define ACCESS_ONCE(x) (*get_scalar_volatile_pointer(x))

If the goal is to catch non-scalar users, the following is shorter:
#define ACCESS_ONCE(x) (((typeof(x))0) + *(volatile typeof(x) *)&(x))

it will block union and struct accesses.
If you want to allow union and disallow struct, then replace + with ,
