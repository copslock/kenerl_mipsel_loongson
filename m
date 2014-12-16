Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Dec 2014 19:24:53 +0100 (CET)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:54413 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008923AbaLPSYvjfzh0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Dec 2014 19:24:51 +0100
Received: by mail-ie0-f177.google.com with SMTP id rd18so12836361iec.8
        for <multiple recipients>; Tue, 16 Dec 2014 10:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AOgLHljdkAJxs5fr+f/sFAamAVF0Jh5u/A96fLjGOx8=;
        b=E8SUjk/5EiVPOlCq2lswX+gwaKVE/KkiNztsaTnykDRF0mS/FAOW16MmVaUF0Mv1AV
         9rOjE2j0A74hRBAvfhVcDYFg6iRN2QDweTSduAaLK6WqAuJ+9+IYaScSsuxHnM+AG3P7
         nKtFfZpIVFrKnvW2cwjWbbGiTTK+YgU//4N5qZgkmseQK/t8affifaUcV2+ErAHN5xOs
         18c/kgBnL1QTHUlNDUWcZiXwkJ77AWMD8X198xVUQTCFXm+b234TtRA9I6Umw2QfbmUk
         UN0e7g3vfnzfu4ERb8ztWtTzhK8VfGwwkpxWuvIxAunf7EIjM6IxfzRf5PHO7XDhm2wA
         cAFA==
X-Received: by 10.107.32.5 with SMTP id g5mr36004500iog.20.1418754285775;
        Tue, 16 Dec 2014 10:24:45 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id ci9sm1098469igc.1.2014.12.16.10.24.44
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Dec 2014 10:24:45 -0800 (PST)
Message-ID: <549078EC.5030007@gmail.com>
Date:   Tue, 16 Dec 2014 10:24:44 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Aleksey Makarov <feumilieu@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 12/14] MIPS: OCTEON: Update octeon-model.h code for new
 SoCs.
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com> <1418666603-15159-13-git-send-email-aleksey.makarov@auriga.com> <20141215210148.GB10323@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20141215210148.GB10323@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44709
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

On 12/15/2014 01:01 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Dec 15, 2014 at 09:03:18PM +0300, Aleksey Makarov wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Add coverage for OCTEON III models.
>
> [...]
>
>> +#define OCTEON_IS_OCTEON1()	OCTEON_IS_MODEL(OCTEON_CN3XXX)
>> +#define OCTEON_IS_OCTEONPLUS()	OCTEON_IS_MODEL(OCTEON_CN5XXX)
>> +#define OCTEON_IS_OCTEON2()						\
>> +	(OCTEON_IS_MODEL(OCTEON_CN6XXX) || OCTEON_IS_MODEL(OCTEON_CNF71XX))
>> +
>> +#define OCTEON_IS_OCTEON3()	OCTEON_IS_MODEL(OCTEON_CN7XXX)
>> +
>> +#define OCTEON_IS_OCTEON1PLUS()	(OCTEON_IS_OCTEON1() || OCTEON_IS_OCTEONPLUS())
>
> There are no users for these.
>

True, but we will soon be adding users, so we would like to keep them.

David Daney

> A.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
