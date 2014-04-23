Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 23:04:56 +0200 (CEST)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33202 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817536AbaDWVEyOLQIE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 23:04:54 +0200
Received: by mail-ob0-f169.google.com with SMTP id uz6so1697599obc.28
        for <multiple recipients>; Wed, 23 Apr 2014 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3CCL95YSwH0s9Sa9q5Wvpkqw1baazdUGLwoh8QIepss=;
        b=LfgY75QPeXU/KiNF0lmJKytsZjXs/p2e38Q3x3KGk8Wd3PFYtytZwtCwbAq3HuVAfG
         1mjGADwQhUNh5vj6eP4SfMm6w8pNE4uC19V57O1RduXAUOZHupnrbGK4n37ROYqdNWda
         SiVJ97+4FOrhfI+PJ8MVfl8jwlsL1Rqkfb9t6bWHekFmYqwzIkLywgPDQeJiJ/X4F8GP
         cRP/nVpTlik3KIwYd6auD7PCfIz+zza+I/9LzMxyrhCdXriHH3lAs90xfv84nUurXb48
         gl/BNXxeelgqohVafoVtC22s2geul1g0CZ8yIY0K/IbKjjriRb+kg46YYIxyDyy4Ok5A
         Ti1w==
MIME-Version: 1.0
X-Received: by 10.60.44.135 with SMTP id e7mr3750276oem.63.1398287087647; Wed,
 23 Apr 2014 14:04:47 -0700 (PDT)
Received: by 10.76.166.164 with HTTP; Wed, 23 Apr 2014 14:04:47 -0700 (PDT)
In-Reply-To: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
Date:   Thu, 24 Apr 2014 01:04:47 +0400
Message-ID: <CAMo8Bf+LO-15x8vhOukskyaNMMu97NzFjmkc-inO9xqG075dkw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] FDT clean-ups and libfdt support
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Grant Likely <grant.likely@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Bonn <jonas@southpole.se>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux@lists.openrisc.net, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Mark Salter <msalter@redhat.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcmvbkbc@gmail.com
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

On Wed, Apr 23, 2014 at 5:18 AM, Rob Herring <robherring2@gmail.com> wrote:
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
>
> Rob
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git libfdt

For xtensa: Tested-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
