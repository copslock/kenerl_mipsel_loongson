Return-Path: <SRS0=rYMR=PT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75B2C43387
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 08:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E5A20872
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 08:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMK6VyLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfAKIhw (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:37:52 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34919 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfAKIhw (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 11 Jan 2019 03:37:52 -0500
Received: by mail-yb1-f196.google.com with SMTP id f187so5544913ybb.2;
        Fri, 11 Jan 2019 00:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyAWe21MMXZ0fS4NTs9X/8VSp5E1mQWCwE+SFamRGk8=;
        b=OMK6VyLuE00i/kQKx4jMRPi5pg1vashvhS0P+qG2gljAy4PVn3ObNKiV955AXB+1D7
         p3dbI+uBpM1BT7/ZocKYiMPiBCScpPoXp4n4VlXH/AaGn7ntF6PQIp3L0ArAIiaocGmo
         lIvNP4+PM+LOFwmCS/sLWWnASfnvfZGCQEIAOfnkNW2pgEFoSlXqU9VIgSjgqZ4XVJWM
         usBAB5IofOzH4A+xqLtT4XZSOSvNje99tOF8s9hMiqKFwi6LguxkPcMLQzGyvXmIXOFc
         aK9rNW9ai4u2A8YhEGfIrf/Gt192mSrlnGDGdjtW94/CvqFDXDcP+R1PJ/zowOKo1pfn
         Lp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyAWe21MMXZ0fS4NTs9X/8VSp5E1mQWCwE+SFamRGk8=;
        b=Be9UdNFktPD3OM6lQJ9mkVDDR2pQyyVZnYSZAm1i7l18WeH0/6kdLD3j7TVsvFTl9j
         dAS1QuXYCGjY4KEKG1EfoVaIkAdSZU+9Az0cOgXa6jjS88y/PjYK7hUum6B33h4Z6Ndw
         SwZ7oYPvLYyBcux8qdw7xI8LtmsFWfMGJUbX8mFwS+v7oJe7oW4UcRrKHIA0wnuAkdXV
         cgiGaX2ZdG1Dsvxf47wMgcHJWDHc5PZb1lLB+ldsMzfAKdgRKS/qhir8Xbladk6hV2CS
         FgW5xs99F1WzsmAd/mTeWu7019cnUMxkNdVK/72+twxC0+alsh8QaU81CL35NSaP03Rz
         fgNw==
X-Gm-Message-State: AJcUukf94VJ2dR3lD0eFBoA5U7hFm3p+g3pEqjlbmLW4C50teyJ82qgz
        E4EoEGYXA2F9tXJ0K+gdNevR2h4VCfBykHW03G5lgSPc
X-Google-Smtp-Source: ALg8bN6FrzInGWlvbcJlaVcJZerX+x8N3sXZdDdE73COkEU9zhm0slKYxWPWVEgO5L44Al9fx9Ia3zZW0qdaltXI8GQ=
X-Received: by 2002:a25:7b43:: with SMTP id w64mr13514711ybc.397.1547195870837;
 Fri, 11 Jan 2019 00:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20190110170444.30616-8-amir73il@gmail.com> <201901111612.XzUbwDyo%fengguang.wu@intel.com>
In-Reply-To: <201901111612.XzUbwDyo%fengguang.wu@intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 11 Jan 2019 10:37:39 +0200
Message-ID: <CAOQ4uxg+Zk74XqPMNmrEpR13Wr9r=8osOrHVAhH1De9UMFmRoQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] fanotify: encode file identifier for FAN_REPORT_FID
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kbuild-all@01.org, Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Jan 11, 2019 at 10:11 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Amir,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.0-rc1]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Amir-Goldstein/fanotify-add-support-for-more-event-types/20190111-090241
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=mips
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/kernel.h:14:0,
>                     from include/linux/list.h:9,
>                     from include/linux/preempt.h:11,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/fdtable.h:11,
>                     from fs/notify/fanotify/fanotify.c:3:
>    fs/notify/fanotify/fanotify.c: In function 'fanotify_encode_fid':
>    include/linux/kern_levels.h:5:18: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat=]

I'm confused.
__kernel_fsid_t val member is long[] on mips arch and int[] on other archs.
Which format specifier am I supposed to use to print it?

Thanks,
Amir.
