Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Sep 2016 01:03:13 +0200 (CEST)
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37595 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992244AbcIOXDFf2EPS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Sep 2016 01:03:05 +0200
Received: by mail-wm0-f43.google.com with SMTP id k186so10367940wmd.0
        for <linux-mips@linux-mips.org>; Thu, 15 Sep 2016 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XapBbA7c3O9gUVLgtNCe7HCmnb94PMqqCspaQKtnPGI=;
        b=t+iJRZZwVlSpy12WgUqIe448M4knER+Bn281xqWm2Z7BkaB/9yPj7++snCSHHD8K3q
         Z3rSICyTOUqZxaFTHjaJEOyXdhU8b/N/hlFJfWFxDn/snAasI5Fx5sxMgZvtev6q68Vi
         drkGie3w8Q/8feFDBaqwAxh5rDQ2F2kBD/zao4CRU5PWHi4aGqDJB3kDClGVZ03CQKx6
         MOHZvXGgCCGYuTa7Dq36vfQBGc3Jqfx5f3Zvd+4Pg4daJlUWMcILkQrJ1gBZ9eJ20Mfn
         d0n1OyaUOGj8O4mM+/Xz1rDr0aK8V3jC1vGsRBXLfpyUFVmKER4giTZK6d7St6LUhZOP
         gzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XapBbA7c3O9gUVLgtNCe7HCmnb94PMqqCspaQKtnPGI=;
        b=AgF2DupcIUcyY07q/hUIS1A2p//dJja4p1Dhqjb39lD5H3MO5NrRUIY/zlS68lGC4z
         IdjNKIjLEeLiE4/Xofb9/4pu1G/vN3IsDNFtnE6BuzZD3qoI8sAfoevih83FKK5FHSTd
         I5vaTdhOE2IBAagKvm2Jn24qGVtpZHhj1lJDNNY3C4pt0aVkLZlVODU3Xwt1bNd+PkMk
         nLYjSSYHDvEKaEorbo8as4M9bz2F46o/iklkL2yUFL7OBTE5E8j+9WRyUQC/rbBXX+wM
         9R5dXPYF/dICyclzS2jiXIGcK+nj59Gx1DgiYdxPrSckj/Lph3RoIFEJu2rwcDa4cyhL
         GH8Q==
X-Gm-Message-State: AE9vXwNvNo9B0S23l+EU0qkSNBMKTbvcY5UV8zDAnqZTC/yte6myI5EHJGobQz0tSjNcDg==
X-Received: by 10.194.61.203 with SMTP id s11mr10900302wjr.141.1473980579356;
        Thu, 15 Sep 2016 16:02:59 -0700 (PDT)
Received: from [192.168.1.82] (ARouen-653-1-214-191.w90-22.abo.wanadoo.fr. [90.22.23.191])
        by smtp.gmail.com with ESMTPSA id q139sm4476285wmb.18.2016.09.15.16.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Sep 2016 16:02:58 -0700 (PDT)
Message-ID: <1473980577.17787.21.camel@gmail.com>
Subject: Re: genirq: Setting trigger mode 0 for irq 11 failed
 (txx9_irq_set_type+0x0/0xb8)
From:   Alban Browaeys <alban.browaeys@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 16 Sep 2016 01:02:57 +0200
In-Reply-To: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
References: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <alban.browaeys@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alban.browaeys@gmail.com
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

Le mercredi 14 septembre 2016 à 21:25 +0200, Geert Uytterhoeven a
écrit :
> JFYI, with v4.8-rc6 I'm seeing
> 
>     genirq: Setting trigger mode 0 for irq 11 failed
> (txx9_irq_set_type+0x0/0xb8)
> 
> on rbtx4927. This did not happen with v4.8-rc3.


txx9_irq_set_type receives a type IRQ_TYPE_NONE from the call to
__irq_set_trigger added in:
1e12c4a939 ("genirq: Correctly configure the trigger on chained interrupts")


This patch is a regression fix for :

Desc: irqdomain: Don't set type when mapping an IRQ breaks nexus7 gpio buttons
Repo: 2016-07-30 https://marc.info/?l=linux-kernel&m=146985356305280&w=2

I am seeing this on arm odroid u2 devicetree :
genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x64)


Alban
