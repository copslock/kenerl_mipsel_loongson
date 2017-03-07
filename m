Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 11:35:10 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:36572
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991672AbdCGKfBhAHh2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 11:35:01 +0100
Received: by mail-wm0-x241.google.com with SMTP id v190so161181wme.3;
        Tue, 07 Mar 2017 02:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7BuFg3CAUCFyiHArt9VgRn/AHhWRmUKwW+HJ1BnPWUo=;
        b=Wilm2fvJ29Pk8gkgvb30nyeJaoC09ysg5/9O+CynCwUDXBnoJHacBdfo7ubJO6iJ37
         2hct+zF9/ZZ1P7zIgXRZaAsIllfTdyxEj4g+xyq19WiKoQDc9NtlhNGCSmfyhiG+m/dC
         EAZ5yULvyBhY2JazL8woiYZHGwU0BfvCtraHB9USv9Ug8eFI0lB1LQPKdwRerGq57omu
         HsCQSmWzlQwF4LAn6llAvKRuB+JxPdNoPAGnxoBkukTj5rkih1ixSZtB+2gjOQ0/tNlb
         yGcrUYb4E3uZSCrQJl2OoIdcpLY39J6InJ2bU+UUwVX4D03PkxWd8+DAFkIgX9/jHfbJ
         9MjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7BuFg3CAUCFyiHArt9VgRn/AHhWRmUKwW+HJ1BnPWUo=;
        b=nCfG4sIph+AlUPbKIQFkxT6RzB0Xr3TIIvZZXykksszn73TFumQKslXO6ahhCQV4Ft
         WOB+xVqT/fvdh4h79uSQUb1fKoZb8phzkpmiU3tp50d/P1kWpoDogNKS4/VuRael8WMt
         ewH7Tbrlvqvm2yduVqgnXgzqxgLDXgQm4sp7KRftt0swTDf0mbKWZ2u+j/wv+7maNybI
         n/M76Wc1B83xnCA9iU/Hzc76nyo0Zv+5uzRRmlWZS3cgob3Li79aFSDvamYq+0pxT+29
         OMhdJpg076VV+rOWW9z3EMrXi/CRQJcBGOvGSOhJRMAbByySw49bblSYP8MLScMrhYvP
         TsGA==
X-Gm-Message-State: AMke39kN8/pVsDyclwgy/J/VIsIoSvCYkMvx3TAPBPUySrVdxYId97JUqN/T3Jbf5zid5w==
X-Received: by 10.28.169.199 with SMTP id s190mr17390382wme.2.1488882896333;
        Tue, 07 Mar 2017 02:34:56 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w16sm18402610wmd.4.2017.03.07.02.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Mar 2017 02:34:55 -0800 (PST)
Date:   Tue, 7 Mar 2017 11:34:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] MIPS: Fix build breakage caused by header file changes
Message-ID: <20170307103452.GA13056@gmail.com>
References: <1488827635-7708-1-git-send-email-linux@roeck-us.net>
 <20170306232019.GG2878@jhogan-linux.le.imgtec.org>
 <20170307073805.GB15693@gmail.com>
 <20170307093850.GD996@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170307093850.GD996@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* James Hogan <james.hogan@imgtec.com> wrote:

> Hi Ingo,
> 
> On Tue, Mar 07, 2017 at 08:38:05AM +0100, Ingo Molnar wrote:
> > Just a quick question: is your MIPS build fix going to be merged and sent to 
> > Linus? I can apply it too, and send it to Linus later today, together with a few 
> > other sched.h header related build fixes.
> 
> One for Ralf...

Ralf, what's your preference?

> > Assuming it's all properly tested - my limited MIPS defconfig builds worked fine - 
> > but MIPS has a lot of build variations.
> 
> If you have a branch with other generic fixes I'm happy to push it to
> our MIPS buildbot too to double check.

So I have not applied your patch yet (can do it with ack from Ralf), but all the 
other fixes that are pending can be found in:

  git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent

It's these commits:

 bb35e4515411 drivers/char/nwbutton: Fix build breakage caused by include file reshuffling
 80aa1a54f054 h8300: Fix build breakage caused by header file changes
 1fbdbcea8005 avr32: Fix build error caused by include file reshuffling

Thanks,

	Ingo
