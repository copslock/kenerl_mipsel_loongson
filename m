Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2011 22:35:26 +0100 (CET)
Received: from smtp-out.google.com ([216.239.44.51]:4589 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491853Ab1A0VfX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Jan 2011 22:35:23 +0100
Received: from wpaz17.hot.corp.google.com (wpaz17.hot.corp.google.com [172.24.198.81])
        by smtp-out.google.com with ESMTP id p0RLZLkf029923
        for <linux-mips@linux-mips.org>; Thu, 27 Jan 2011 13:35:21 -0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1296164121; bh=6lBbDGwCP9nCuKjZD+SzFVJruIQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=vWKlsFy2rZnzOmEL9PhYkgfOPqOlL058tfb1OTY1rO7JwTp7OsaStiBwbjQcVUJmQ
         g116b8oz5XrzrC+4m7aLQ==
Received: from gyh3 (gyh3.prod.google.com [10.243.50.195])
        by wpaz17.hot.corp.google.com with ESMTP id p0RLZIsu020974
        (version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 27 Jan 2011 13:35:20 -0800
Received: by gyh3 with SMTP id 3so900662gyh.12
        for <linux-mips@linux-mips.org>; Thu, 27 Jan 2011 13:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=H045wxJqKdfLCFcLgGgbmOjTHaafT5TTkK+DCnaXn3o=;
        b=WK+YXQpE69whJCW2cPY/mJMrT9ro3OpGtWEw9+dY0tHS9XR7lH1t5OAmQif0HltUe6
         86xtgDCSUW+ZBokzKKrw==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=HfJZambmbuos4tL/13Uz3uR+T8ELDmhPv308on4R90fQt5D9m49TF/f7STY5A1jGBM
         TpJPErkatEbPXORBOpNg==
Received: by 10.90.233.9 with SMTP id f9mr3707853agh.78.1296164117873;
        Thu, 27 Jan 2011 13:35:17 -0800 (PST)
Received: from coign.google.com ([216.239.45.130])
        by mx.google.com with ESMTPS id f10sm20875365anh.5.2011.01.27.13.35.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Jan 2011 13:35:17 -0800 (PST)
From:   Ian Lance Taylor <iant@google.com>
To:     loody <miloody@gmail.com>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        gcc-help <gcc-help@gcc.gnu.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Fwd: about udelay in mips
References: <AANLkTinvdEPwQ=DmcF8nnTAa0Py_O=+p7x1pobcTNHom@mail.gmail.com>
        <AANLkTik8hQfd8cvNj=qeq5U=6zpQHw33a9hfK-q8+x1Z@mail.gmail.com>
        <AANLkTikpUBtg2zz8tcbcz2rcG-O+fTFwb_pTi88uZe0h@mail.gmail.com>
        <AANLkTi=zfr5YuwBCcvH2Jas50UxnUtvzp_CDyN25sT5h@mail.gmail.com>
        <AANLkTim_swh58fCUxZ4e6MDrM9Lqrbm+1ufnp8W767JL@mail.gmail.com>
        <AANLkTim+Dy1_MFoMcXK3aPCKUcz6hpJY7B5kKY_nXNnP@mail.gmail.com>
        <4D4156CF.1040909@mvista.com>
        <AANLkTimdXa9WS7WLuKgD4iOCXcwvi5gPf5fQ2_eMsiW_@mail.gmail.com>
Date:   Thu, 27 Jan 2011 13:35:14 -0800
In-Reply-To: <AANLkTimdXa9WS7WLuKgD4iOCXcwvi5gPf5fQ2_eMsiW_@mail.gmail.com>
        (loody's message of "Thu, 27 Jan 2011 20:28:34 +0800")
Message-ID: <mcrlj26owrx.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-System-Of-Record: true
Return-Path: <iant@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: iant@google.com
Precedence: bulk
X-list: linux-mips

loody <miloody@gmail.com> writes:

>>   Probably because in 2.6.30 you only cast the result of 32-bit multiplies
>> to 64 bits. In the 2.6.33 kernel, the mutliplies are 64-bit as the
>> 0x000010c7ull constant is 64-bit...
>
>>> void __udelay(unsigned long us)
>>> {
>>>        unsigned int lpj = current_cpu_data.udelay_val;
>>>
>>>        __delay(((unsigned long long)(us * 0x000010c7 * HZ * lpj)) >> 32);
> so that means (us * 0x000010c7 * HZ * lpj)  is calculated at 32-bits and finally
> (unsigned long long) cast it as 64-bits?
> if i remember correctly, "64bit cast to 32-bits" is possible get 0
> value, since high bits cast out.
> But how 34-bits cast to 64-bits will make the value as 0 if original
> low 32-bits value is non-zero?

I don't know the type of HZ.  But assuming it is a constant, then the
rules of C are that the expression
    us * 0x000010c7 * HZ * lpj
gets evaluated in the type "unsigned long".  The fact that you then cast
that "unsigned long" value to "unsigned long long" does not cause the
multiplication to be done in the type "unsigned long long".

You need to write something like
    (unsigned long long) us * 0x000010c7 * HZ * (unsigned long long) lpj
to get the multiplication to be done in the "unsigned long long" type.

This questoin has nothing to do with gcc, by the way, it's a C language
question.

Ian
