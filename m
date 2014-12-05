Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2014 22:41:19 +0100 (CET)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36042 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008130AbaLEVlRxdBfV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2014 22:41:17 +0100
Received: by mail-ie0-f169.google.com with SMTP id y20so1567456ier.0
        for <multiple recipients>; Fri, 05 Dec 2014 13:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=nR3qxA9uwdXQU+O1YChgH3Ygbm+yWbZauF1Pp4gFx5I=;
        b=CrGeHYbb4gXC7tNd4uvZBAAnnNucx2WWZxcxdvyZSrRk/uawjYFm6koB2gAT4FdniX
         NLr08NLoVZxxaNx1+l8aFw6RF5MGT89+BIsX/HfgiUcUACEpKccF14OFqUkwiu8cf0Xu
         ZZjtum4ocdk0UBY74GrjUoyD6JCt8ddflfbqyP6QR1NTo8GhxBLBFLU0dzcPzSo1P7Xb
         ZC1nEaAhi8Al6SLYKBKpc3xjoifjVgsD9J5AOdBGr7EPIZFVKbwsUJV4cNYPi7VvZpLQ
         YhocVDRuVN3Mmlxn09NAue/yQKKsoKgU/aKWbt3nL5MDxs84wcK6bvFf4FOyKmlLmAyX
         a5Fg==
X-Received: by 10.42.79.76 with SMTP id q12mr17421927ick.16.1417815671990;
        Fri, 05 Dec 2014 13:41:11 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id h36sm7673746iod.17.2014.12.05.13.41.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 13:41:11 -0800 (PST)
Message-ID: <54822674.20907@gmail.com>
Date:   Fri, 05 Dec 2014 13:41:08 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Christoph Lameter <cl@linux.com>
CC:     Kees Cook <keescook@chromium.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Zubair.Kakakhel@imgtec.com, geert+renesas@glider.be,
        david.daney@cavium.com, Peter Zijlstra <peterz@infradead.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        davidlohr@hp.com, "Maciej W. Rozycki" <macro@linux-mips.org>,
        chenhc@lemote.com, Ingo Molnar <mingo@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Tejun Heo <tj@kernel.org>, alex@alex-smith.me.uk,
        Paolo Bonzini <pbonzini@redhat.com>,
        John Crispin <blogic@openwrt.org>,
        Paul Burton <paul.burton@imgtec.com>, qais.yousef@imgtec.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        dengcheng.zhu@imgtec.com, manuel.lauss@gmail.com,
        lars.persson@axis.com
Subject: Re: [PATCH v3 3/3] MIPS: set stack/data protection as non-executable
References: <20141203015537.13886.50830.stgit@linux-yegoshin> <20141203015824.13886.74616.stgit@linux-yegoshin> <5481EB52.6060706@gmail.com> <CAGXu5jJJx0O7GhHghy+sC4fJL2O=RsO+Zgm78r9SNt-aTbhqcw@mail.gmail.com> <54820244.5010304@gmail.com> <alpine.DEB.2.11.1412051343330.5206@gentwo.org>
In-Reply-To: <alpine.DEB.2.11.1412051343330.5206@gentwo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44591
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

On 12/05/2014 11:44 AM, Christoph Lameter wrote:
> On Fri, 5 Dec 2014, David Daney wrote:
>
>> The problem is not with "modern" executables that are properly annotated with
>> PT_GNU_STACK.
>>
>> My objection is to the intentional breaking of old executables that have no
>> PT_GNU_STACK annotation, but require an executable stack.  Since we usually
>> try not to break userspace, we cannot merge a patch like this one.
>
> How old are these and how many are still around?

As far as I can determine, no official GCC release defaults to 
generating PT_GNU_STACK for MIPS, I could be mistaken though.  So to 
answer your questions:  Very young, and all of them.


> Can the annotation be added with a tool?

I don't know, although I seem to recall that such a tool existed, and I 
may have even used it in the past.  But, my google fu is not 
sufficiently advanced to find it now, if it exists.

David Daney
