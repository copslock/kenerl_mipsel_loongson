Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 19:59:15 +0100 (CET)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38903 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012840AbcBPS7OC7Zdk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 19:59:14 +0100
Received: by mail-ig0-f169.google.com with SMTP id y8so84147561igp.1
        for <linux-mips@linux-mips.org>; Tue, 16 Feb 2016 10:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xZnJofAX8Zwi+cIB6kC2aA8ep+Eg1lpL8k12XbSIReM=;
        b=TOE8/ALiAE5ZtfKnWj/8qwBG3D3hm1fZRGfycmxxASw04Sb/lGO0qJanz9UgBEMOJH
         sY+3TTuWnRoTxw60PmP6vDY6HwCrWLuw0oR8a7XTCqoP7uZ0dvbMCHoxGNWVP51Mwso6
         tc9k3wFVT0gisGNCXs8wf26ekWIM45YW3nYo6Lh52kN0kORJaQ8cAw/487y6K0wg7MVo
         1I1Tz4pMXYUaf7p1vAXyD+wXFbxxa+FwnIC2JihPnSSl/3tsU8bYMEVnwpZBEmOaitfa
         3xjroG0FUaiyyAUCkI3eQxAx7OQecXnJyu2P1E+tumVBWWpO1OSOcrWvXOLaCFWMLHf/
         yOLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xZnJofAX8Zwi+cIB6kC2aA8ep+Eg1lpL8k12XbSIReM=;
        b=L+SGFg9Uecz5IjyGyHOBZ6yq+e7q7eTsdUSGuROH0OvYa3EriMJ2peod6JAR1366Gw
         7s8HTkcxBARnXR9UQthRxynEyGs4ciOO5965+vHf0X9kyPPjyZ+JHYK0kEsSH8GguPru
         ZCcZ9QGTStDcpaT474dHyGuCpjX0aRzlUb5pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xZnJofAX8Zwi+cIB6kC2aA8ep+Eg1lpL8k12XbSIReM=;
        b=eGg1m08r67TEfBIOXu9pDm1UXtTMf7IoQG3SDRaxWfuOcSO+zQ+MzLt18k0cAPdhMF
         eqLhHX+8N6XIEU3kSRV2Exjp/BHOj+FkF8DH9iOy8xMDIJ+N89y1w6PSw8DLhRXKS8cR
         ppxGCElZ7ixAV1KbjiJri7EttkxOVUion3yAkO07xiBIP4fL13VXp1+A28DmIg6HilXR
         0Uq0gyMSLff/WcY43x1VyzOw+8J0sExkgpwhPKSqEKFoyUx7murkidHM0jWsjoOOsB2n
         ErxYrgC1fEOn51K9++FRNj4EdN9ZdKdgAVFiJaDkmYWJX1iHlch3QOcjyhQqjEfYfrfo
         OZJQ==
X-Gm-Message-State: AG10YOT/YkCAwzNzb/70rzqE02WM0E0I1yhBFMWggeZKiX2+j7T4kOriYv57GgMxRwOEPblZJZmIlFpRGVupLg==
MIME-Version: 1.0
X-Received: by 10.50.112.10 with SMTP id im10mr1863073igb.93.1455649148130;
 Tue, 16 Feb 2016 10:59:08 -0800 (PST)
Received: by 10.36.93.202 with HTTP; Tue, 16 Feb 2016 10:59:08 -0800 (PST)
In-Reply-To: <20160215175825.GA15878@linux.vnet.ibm.com>
References: <20160215175825.GA15878@linux.vnet.ibm.com>
Date:   Tue, 16 Feb 2016 10:59:08 -0800
X-Google-Sender-Auth: Oq9GN_tTGyQY1sWcPA37Tun4EKw
Message-ID: <CA+55aFxaQEvDrzecmZUQ5QfKzU4ei6E-+NpsW5hYp3ouaLP98g@mail.gmail.com>
Subject: Re: Writes, smp_wmb(), and transitivity?
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Andy.Glew@imgtec.com,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Miller <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-metag@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>,
        linux-xtensa@linux-xtensa.org,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>, graham.whaley@gmail.com,
        Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52096
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

On Mon, Feb 15, 2016 at 9:58 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> Two threads:
>
>         int a, b;
>
>         void thread0(void)
>         {
>                 WRITE_ONCE(a, 1);
>                 smp_wmb();
>                 WRITE_ONCE(b, 2);
>         }
>
>         void thread1(void)
>         {
>                 WRITE_ONCE(b, 1);
>                 smp_wmb();
>                 WRITE_ONCE(a, 2);
>         }
>
>         /* After all threads have completed and the dust has settled... */
>
>         BUG_ON(a == 1 && b == 1);

So the more I look at that kind of litmus test, the less I think that
we should care, because I can't come up with a scenario in where that
kind of test makes sense. without even a possibility of any causal
relationship between the two, I can't say why we'd ever care about the
ordering of the (independent) writes to the individual variables.

If somebody can make up a causal chain, things differ. But as long as
all the CPU's are just doing locally ordered writes, I don't think we
need to care about a global store ordering.

              Linus
