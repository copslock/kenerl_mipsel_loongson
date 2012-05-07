Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2012 17:11:38 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:49915 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903638Ab2EGPLe convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 May 2012 17:11:34 +0200
Received: by laap9 with SMTP id p9so895411laa.36
        for <linux-mips@linux-mips.org>; Mon, 07 May 2012 08:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=6Wl6hVcAD/X4k+4T2wD3D0ZvUgFg32w7GYq3Bs3XCQ0=;
        b=ZwtSnz47ERv3KknxH4f3NPOoFJkLYW/aK6HPHKOSTmdbSStPAb1P2sOJsy3/2GrFOD
         d7o1Uq/26d9GefP3AX21Gse1F/zYlL6TnS52HdtC55XsXBjX9GQeHycFuqgMgwHj6bFH
         76Y0Fn4lknF1SqlBfAw5L0y/SMaSgscY9h+aoD3J2DSO0+YOQEmsmrj9/qN3AdwgjM4l
         iocN4uhoMBA90GqT4fRVbkstU6PdAlY8m6No/+AwawMTm+2JPNvEj+ryGStiVKxQJIHf
         EplcZQMHQn9jJBHOk4xAQ+9jiG1VaABgOAB+A196Zc2H6il4TL5t/5i8HuRWc0E4QRPZ
         4Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=6Wl6hVcAD/X4k+4T2wD3D0ZvUgFg32w7GYq3Bs3XCQ0=;
        b=P2mSKIjqKw2JIwMFuB2MLA79sqD8s2j0Co0Du+tFzewi+DGODIIVo3549kzUps5gWH
         5Xg0TmUHT5df8fPX5iNAqS56u1hmmAoYArofRYKXm/JdZetSpo4GnzNDM0wVt0emuUDA
         fBQ3L+wJe8U9GARhhltyVHliD/low3EXH4qCrQp5ONCV0YUrnIuo+YgoMSDohktMFXKl
         46uGz05OKLlDlEeYvwHaP+iJUWxDjcRlLQks0cBAuk7z0nIx/nNd1g5bjSrRDwx4mn8/
         XAGJBugMvsF14c3S8NJ+FgRB80x+5qf4+EC3zs1KERppCKmZ5bNdQGxZMBB+zsyuGmUJ
         bToA==
Received: by 10.152.147.33 with SMTP id th1mr6673395lab.9.1336403488492;
        Mon, 07 May 2012 08:11:28 -0700 (PDT)
Received: by 10.152.147.33 with SMTP id th1mr6673373lab.9.1336403488356; Mon,
 07 May 2012 08:11:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.86.6 with HTTP; Mon, 7 May 2012 08:11:08 -0700 (PDT)
In-Reply-To: <4FA3B596.3050106@openwrt.org>
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org>
 <4F9ED1DC.3050007@gmail.com> <4F9FE4F6.5070909@openwrt.org>
 <CAErSpo4bZ=0=DtbDots_GOGeLNhX6Q4eJrdetaFQMv4iiv5+XA@mail.gmail.com>
 <4FA32E47.7020406@gmail.com> <4FA3B596.3050106@openwrt.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 7 May 2012 08:11:08 -0700
Message-ID: <CAErSpo4AQh3cJzULkmP_Dqsf0cSPRP1WqvhuQR3gePXw2rN7rQ@mail.gmail.com>
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
To:     John Crispin <blogic@openwrt.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmXQ3Y+HFD+j/pBkvf4ADihwXGS9mf5phpt9DxcGSnAp5j3uI+k4nvJvk2eL9dmjxJcj0SkcuDIFKbkDyB/ugiCuAT7vGXME/PUoVcEN9SiGNBUiTQA+MqA6h3YIS6j9DEZmNr6Ox9p5KKzHulhV3ob+VO2oA==
X-archive-position: 33177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, May 4, 2012 at 3:55 AM, John Crispin <blogic@openwrt.org> wrote:
> Hi David,
>
>> The problem is when you start declaring function pointers in various
>> ops vectors.
>>
>> Consider:
>>
>> void (*foo)(const struct pci_dev *)
>> void (*bar)(struct pci_dev *)
>>
>> foo and bar are not type compatible, and you will get compiler
>> warnings if you use one where the other is expected.

Oh, right.  I vaguely remember tripping over this a few years ago when
I refactored pci_swizzle_interrupt_pin().  Thanks for enhancing my
simple understanding.

>> So the question is:  Are we ever going to the address of any of the
>> functions that are being modified?  If so, we have created a problem.
>
> i could not find any place in the code where this happens, which does
> not mean that there are none.

I compiled alpha, ia64, mips, parisc, powerpc, sh, sparc, and x86 and
didn't see any issues related to this patch.  There might still be
something,  but I'm willing to help work through them or revert this
if it turns out to be a problem.  I'm still assuming that Grant will
handle this.

Bjorn
