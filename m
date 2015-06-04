Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 19:03:24 +0200 (CEST)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35033 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007837AbbFDRDVj1vWO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 19:03:21 +0200
Received: by wgme6 with SMTP id e6so38507256wgm.2;
        Thu, 04 Jun 2015 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=XS4vB+22Dh5jLHAcy2j2QS6OwLw/x/Ms4n8fMPjSH3M=;
        b=Q+h/t84lWvmQoJmvRJZtmllBhG8BEBMVO1Lfj5ot2JOqk8akXglET545a3D8n3XryW
         xFmqW5nCxzHi57jGP6F5EKxO5h59umFFavdXv578qD2qMaoQa7cfNa4nMYY8tahhc1wK
         FKPs4JOwjViSR+pCxqXuBYvFc9ZHe/X5UlNEK9xBUOeWavB8Rjr3LFDYCnlLNDrKe6tN
         MLi9BN1a32H/OfOKTPCNPooGkxTUZeKJh0lA4L7GoHjCRLUE1ykLW0d65QmesxtjALNK
         518D0tDHrzZA3HFA4zrjIP/zrtnLnNkueDWatKxS1T83QuY75/nPv5oI4k/8W471Tleq
         dzeg==
X-Received: by 10.180.210.235 with SMTP id mx11mr9282444wic.95.1433437396403;
 Thu, 04 Jun 2015 10:03:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.180.82.130 with HTTP; Thu, 4 Jun 2015 10:02:55 -0700 (PDT)
In-Reply-To: <20150604102032.DF5B4140280@ozlabs.org>
References: <1433308225-13874-1-git-send-email-robh@kernel.org> <20150604102032.DF5B4140280@ozlabs.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Jun 2015 12:02:55 -0500
X-Google-Sender-Auth: XbA79KAzBeXxVX9-nFzA42R70q4
Message-ID: <CAL_JsqKTNiVqZoPHn-UCPXMkddruNbywwiA2nwLkfbzaziXFBg@mail.gmail.com>
Subject: Re: of: clean-up unnecessary libfdt include paths
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mackerras <paulus@samba.org>,
        Grant Likely <grant.likely@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Thu, Jun 4, 2015 at 5:20 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Wed, 2015-03-06 at 05:10:25 UTC, Rob Herring wrote:
>> With the latest dtc import include fixups, it is no longer necessary to
>> add explicit include paths to use libfdt. Remove these across the
>> kernel.
>
> What are the "latest dtc import include fixups" ?

Changing the scripts/dtc/libfdt/libfdt.h includes from <> to "". The
import script does this now and the recent import in my for-next tree
has this. I'll clarify this in the commit message.

>
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
>> index c1ebbda..c16e836 100644
>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -2,7 +2,6 @@
>>  # Makefile for the linux kernel.
>>  #
>>
>> -CFLAGS_prom.o                = -I$(src)/../../../scripts/dtc/libfdt
>>  CFLAGS_ptrace.o              += -DUTS_MACHINE='"$(UTS_MACHINE)"'
>>
>>  subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks.

Rob
