Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2011 12:03:44 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:54153 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491070Ab1IMKDj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Sep 2011 12:03:39 +0200
Received: by wwf27 with SMTP id 27so386397wwf.24
        for <linux-mips@linux-mips.org>; Tue, 13 Sep 2011 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9aNuTrcQzIrUiNc9CJTKYBeqV/YcUUUqqmB96PZxFOo=;
        b=I51FZ4FqgAc6PthgqB8Bl/liuzBgyuSL/T16QKhg6/mXyuFxKmRMfLIlEma/SzJE6T
         KVm1dqb23bFFB6SGTLZHZgGOp6Hb2YHy2pGcRO9+TzfIj/DTQa6tqcdho0klASGrxUG1
         QDaconS4UGrbpzqYr1J7FHBMB+0Qp5q/C95J4=
MIME-Version: 1.0
Received: by 10.216.220.216 with SMTP id o66mr2586163wep.52.1315908211728;
 Tue, 13 Sep 2011 03:03:31 -0700 (PDT)
Received: by 10.216.197.158 with HTTP; Tue, 13 Sep 2011 03:03:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1109131101530.4143@Indigo2.Peter>
References: <Pine.LNX.4.64.1109131101530.4143@Indigo2.Peter>
Date:   Tue, 13 Sep 2011 15:33:31 +0530
X-Google-Sender-Auth: EnLiAbQE-xjQeBiw1Il3gcfckZI
Message-ID: <CA+7sy7B7YhgXxCmpVcOCdcvTuX-YfOjrEnZ1NxF70Bb8smuWmA@mail.gmail.com>
Subject: Re: [PATCH] Impact video driver for SGI Indigo2
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     post@pfrst.de
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6284

On Tue, Sep 13, 2011 at 3:09 PM, peter fuerst <post@pfrst.de> wrote:
>
>
> Hi Sergei,
>
> On Mon, 12 Sep 2011, Sergei Shtylyov wrote:
>
>> Date: Mon, 12 Sep 2011 13:56:36 +0400
>> From: Sergei Shtylyov <sshtylyov@mvista.com>
>> To: post@pfrst.de
>> Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
>>    attilio.fiandrotti@gmail.com
>> Subject: Re: [PATCH] Impact video driver for SGI Indigo2
>>
>> ...
>>>
>>> framebuffer device. Without the support of PCI & AGP.
>>
>>  It looks like the patch is spoiled as I'm seeing two spaces at the start
>> of line when looking at the message source.
>
> hmmm, that's a strange problem. The two spaces are not in the diff-file
> read into the eMail and are not displayed by the MUA (pine 4.64). But
> indeed, where's a leading space in the diff, there's an additional space
> inserted into the eMail-body. Have to find out the best way to suppress
> this behaviour...

In my experience the linux kernel folk are very particular about
format of patches, you should probably use 'git' and generate the
patch with 'git format-patch'.  If you have not done so, please see
the files Documentation/Submit* under linux kernel sources.

JC.
