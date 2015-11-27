Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 10:04:58 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34600 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006607AbbK0JE4Tkhl5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Nov 2015 10:04:56 +0100
Received: by padhx2 with SMTP id hx2so109657780pad.1;
        Fri, 27 Nov 2015 01:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gDqqssUX0S8XFo9gMt6Hc6nJWKD2/2fTRutS/kFw+Zs=;
        b=W+K8Ah5XWDPyw0P8BzZGBVXyKp38Kkuw7LBDRCBt4e+hOx0QRXQPjE9DGBhhixwy3J
         8p2n3pI/d731kVL6DkXTm/4OrWc3VriRxzX5tgvG/FjYKjx2RXMRkQnl8ar6+cCD7YQO
         9RbE8yADwX5XLJrxjxAm9wj/Kq+ixbePMnNHRUel08NBA4hJt56Z9sYwod6PLorYwiDq
         fxX7lwUIQ1hRZ+oTmU/omWQB9gg1a1/grZWT4UGp/pyR0Tsg7zRP1PvrjK7/u1FbPdTO
         rR/x5KzFobQbYcaFtPgoI/EV9bfg5SEs3WLlx3T4EqcqR7wix0CJ8itX+4OqlDZUkn6w
         iGQw==
X-Received: by 10.67.6.1 with SMTP id cq1mr55333567pad.78.1448615090226;
        Fri, 27 Nov 2015 01:04:50 -0800 (PST)
Received: from [17.87.29.101] ([17.87.29.101])
        by smtp.gmail.com with ESMTPSA id t71sm32478556pfi.60.2015.11.27.01.04.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Nov 2015 01:04:49 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: no-op delay loops
From:   yalin wang <yalin.wang2010@gmail.com>
In-Reply-To: <87si3rbz6p.fsf@rasmusvillemoes.dk>
Date:   Fri, 27 Nov 2015 17:04:43 +0800
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7B39C9C2-1093-49CE-9A1E-5059A57C298A@gmail.com>
References: <87si3rbz6p.fsf@rasmusvillemoes.dk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
X-Mailer: Apple Mail (2.3094)
Return-Path: <yalin.wang2010@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yalin.wang2010@gmail.com
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


> On Nov 27, 2015, at 16:53, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
> Hi,
> 
> It seems that gcc happily compiles
> 
> for (i = 0; i < 1000000000; ++i) ;
> 
> into simply
> 
> i = 1000000000;
> 
> (which is then usually eliminated as a dead store). At least at -O2, and
> when i is not declared volatile. So it would seem that the loops at
> 
> arch/mips/pci/pci-rt2880.c:235
> arch/mips/pmcs-msp71xx/msp_setup.c:80
> arch/mips/sni/reset.c:35
> 
> actually don't do anything. (In the middle one, i is 'register', but
> that doesn't change anything.) Is mips compiled with some special flags
> that would make gcc actually emit code for the above?
> 
you can try to declare i as  volatile int i;
may gcc will not optimize it .

Thanks
