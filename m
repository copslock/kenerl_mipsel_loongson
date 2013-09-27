Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2013 12:05:03 +0200 (CEST)
Received: from mail-vc0-f172.google.com ([209.85.220.172]:43217 "EHLO
        mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820116Ab3I0KE4nXLkx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Sep 2013 12:04:56 +0200
Received: by mail-vc0-f172.google.com with SMTP id hu8so1742763vcb.3
        for <linux-mips@linux-mips.org>; Fri, 27 Sep 2013 03:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=eXf0QurRc40M54/aZzLqyaSYKMtV1B+MMKrGmkkMq3g=;
        b=DY3BXut2lN1l2pWgm/16RpBRYJiOmRtKXTqJdStDg0zLQt/cxaztLmiFsBZxpa5M6U
         kT0jBCqg3cir17kWu84YZ8QuIwCeLHJ5fTRs4udafUG2UeS7Sb4To+NcC+fJkahMWiAe
         FpFHtjhS18CzaWCP1qCtGyStS6kQojkbcrAtT0DK0nnVUaNILZ0esilvz4JQM+W2JsBU
         IEcGvpXbQVneGEpeSibRO6y7YCFoGMt6YLc1ql+1hXFUtmDc+bGlsjUca2zaHy631mzG
         PMJ6fioIh8ySMYLT8kOks7Z023Ifho+qgoCf6hgyRgxbmAuZU5QSOFGefVGmAjmdukUG
         Y6FA==
X-Gm-Message-State: ALoCoQlaNcm7Ft2yQUmAXGZiZAjitUUSUJ6vgu+erAbjie/7cyYq6ze66WjmGHF2s0P0aaIAbDIE
MIME-Version: 1.0
X-Received: by 10.52.230.35 with SMTP id sv3mr4701154vdc.27.1380276289981;
 Fri, 27 Sep 2013 03:04:49 -0700 (PDT)
Received: by 10.52.231.170 with HTTP; Fri, 27 Sep 2013 03:04:49 -0700 (PDT)
Date:   Fri, 27 Sep 2013 12:04:49 +0200
Message-ID: <CAPVwjkwX=uCTsg6dG_T4c8iYEM0jemeTpGgxJZbAiWLYfgymZg@mail.gmail.com>
Subject: MIPS - passing data to kernel
From:   Martin Hinner <martin@hinner.info>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <martin@hinner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin@hinner.info
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

Hello,

 I am trying to port Linux to MIPS-based platform with custom
bootloader. I need to pass command line, initrd, and some parameters
such as memory size to kernel (preferably via device tree). The
devicetree is built/modified  in bootloader, so I cannot embed it in
kernel.

Please correct me if I am wrong:

- I think there is no standard for passing data to kernel, just some
firmwares use a0/a1 for argv/argc (in fw_init_cmdline).

- there is no standard for passing device tree on MIPS (does U-Boot
support this on MIPS? How?)

- the only way how to pass address/size of initramfs/initrd is via
commandline parameters (rd_start, rd_size)

What I would like to do is to pass initrd, device tree and commandline
to kernel. For example PowerPC has the following arguments on kernel
start which perfectly matches my needs:

  51 *   r3: ptr to board info data
  52 *   r4: initrd_start or if no initrd then 0
  53 *   r5: initrd_end - unused if r4 is 0
  54 *   r6: Start of command line string
  55 *   r7: End of command line string

Unfortunately MIPS ABI allows only a0..a3 (+stack arguments which is
of no use in this case) so I'll have to use either some sort of memory
structure (such as ATAGs used in ARMLinux/Android) or pass devicetree
address via register or commandline. I would prefer ATAG-like method
as it's much cleaner than other methods.

Any comments on this are welcome. I do not want to re-invent wheel.


Thank you,

Martin
