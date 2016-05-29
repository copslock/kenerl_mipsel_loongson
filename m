Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 May 2016 21:09:09 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36836 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033634AbcE2TJH5iiZR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 May 2016 21:09:07 +0200
Received: by mail-pf0-f193.google.com with SMTP id 62so7250463pfd.3
        for <linux-mips@linux-mips.org>; Sun, 29 May 2016 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OdvFqcqWot+CCocAzrpiA8ViAaBPz+R6X/T8I7DjnQw=;
        b=Htn3tqZcnJYB1cdPZQigXTWe1OiJacp4zvA1XyEzzP47Qic61ah7g5uriIXpJf1nJT
         l7vg8d2Ful8ds/sUeLmuuC8VZTuAjg/X/tAfSDEfSqTEKOm+gr4deOERkupjqAJ0G4NZ
         eMYpzPS0pdYQPeweNVAOs6oAneTskfkTrM5u6FteGcB7TWHtL8IdJpRwhCRKagJsqa3F
         eSmg2uancCq2EVQGuZ4cxK0XDwWQdHmQ/dv/Dm7vASl3FEq0MMKOJ76rUvmJ7EDTPcBM
         352aQ4DLKFNkXNKiArSHDboxqx0pTqY7ep1H0WS1hnpE/aH3bUFAU7UTD+D1RIoO2fIa
         B9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OdvFqcqWot+CCocAzrpiA8ViAaBPz+R6X/T8I7DjnQw=;
        b=WTAuVFsW70TBBmMd92KyMmtUFQMIdmWcfmgZ/1tc5wTi1hl3lrOTVbNjBwxVSt4KLd
         +jmD0Z2uOxuwmO6bm5ZSDwbTTS2lXeGxoQbgsnSSAPTS/neQJglZHWapnnGpL6BC1iIx
         VXf/FKi6bAasCEFHBKAsMVktd6E5JcBKKPB3GYLc3llAFBviEig416Pb4S+L4L3xVEak
         R/aZRJMvBraUsjYg5WksMD1H/P34xcbQ7un8ggi/su4H0OX38OwuY45DvUD8E+5qhZn0
         7C4DnkeNP8MKX+fK3P0dkQqCF4BZ/W0QmcP3fu/EV5itwaQF+Xa1f8xPG/rwd2GShGKq
         fIEg==
X-Gm-Message-State: ALyK8tIKgunavVrmvZb3RrW0LaCAHnLax8zzZPS9Hc7yb1oRy2T1NZ/hqqRMYGzneQT3Aw==
X-Received: by 10.98.103.86 with SMTP id b83mr32870063pfc.141.1464548941800;
        Sun, 29 May 2016 12:09:01 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:b546:9ef3:e6a7:b5eb? ([2601:645:c200:33:b546:9ef3:e6a7:b5eb])
        by smtp.gmail.com with ESMTPSA id e2sm27415672pfd.20.2016.05.29.12.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 May 2016 12:09:01 -0700 (PDT)
Message-ID: <1464548936.5020.37.camel@chimera>
Subject: Re: [PATCH v2] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mips@linux-mips.org, hauke@hauke-m.de, openwrt@kresin.me,
        antonynpavlov@gmail.com
Date:   Sun, 29 May 2016 12:08:56 -0700
In-Reply-To: <16b32a30-b0b4-d69e-b53d-827b9640c0cb@openwrt.org>
References: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
         <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
         <c481d3b1-bee1-89c9-bbb8-ef17d91570bf@openwrt.org>
         <1464547128.5020.32.camel@chimera>
         <16b32a30-b0b4-d69e-b53d-827b9640c0cb@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Sun, 2016-05-29 at 21:01 +0200, Jonas Gorski wrote:
> On 29.05.2016 20:38, Daniel Gimpelevich wrote:
> > On Sun, 2016-05-29 at 12:53 +0200, Jonas Gorski wrote:
> >> This will break/won't compile for ZBOOT_APPENDED_DTB as __appended_dtb
> >> is
> >> part of the wrapping decompressor, and the kernel has no knowledge of
> >> this
> >> this symbol.
> > 
> > If this were true, it wouldn't compile with the code you added to
> > compressed/head.S, either. You're referencing it as an external symbol,
> > which is exactly the same thing I'm doing here.
> 
> There are two different __appended_dtb definitions: the one for the
> (uncompressed) kernel appended one that is visible to the kernel (in
> kernel/vmlinux.lds.S), and one in boot/compressed/ld.script that is
> visible only to the wrapping decompressor.
> 
> Since the wrapping decompressor is built *after* the kernel was compiled
> and compressed, there is no way to tell the kernel where __appended_dtb is
> relative to the decompressor, so for ZBOOT_APPENDED_DTB you cannot
> reference __appended_dtb from kernel code.
> 
>  Your proposed
> > alternatives are functionally almost equivalent to your earlier rejected
> > patches:
> 
> These weren't rejected, just deemed insufficient (mostly by me myself).
> 
> And only to this one is similar:
> > https://patchwork.linux-mips.org/patch/7274/
> 
> But in contrast to this one, it doesn't populate initial_boot_params auto-
> matically, but instead still requires the mach to do that (by calling
> __dt_setup_arch()). I dropped that because IIRC at that time I read that
> initial_boot_params isn't supposed to be directly accessed.
> Also not populating initial_boot_params is IMHO better as just because
> a0 says -2 it doesn't mean a1 references a dtb - that should still be up
> to the mach to say that it expects a dtb to be passed.
> 
> 
> > https://patchwork.linux-mips.org/patch/7313/
> 
> This one was only missing alignment for the !SMP case but is otherwise
> equivalent to what is in the kernel now.
> 
> 
> Jonas

I see, and you are absolutely right in what you now suggest. What
escapes me at the moment, though, is how to reconcile all this with UHI.
UHI bootloaders may pass an external DTB, and it should be
indistinguishable by the boot code from an appended DTB. Thoughts?
