Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jul 2013 14:22:53 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:60726 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819547Ab3GTMWsfsjM1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jul 2013 14:22:48 +0200
Received: by mail-wi0-f182.google.com with SMTP id m6so517920wiv.3
        for <linux-mips@linux-mips.org>; Sat, 20 Jul 2013 05:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=XcdXracHRIgimbtu8T9qLQjEqC1u44dVNmZNhfb2zZc=;
        b=Xzv/DHI+8xdMbPoT5KRAwqOO6Si8F9BZOIp1eG0chYmnbuuMj5s2hfBcIJkIE6Tp7u
         GwD6i8JR3YK906dv46BkdMJqor6F2Co6kI9aLjqd+LKd04Fwk5Uj9AHjknw3Skx/clgz
         Cq23xAsccW6IJjr29xSqU2qL836SGAi2xnI18L3cqgPYBa1XFfUOM59es9lVVIRhwS2C
         uDxYQck00fLSqMhnMhX4atev2wOgZAaZE5M2JCqPBDEb7HvxW06ivf/Rxy1lPF1t62pV
         uOGQ9D5DG09njlj8vFXQXrqf26lna210K8LN5hs9bY0mNBXqzKwMFUR1jLUFCwgMVyYh
         6Sag==
X-Received: by 10.180.211.202 with SMTP id ne10mr13976194wic.39.1374322962843;
        Sat, 20 Jul 2013 05:22:42 -0700 (PDT)
Received: from localhost (dab-bhx1-h-1-2.dab.02.net. [82.132.228.222])
        by mx.google.com with ESMTPSA id fd3sm54041091wic.10.2013.07.20.05.22.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 05:22:41 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id C7AC63E0C52; Fri, 19 Jul 2013 22:39:45 -0700 (PDT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2] of: Specify initrd location using 64-bit
To:     Rob Herring <robherring2@gmail.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc:     Rob Herring <rob.herring@calxeda.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        arm@kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org, devicetree-discuss@lists.ozlabs.org
In-Reply-To: <51D1F5E2.6070609@gmail.com>
References: <1372702835-5333-1-git-send-email-santosh.shilimkar@ti.com> <51D1F5E2.6070609@gmail.com>
Date:   Sat, 20 Jul 2013 06:39:45 +0100
Message-Id: <20130720053945.C7AC63E0C52@localhost>
X-Gm-Message-State: ALoCoQm/K43/6HzALS48mveYhOuqpq66Tu66wkLB3IrH6JO2mTIn7bQ+j/UUO8Dy1HUycyrR7B6d
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Mon, 01 Jul 2013 16:34:26 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On 07/01/2013 01:20 PM, Santosh Shilimkar wrote:
> > On some PAE architectures, the entire range of physical memory could reside
> > outside the 32-bit limit.  These systems need the ability to specify the
> > initrd location using 64-bit numbers.
> > 
> > This patch globally modifies the early_init_dt_setup_initrd_arch() function to
> > use 64-bit numbers instead of the current unsigned long.
> > 
> > There has been quite a bit of debate about whether to use u64 or phys_addr_t.
> > It was concluded to stick to u64 to be consistent with rest of the device
> > tree code. As summarized by Geert, "The address to load the initrd is decided
> > by the bootloader/user and set at that point later in time. The dtb should not
> > be tied to the kernel you are booting"
> 
> That was quoting me. Otherwise:
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> Unless Grant feels compelled to pick this up for 3.11, I think it has to
> wait for 3.12.

Nope, 3.12 is fine. Applied.

g.
