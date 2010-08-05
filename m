Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2010 06:50:17 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:44363 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493313Ab0HEEuM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Aug 2010 06:50:12 +0200
Received: by wwb22 with SMTP id 22so1411599wwb.24
        for <linux-mips@linux-mips.org>; Wed, 04 Aug 2010 21:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6Zru05XrM7wnoW5s5j9HX343/PdRTArV8CsMOI6NP2k=;
        b=WeuuORBOYoNnamAXdBHj4nf0nRKMfYmGDgEZDUnSOi57fppOXCP3VivosTk4rz0aUj
         we2NCo9L+W7N6UBm2qm9mn7HWrL3IDM5CucJhP43ekbcw3/2TjRK9Z+BIeYr/FzIbYZv
         +aWjkRMDiVcTbtQYU6z9p7PnHrts7SDcq+qNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QOozq2VRHRDaTQNKd9zvRySt75HQaYRFLVgUy3mewOf3Id0VhHct290xrME73QZdY8
         uXeSeWF9OtKMYNcrE+aREK7kEDWxQfHJ3RJjReY/uc4syv2kuinYzzkSztmWbaXDWQqY
         AgDQcmVh4oFAmErlAtsGMuZN2B7lXs8szhRb8=
MIME-Version: 1.0
Received: by 10.216.5.4 with SMTP id 4mr2970758wek.20.1280983806906; Wed, 04 
        Aug 2010 21:50:06 -0700 (PDT)
Received: by 10.216.159.204 with HTTP; Wed, 4 Aug 2010 21:50:06 -0700 (PDT)
In-Reply-To: <20100805013221.GE28402@linux-mips.org>
References: <9890d1383c75ce6df44d357687a9c4e2d6ba4050.1275438553.git.wuzhangjin@gmail.com>
        <96f3b48ba7f749c4357760008cdae644aa55b92d.1275438520.git.wuzhangjin@gmail.com>
        <20100805013221.GE28402@linux-mips.org>
Date:   Thu, 5 Aug 2010 12:50:06 +0800
Message-ID: <AANLkTikU2jVA_vSo9i+FMANUoB3N=HYRMdfG0Ffr4mBC@mail.gmail.com>
Subject: Re: [PATCH v4] MIPS: Clean up the calculation of VMLINUZ_LOAD_ADDRESS
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Alexander Clouter <alex@digriz.org.uk>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

On Thu, Aug 5, 2010 at 9:32 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Applied - but there was a fuzz when applying the patch.  Hope that was
> harmless...

Sorry to disturb you again.

Just found the key file calc_vmlinuz_load_addr.c is not in your
upstream-linus.git, I guess a "git add" was missing for it ;)

the commit in upstream:

http://git.linux-mips.org/?p=upstream-linus.git;a=commit;h=af86de3e5347c114afd978fbfc16af9a77e24c47

the original patch:

http://patchwork.linux-mips.org/patch/1324/

Thanks & Regards,
Wu Zhangjin
