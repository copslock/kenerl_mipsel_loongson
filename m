Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 19:35:47 +0100 (CET)
Received: from mail-qc0-f169.google.com ([209.85.216.169]:43509 "EHLO
        mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006897AbaKXSfp05X3v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 19:35:45 +0100
Received: by mail-qc0-f169.google.com with SMTP id w7so7324067qcr.14
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 10:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XkHlqmrVNc3CqnIva3OXotWfdWc583hE5vehtTEias8=;
        b=FaFuCJSDK5HvHjbHflyqDdz01hP+3c74LgvT9TAAM1wrpAxFu2fAwBWelTDs1njXuu
         dzG5VkfjlXFgGYzTTqJDcMb9KpJo1xeauudvcha9cTkGM+gbpEWlLGxKgKplKf1qphGT
         dZz73ySFCsDhtCpWjGZQPAC4QQD+cCs/H9rop48aDEjwg5w+PINa8hFBCvA2bsGRhVIX
         jEhL7kWsPUBB1MG9oa4vvIzoMEjvkwLaUje90Wvub7Zq5kHFfNFMYJLDSJZ50OV37ay3
         GtuvOkPjARFqL7y7sP68dUDs3JBxas6lbXiYjT0fKv4p4OJl83gJfH6weU0e6WuZJthm
         ACjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XkHlqmrVNc3CqnIva3OXotWfdWc583hE5vehtTEias8=;
        b=FOGRMK//lqdZZrT7U15n9NeYBlTxaHEG21eCJkurAu/pPv52KPHAUwOY6MdJF8wJuA
         A67gxyTQ7UMmnDxnAj0FzjIncsDP5J/zAhQYrB3LlvAbidNl1bX/eMf6oUYB2IfvO/Ny
         d1U8YLVrml4IWo2/Sf689Nu0QEOsfXyE/RYv0=
MIME-Version: 1.0
X-Received: by 10.224.166.131 with SMTP id m3mr16729299qay.6.1416854139773;
 Mon, 24 Nov 2014 10:35:39 -0800 (PST)
Received: by 10.140.39.170 with HTTP; Mon, 24 Nov 2014 10:35:39 -0800 (PST)
In-Reply-To: <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
        <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
        <15567.1416835858@warthog.procyon.org.uk>
        <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
Date:   Mon, 24 Nov 2014 10:35:39 -0800
X-Google-Sender-Auth: qVgC0ZKPuvXwFh44RghLObPilJg
Message-ID: <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-x86_64@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Mon, Nov 24, 2014 at 10:02 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> If the goal is to catch non-scalar users, the following is shorter:
> #define ACCESS_ONCE(x) (((typeof(x))0) + *(volatile typeof(x) *)&(x))

Me likey. It probably works well in practice, although I think

 - the "(typeof(x))0)" seems unnecessary and wrong. Why not just "0"?
The typeof is not just longer, but it is incorrect for pointer types
(you can add 0 to a pointer, but you cannot add two pointers together)

 - it does mean that the resulting type ends up being upgraded to
"int", for the usual C type reasons.

Note that the "upgraded to 'int'" is true with or without the
"(typeof(x))0". If you add two 'char' values, the addition is still
done in 'int'.

Maybe you *meant* that typeof to fix the second problem, like so:

  (typeof(x)) (0 + *(volatile typeof(x) *)&(x))

Hmm? That casts the result of the addition, not the zero.

             Linus
