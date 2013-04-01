Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Apr 2013 18:48:35 +0200 (CEST)
Received: from mail-da0-f45.google.com ([209.85.210.45]:40023 "EHLO
        mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816822Ab3DAQseMPWp6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Apr 2013 18:48:34 +0200
Received: by mail-da0-f45.google.com with SMTP id v40so1138048dad.4
        for <multiple recipients>; Mon, 01 Apr 2013 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=cqPDnXdzmSMdj5Q0TTdfmqRbnxXJ1bMX76v1ChCja2s=;
        b=i33ZQdOY9/uFDpOvsDEkZDleAz3YcnhjCWS7HjwVYX2v1LYWLSVUEEMide3B2Jr1FK
         R2/pkDxvnYSlzy6Goj+F1hJL7AfHwueLaDp3VVujF1JTmbIf68Msb++9XxyCMfbhEJog
         Ony1H6XBg9QbGUTZqw6eC2mFuNDeroo/ovSLuiEyMPA7UtbbCqNeG3no0Hh/mhSd9awS
         9wErFjeydnI63k1WwVOWlRQMn1fygVYCDHwYJ870Rxkb7Ms09CGfLsGozIqUCpT/RbGd
         eIVtqwBuAaKGuIiOTkdcn/aci1nJ5rBH5oiRtccNIsyLVtDxihDWLKZp6nrt5Q6rVfT2
         MWdQ==
X-Received: by 10.66.251.231 with SMTP id zn7mr19705481pac.71.1364834906838;
        Mon, 01 Apr 2013 09:48:26 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id jk1sm14438011pbb.14.2013.04.01.09.48.24
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 01 Apr 2013 09:48:25 -0700 (PDT)
Message-ID: <5159BA57.5030504@gmail.com>
Date:   Mon, 01 Apr 2013 09:48:23 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     =?ISO-8859-1?Q?Llu=EDs_Batlle_i_Rossell?= <viric@viric.name>,
        Ralf Baechle <ralf@linux-mips.org>,
        Al Cooper <alcooperx@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: FTRACE makes the kernel not boot
References: <20130330232944.GR10445@vicerveza.homeunix.net>
In-Reply-To: <20130330232944.GR10445@vicerveza.homeunix.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 36001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/30/2013 04:29 PM, Lluís Batlle i Rossell wrote:
> Hello,
>
> For a fuloong (loongson2f) I had two configs, one booted and the other not, on
> a linux 3.8. I narrowed down the difference to enabling CONFIG_FTRACE.
>
> Enabling CONFIG_FTRACE makes the kernel not load at all; it even does not print
> any early printk to the serial port.
>
> Do you agree there is a problem with FTRACE? Maybe it is solved already
> in the mips git branch?
>

This is caused by 58b69401c797e (MIPS: Function tracer: Fix broken 
function tracing), which broke ftrace for 64-bit kernels.  The subject 
of the patch is a bit misleading in this respect, it probably should 
have been something like 'MIPS: Function tracer: Break function tracing 
that used to work'

David Daney

> Regards,
> Lluís.
>
>
>
