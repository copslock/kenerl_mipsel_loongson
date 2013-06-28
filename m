Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 15:41:16 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33913 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817387Ab3F1NlE2PWED (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jun 2013 15:41:04 +0200
Received: by mail-pa0-f50.google.com with SMTP id fb1so2421732pad.23
        for <multiple recipients>; Fri, 28 Jun 2013 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=HfyUjYMIEuvRhric117STtezZK3wfYPleUkoxdJKQvQ=;
        b=CwhFGTHnEYg2xMI0h6RjFcOj6BKQaR82qJNPBW+8hW6h7xvCJZ4SoYoISvHTei9yjR
         zgVg5TZWSSDjzS9sD5qwVdfx5vztDWMmlrgf76/WrHZt1vmvRgDeg1ocQzmoEE7l99HO
         vcCihOlZB/1JMH+CXV1CKlPlBhTNrf0GSWdUNwQvu8RJxVRNQUvHJ09C4iBLg9mIBB5F
         3w7WhjBfVOFKSpFCWPO8bTCum054BM3aHSlOnNpi4oHnuw2sQCvJHhv/fV3ICx7BZHKw
         vFr8PTXGR0iQejlT88o1svRjxQRme3XAO3tuTfVMLnPF+jscom/XcLQHDStcwWMGwxO2
         9y1w==
X-Received: by 10.66.37.43 with SMTP id v11mr11549337paj.108.1372426857777;
 Fri, 28 Jun 2013 06:40:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.69.17.33 with HTTP; Fri, 28 Jun 2013 06:40:17 -0700 (PDT)
In-Reply-To: <20130628133111.GN10727@linux-mips.org>
References: <1372422327-21814-1-git-send-email-markos.chandras@imgtec.com> <20130628133111.GN10727@linux-mips.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Fri, 28 Jun 2013 14:40:17 +0100
X-Google-Sender-Auth: -yk24WJ5Cr9iKCt-eENbBY2X-iI
Message-ID: <CAGVrzcbyzgM8fnmO31eKMqDokV2gjS6Ds=Qd84Mz71ipvEDtqg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Kconfig: Add missing MODULES dependency to VPE_LOADER
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2013/6/28 Ralf Baechle <ralf@linux-mips.org>:
> On Fri, Jun 28, 2013 at 01:25:27PM +0100, Markos Chandras wrote:
>
>> The vpe.c code uses the 'struct module' which is only available if
>> CONFIG_MODULES is selected.
>>
>> Also fixes the following build problem on a lantiq allmodconfig:
>> In file included from arch/mips/kernel/vpe.c:41:0:
>> include/linux/moduleloader.h: In function 'apply_relocate':
>> include/linux/moduleloader.h:48:63: error: dereferencing pointer
>> to incomplete type
>> include/linux/moduleloader.h: In function 'apply_relocate_add':
>> include/linux/moduleloader.h:70:63: error: dereferencing pointer
>> to incomplete type
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> Reviewed-by: James Hogan <james.hogan@imgtec.com>
>
> Sigh.  One more bug in the thing.  It first of all shouldn't have been
> designed recycling so much code from the module loader in inapropriate
> ways.
>
> I'm going to apply the patch - but as usual whenver I have to touch the
> VPE loader, kspd or rtlx I feel like a blunt chainsaw would be the right
> way to fix this code.
>
> SPUFS is a special filesystem which was designed to use the Playstation 3's
> synergetic elements.  The code is in arch/powerpc/platforms/cell/spufs
> and it's a far, cleaner interface to other processing thingies, be they
> synergetic elements, or other cores, VPEs and TCs running bare metal
> code or strage things like custom processors.

Would not remoteproc be a simpler interface these days to load
bare-metal ELF code into one of these things?
--
Florian
