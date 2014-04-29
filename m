Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:01:02 +0200 (CEST)
Received: from mail-ee0-f41.google.com ([74.125.83.41]:41192 "EHLO
        mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843060AbaD2OA7T6V0b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:00:59 +0200
Received: by mail-ee0-f41.google.com with SMTP id t10so369599eei.14
        for <linux-mips@linux-mips.org>; Tue, 29 Apr 2014 07:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=HtVintCF4fets5T5GM4mXJdcNcz0KoL1F9Jf6oRgNh0=;
        b=VDSRZ5Qze+9BzoEOO+bu64m+uZaoyuT4tDLB/kggiGMBFNk75bjyUYLpFcE6IONa3W
         PROTwMbD8wyO+WgGSGKnIb7jtHDSw44ABT83ph3zTmN0XNjQGAje8e1GADBcR/m0n3I/
         ewVdB9LNqS1CWpyjfjpnMCbpWaTZx5Y3CDgr6bX33u+L1lb3Unij3Cc0I33KfV2ixfwQ
         KuWmAZxuketLxRTA6o5gwxinh65JxLSXY6BJ9iXUvC5uM9xqOToCOJ5pd6TJJ25ZSAr2
         +C38DigRD/0/VI7kdsMzmDYQ7jOVPs19fbYh2lgZ18reQnMqHpZQkDUHNomh1Fqalgnn
         L3WA==
X-Gm-Message-State: ALoCoQmE420pFo7RN1h8rheMGp53mUrsgG75BGGyhQ5KwQOGE75biIvJU5+f6Hgqo7/YcIXUiLQS
X-Received: by 10.15.81.135 with SMTP id x7mr3678292eey.61.1398780053874;
        Tue, 29 Apr 2014 07:00:53 -0700 (PDT)
Received: from trevor.secretlab.ca (host109-149-85-92.range109-149.btcentralplus.com. [109.149.85.92])
        by mx.google.com with ESMTPSA id l42sm59466585eew.19.2014.04.29.07.00.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 07:00:52 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 7C9D0C40992; Tue, 29 Apr 2014 15:00:48 +0100 (BST)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 00/21] FDT clean-ups and libfdt support
To:     Rob Herring <robherring2@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Bonn <jonas@southpole.se>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux@lists.openrisc.net, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org, Mark Salter <msalter@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org
In-Reply-To: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
Date:   Tue, 29 Apr 2014 15:00:48 +0100
Message-Id: <20140429140048.7C9D0C40992@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39967
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

On Tue, 22 Apr 2014 20:18:00 -0500, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This is a series of clean-ups of architecture FDT code and converts the
> core FDT code over to using libfdt functions. This is in preparation
> to add FDT based address translation parsing functions for early
> console support. This series removes direct access to FDT data from all
> arches except powerpc.
> 
> The current MIPS lantiq and xlp DT code is buggy as built-in DTBs need
> to be copied out of init section. Patches 2 and 3 should be applied to
> 3.15.
> 
> Changes in v2 are relatively minor. There was a bug in the unflattening
> code where walking up the tree was not being handled correctly (thanks
> to Michal Simek). I re-worked things a bit to avoid globally adding
> libfdt include paths.
> 
> A branch is available here[1], and I plan to put into linux-next in a few
> days. Please test! I've compiled on arm, arm64, mips, microblaze, xtensa,
> and powerpc and booted on arm and arm64.

This is pretty great work. I'll read through them again and I may have a
comment or two, but in general you can add my tested by tag:

Tested-by: Grant Likely <grant.likely@linaro.org>

>  40 files changed, 280 insertions(+), 598 deletions(-)

I love the diffstat!

g.
