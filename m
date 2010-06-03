Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 14:04:29 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:55049 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492641Ab0FCMET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 14:04:19 +0200
Received: by fxm15 with SMTP id 15so32005fxm.36
        for <multiple recipients>; Thu, 03 Jun 2010 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=PhfRKDZMh+7QqMIHR3DMlVROnzdWQUscWTwVwobgFp0=;
        b=q+w2S3GRCdU1Tbjm8CriLCbdiw4RGqrbOU7VKh6bgy8e83WfmifmnLzUk0YA2ivT8W
         cNwHJsZ8Nk8Wvd3BnGF6YL3mdTQrG3KK0TZNgvxqkRFog7TxnV+7dfU46UT1La73vQLi
         yCL5G4ApID5ZjlyUrvcTb3AYT6FFTVRvRIV74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mHbx5hAlWHy7o35rROpzzO2Y2nNNt61RyhF1bSbnY48rcfjIRvw32QRZ2G4Ze3TrXk
         Xz02wHsZlfpF8ZFk/9p+afoad27fFbCiYkHKeSbdC9OOtbwNtMtguoRgtGEvbsZOxWlt
         aNI96l/kiYfoIWMvh3K0EiXOMMRZLn0bRPvqg=
MIME-Version: 1.0
Received: by 10.223.31.136 with SMTP id y8mr10177502fac.19.1275566653245; Thu, 
        03 Jun 2010 05:04:13 -0700 (PDT)
Received: by 10.223.104.209 with HTTP; Thu, 3 Jun 2010 05:04:13 -0700 (PDT)
In-Reply-To: <20100603113952.GA23033@linux-mips.org>
References: <95654e45e2f02133c6334fb147d3e28ef94f2bb0.1275439768.git.wuzhangjin@gmail.com>
        <AANLkTikKBasnKuS2Ym6fS8Wr17obMnFWSmA2mJxDIrjU@mail.gmail.com>
        <20100603113952.GA23033@linux-mips.org>
Date:   Thu, 3 Jun 2010 15:04:13 +0300
Message-ID: <AANLkTikEgVmUmumoKA8NtdclqqGgtqiD-I55JZEgtpZd@mail.gmail.com>
Subject: Re: [PATCH -queue] MIPS: Move Loongson Makefile parts to their own 
        Platform file (cont.)
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2328

On Thu, Jun 3, 2010 at 2:39 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Jun 03, 2010 at 02:10:26PM +0300, Dmitri Vorobiev wrote:
>
>> > Hi, Ralf
>> >
>> > I have fogotten to remove the -Werror in the Makefiles under loongson/
>>
>> I'm just curious: why would anyone want to remove -Werror? It's very
>> useful in most cases, IMO.
>
> arch/mips/Kbuild enables -Werror for all platforms.

Looks like I'm failing to keep pace with life :)

Dmitri
