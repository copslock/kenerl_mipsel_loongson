Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 10:25:09 +0100 (CET)
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34979 "EHLO
        mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006607AbbK0JZHw0ugO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2015 10:25:07 +0100
Received: by ykba77 with SMTP id a77so112469234ykb.2;
        Fri, 27 Nov 2015 01:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EwU+rqaPC9FsP/UGwuTzL47uAf+Sxum8qWd18V8Egas=;
        b=c4/h2RlBKSwY0S0UmeubJ/rOrdZ+i+AuATSFXTE+5MDjDSsnTkrgp+y4nrVmo9XmuV
         j2igJdPxhy8vh1pVc9eI1Fr65yxyzBlaAxC8rjBNQTfQavDHeeJej9C3xH7cCKfOm09n
         7wKtDXBCJUFw7Yy/LtiIMDTrYzU5wcSwMypbb98lZe+pToROPmsaMLjLbJr1rK24/NMp
         ikVR21pvzS5wlcdTQFQT9YUU5jSz7KkrHyNk8xXiGnuyTqLiPhkBGit+Rw4/SUIXb50V
         f/OjsoGZ1VgE52jM0KnmVZoMiaT0MC6WdXYStYZQs2ggWYHHfjzUGdCQXLb+PhGCRGUN
         iUOA==
MIME-Version: 1.0
X-Received: by 10.13.230.145 with SMTP id p139mr46033779ywe.314.1448616302099;
 Fri, 27 Nov 2015 01:25:02 -0800 (PST)
Received: by 10.37.210.193 with HTTP; Fri, 27 Nov 2015 01:25:02 -0800 (PST)
In-Reply-To: <7B39C9C2-1093-49CE-9A1E-5059A57C298A@gmail.com>
References: <87si3rbz6p.fsf@rasmusvillemoes.dk>
        <7B39C9C2-1093-49CE-9A1E-5059A57C298A@gmail.com>
Date:   Fri, 27 Nov 2015 11:25:02 +0200
Message-ID: <CAHp75VcwVLbpMYarhHH722uz5rxVTKewURYiTPnyOCGYexX_6g@mail.gmail.com>
Subject: Re: no-op delay loops
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     yalin wang <yalin.wang2010@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Fri, Nov 27, 2015 at 11:04 AM, yalin wang <yalin.wang2010@gmail.com> wrote:
>> On Nov 27, 2015, at 16:53, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

>> It seems that gcc happily compiles
>>
>> for (i = 0; i < 1000000000; ++i) ;
>>
>> into simply
>>
>> i = 1000000000;
>>
>> (which is then usually eliminated as a dead store). At least at -O2, and
>> when i is not declared volatile. So it would seem that the loops at
>>
>> arch/mips/pci/pci-rt2880.c:235
>> arch/mips/pmcs-msp71xx/msp_setup.c:80
>> arch/mips/sni/reset.c:35
>>
>> actually don't do anything. (In the middle one, i is 'register', but
>> that doesn't change anything.) Is mips compiled with some special flags
>> that would make gcc actually emit code for the above?
>>
> you can try to declare i as  volatile int i;
> may gcc will not optimize it .

Might be, but Rasmus as I can see asked about *existing* code.


-- 
With Best Regards,
Andy Shevchenko
