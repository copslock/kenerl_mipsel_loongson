Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 23:24:33 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44253 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827572Ab3FEVY2B7UYZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Jun 2013 23:24:28 +0200
Received: from mail-vc0-f177.google.com (mail-vc0-f177.google.com [209.85.220.177])
        by mail.nanl.de (Postfix) with ESMTPSA id A93B445F9E
        for <linux-mips@linux-mips.org>; Wed,  5 Jun 2013 21:23:42 +0000 (UTC)
Received: by mail-vc0-f177.google.com with SMTP id hv10so1508648vcb.36
        for <linux-mips@linux-mips.org>; Wed, 05 Jun 2013 14:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZHLC7r1CyBHhqBxyiYOTzq1NBK6gM3Wws115Pd1zvLE=;
        b=FManW4UHO4RQUlAd/og6gRTCTzfGRYuGulAX3U7s7InqwgsVxsfXljH/ddmjBrFxdz
         u31SOfpV1lnh0zA5klw6AvUru7Pkv8vMha+fjAI2rg136LX7/yUxE/64tUsI6R+fp4Tb
         F9xQVtT6zgsH4Gdla/pmYMsuaRZbFifd7dWFYcN1i1+tGz/ZS1Oanxgtsej257d4V15m
         I4/MRABTAdnozvlI+Z0EaOX+99c5pQd6JGRZEGthSZiABurS+nQyE6VkjvCUnfndXR5q
         w3WTYiKiBoCZa9caVLwF5eQ1N/w7AvulEzLNfmn6jlO7YXQ/bbGCDgDmJYpXIYJtGVTW
         z6Pw==
X-Received: by 10.52.164.98 with SMTP id yp2mr4551551vdb.111.1370467458065;
 Wed, 05 Jun 2013 14:24:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.109.203 with HTTP; Wed, 5 Jun 2013 14:23:58 -0700 (PDT)
In-Reply-To: <51AFAA8C.6080002@imgtec.com>
References: <1370461798-20296-1-git-send-email-Steven.Hill@imgtec.com>
 <51AFA540.5010207@gmail.com> <51AFAA8C.6080002@imgtec.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 5 Jun 2013 23:23:58 +0200
Message-ID: <CAOiHx=mFqC=GN0jmb9PXpt+JapfWoP3Pu5NM0sp=F_uAZuwUEA@mail.gmail.com>
Subject: Re: [PATCH v6] MIPS: micromips: Fix improper definition of ISA
 exception bit.
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Wed, Jun 5, 2013 at 11:15 PM, Steven J. Hill <Steven.Hill@imgtec.com> wrote:
> On 06/05/2013 03:53 PM, David Daney wrote:
>>
>>
>> You can only manipulate this bit if you know microMIPS is supported.  So
>> I think you should either not touch it for the non-microMIPS case, or
>> make the write conditional on the presence of microMIPS support in the
>> CPU.
>>
> I decided to surround with SYS_SUPPORTS_MICROMIPS so the function could be
> optimized out in v7 of the patch.

Since this is (AFAICT) run after cpu_probe, and cpu probe sets
MIPS_CPU_MICROMIPS in options[0] if config3 has  MIPS_CONF3_ISA set
(as seen in the context), couldn't you do just the following in
cpu_trap:

	if (cpu_has_mmips) {
		unsigned int config3 = read_c0_config3();

		if (IS_ENABLED(CONFIG_CPU_MICROMIPS))
			write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
		else
			write_c0_config3(config3 & ~MIPS_CONF3_ISA_OE);
	}


Regards
Jonas
