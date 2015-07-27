Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 11:31:38 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:32940 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009417AbbG0JbhAdzbJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 11:31:37 +0200
Received: by pdbnt7 with SMTP id nt7so49055548pdb.0
        for <linux-mips@linux-mips.org>; Mon, 27 Jul 2015 02:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5DB4jlUJ3DzUnvff3kVYMLV8/bwoZLdxQgjz+djVGic=;
        b=hW26rSldl/VZ76rqtkt1l2O8/VlMoLByHF+uhobvEB4ot+JYQoruyhyvEh5l2eh5I8
         0c0XM8DmXjwLjaT/U65Hr5aW2EAbEiGZyPP3qWyOLuyfgu7/SQUoIafdyfDANuMpXkh9
         f1CYWu5nMGffjOcCjjp8TGgqlAQhIit6RuNScvcdHzUz75kAXGFSrav1JJmX6sltXhGJ
         BD/e4lNvmm/vLhbyeHdvsiej5WMaYZ799R+Y7vBRLLbhi1NKdeeRmCh7D5fvEhoV1mQG
         efPxzTf/hYsoLftmn8JdCgTa/QpN0VasDgH72p+kx+8XV5Ogvp0PwvPQ8CgtL5NOk2JJ
         EnGg==
X-Gm-Message-State: ALoCoQmzxunPB4pIRfAmMufuMN0zKfqc6bO64lSOIXJp1W44V/mUn+A/vjS+eJvZjLITzaewlEQ+
X-Received: by 10.70.50.3 with SMTP id y3mr66020186pdn.90.1437989488825;
        Mon, 27 Jul 2015 02:31:28 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by smtp.gmail.com with ESMTPSA id cz1sm28319552pdb.44.2015.07.27.02.31.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 02:31:28 -0700 (PDT)
Date:   Mon, 27 Jul 2015 15:01:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Michael Opdenacker <michael.opdenacker@free-electrons.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>
Subject: Re: [PATCH 00/14] MIPS: Migrate clockevent drivers to 'set-state'
Message-ID: <20150727093125.GH31611@linux>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
 <20150713025116.GE10415@linux>
 <20150727092508.GA30226@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150727092508.GA30226@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

On 27-07-15, 11:25, Ralf Baechle wrote:
> On Mon, Jul 13, 2015 at 08:21:16AM +0530, Viresh Kumar wrote:
> 
> > @Ralf: This dependency patch is applied to 4.2-rc2 now and you can
> > pick all the patches from this series.
> 
> Cool.  I've queued the whole series for 4.3.

Thanks a lot.

-- 
viresh
