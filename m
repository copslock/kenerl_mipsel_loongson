Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Apr 2014 11:37:37 +0200 (CEST)
Received: from mail-ee0-f50.google.com ([74.125.83.50]:65043 "EHLO
        mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816002AbaDZJhd4lfLo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Apr 2014 11:37:33 +0200
Received: by mail-ee0-f50.google.com with SMTP id c13so3420247eek.9
        for <multiple recipients>; Sat, 26 Apr 2014 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/BPCahpOos4rTFXnUBu8RBgqw39rGvQiKTpPja9bM9o=;
        b=rnqXD6jtUBaWHOaNBH4DjrKCwInSH/f061xyVjll7e4TT1XV0h1bv0t13Q4SLhUC72
         kheONOkxdJYQOAfdKOG7aHQSFjP85+HAOlszLnajtLUmhH7nlMBG8O7b8u1vWL/7LW1Y
         Gg7kakmY3hAud4vd5+kHhP6azULi+I+TwTyCfzYph+Z+Unf7UAHEcfIsdnlyjBhfKpXU
         yxmz0IdxORhNOF6xMLUcvHKf73F+xvV8vTyGjhEsTwPgtZgE+cESHvohvIXQuJvQyyPc
         W+nddg5g5vf6b2FTuW/XpRYMkR4HbiFnlEdJUoxHsm0VxZI53CIf+08A5dhk9Ghnajm5
         +dOg==
X-Received: by 10.14.7.137 with SMTP id 9mr15967eep.114.1398505048600;
        Sat, 26 Apr 2014 02:37:28 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-116-207-117.cust.vodafonedsl.it. [37.116.207.117])
        by mx.google.com with ESMTPSA id 45sm31926128eeh.9.2014.04.26.02.37.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Apr 2014 02:37:27 -0700 (PDT)
Message-ID: <535B7E58.4070304@redhat.com>
Date:   Sat, 26 Apr 2014 11:37:28 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
CC:     linux-mips@linux-mips.org, Gleb Natapov <gleb@kernel.org>,
        kvm@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 14/21] MIPS: KVM: Add nanosecond count bias KVM register
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-15-git-send-email-james.hogan@imgtec.com> <535A9AF5.30105@gmail.com> <2197488.6tnytXFBJm@radagast>
In-Reply-To: <2197488.6tnytXFBJm@radagast>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39959
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

Il 26/04/2014 00:34, James Hogan ha scritto:
> So yes, you could technically manage without (4) by using (2) ((4) was
> implemented first), but I think it probably still has some value since you can
> do it with a single ioctl rather than 4 ioctls (freeze timer, read
> resume_time, read or write count, unfreeze timer).
>
> Enough value to be worthwhile? I haven't really made up my mind yet but I'm
> leaning towards yes.

It would be interesting to see how the userspace patches use this 
independent of COUNT_RESUME.

Paolo
