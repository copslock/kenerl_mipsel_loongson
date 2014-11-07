Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 19:35:19 +0100 (CET)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:61671 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012811AbaKGSfSGjPr8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 19:35:18 +0100
Received: by mail-ie0-f182.google.com with SMTP id rd18so5733420iec.27
        for <multiple recipients>; Fri, 07 Nov 2014 10:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=iYMFRBMzf4I41zmThTFeA2BUIQzCr4D922r3APhYsCk=;
        b=Gu1z7uDLyKrXuAH5KK+x+zOVC1yZ+H5e57AP8rm8PCTO7/fuopsV4P1TKHap2JQpxQ
         hkZHiS1Ux+NMbWR06yW46DH4fikQVxhOR9ZqxOCn6OG8O2u2Lw3St2wvFvduut3523Qr
         3Z6QPtJO8Xqb75j4K9vEpULIWiyxnb20yL4+eF25aRhiy2KpIkEaChuKeDFmG5P0+pkU
         3/BzRL3ct0CeJRsMvHF8pI+7Iayq/wkRYgd82jz4hh5vEDm5QOd/MTwo/uZQnd8A2tyC
         IZTVK9IdQEGSSXeiHxMc/6ARqRgqrHpuxrgTYxsWek9bo5bnF8PIGNlDGRJZYNUKkadm
         UMmw==
X-Received: by 10.50.39.80 with SMTP id n16mr5916429igk.49.1415385312293;
        Fri, 07 Nov 2014 10:35:12 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id 5sm991161igl.17.2014.11.07.10.35.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Nov 2014 10:35:11 -0800 (PST)
Message-ID: <545D10DE.5000804@gmail.com>
Date:   Fri, 07 Nov 2014 10:35:10 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC PATCH] MIPS: optimise 32-bit do_div() with constant divisor
References: <1415290998-10328-1-git-send-email-mans@mansr.com>        <20141107005031.GA22697@linux-mips.org>        <yw1xbnojkazo.fsf@unicorn.mansr.com>        <20141107113545.GC24423@linux-mips.org> <yw1x389vjbsm.fsf@unicorn.mansr.com>
In-Reply-To: <yw1x389vjbsm.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43923
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

On 11/07/2014 07:00 AM, Måns Rullgård wrote:
[...]
>
>> As for access to hi/lo, I tried to explicitly put a variable in the lo
>> register.  Which sort of works for very simple cases but as expected it's
>> easy to get GCC to spill its RTL guts because it runs out of spill
>> registers.  It maybe can be made to work but I'd feel nervous about its
>> stability unless a GCC guru approved this method.
>
> The "x" constraint can be used to move a double-word to/from the hi/lo
> registers.  On DSP targets, the "ka" constraint provides access to the
> three additional hi/lo pairs while on a non-DSP targets it degenerates
> to "x".  The "ka" constraint is available since gcc 4.3.0.  I see no
> reason not to allow this extra flexibility.
>

What would the performance penalty be to hand code the assembly so that 
only mips32 instructions are used (i.e. no MADD), and transfers from 
hi/lo were all explicitly coded so that there were no hi/lo register 
constraints, but only clobbers of "hi", "lo"?

That would give you something usable on any 32-bit CPU with any version 
of GCC.

David Daney
