Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2018 21:10:40 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:35465
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994689AbeA2UKdcy9m1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2018 21:10:33 +0100
Received: by mail-qk0-x244.google.com with SMTP id d80so7198746qkg.2
        for <linux-mips@linux-mips.org>; Mon, 29 Jan 2018 12:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqJkdiNsM+r7P+LEjEmHkUupkD5z8KGS2pDf/6BivvA=;
        b=QD4xIelE/FcyoYNIbexQfDwa8a6ThZVTVG8/xpaODr+/Zy8TstHTe12PBQmiNcUZ6U
         O8d0QX8+O8o4R79aqnuDIOOEyg4coBLuMrD1WktRzar3z+TCY7hLM3DdDqiCjkhgDOdv
         BRLh1GebjEVlks40JGIEIoiSKB5o10aaofMIvboqTweShenFN/zco7CGnQkvYeISOgyr
         Qf3+HqJ/L3tHBfUSCvPkaZX/GlmrXbCbzOOExh0wZusCwirDxaX1xjxvEnMfN1GSYJY+
         25gEqH6rQA506ScqQOgpqfzLRBxP8an5FwCzP+aIqXgQT3jovSRVtiH1xHflK64nZFpJ
         uPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqJkdiNsM+r7P+LEjEmHkUupkD5z8KGS2pDf/6BivvA=;
        b=CBuR7UJ7bqM/aQoOf2u6SkcWtMjwz3ePRu7JdjiG48dDh+iN9ya/DG+v7PXWD297CK
         x3bHMfspeUyZUSlz8xsPVfgi4esIUZiL42RVrchwOJDDYXprNp893pVPGFEzhvuoNZ1C
         WGJnjy6drk5oUbQSGDwBM+HXAt/06Fy3ZzUxtUG/FnTE3A5Jz8Rhye0X83I3yCkWtMLK
         ZpL2gmZpMSm5VSmyI45t+80vf9toT1NxLwhDCC3Rs84vQARJ0c10ztQSC2DSSrYtSsJw
         QCiprJ3dEfItIicgGqXKRwSFQUba2Utg0dw+4tjbxrY4sUwOhfGWV6smVkC5U3aZrlEn
         9E2A==
X-Gm-Message-State: AKwxytcAXxZG+flJB78ImTe9OolTzxnpCG80EsdELPMwPP/pqrNKdoLa
        76ajVxnWhVe747RouTRvKNg=
X-Google-Smtp-Source: AH8x226OfI/kh9Y+7BihFdhRGRJ44gZMtqZN2D74xzLmG2dl3gA4z4bhnqxd+4bRT37ZpRZgvkFXTA==
X-Received: by 10.55.75.216 with SMTP id y207mr15508943qka.7.1517256625929;
        Mon, 29 Jan 2018 12:10:25 -0800 (PST)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id t56sm10324065qtt.4.2018.01.29.12.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2018 12:10:24 -0800 (PST)
Subject: Re: [PATCH 0/2] MIPS: generic dma-coherence.h inclusion
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
References: <1516758010-7641-1-git-send-email-f.fainelli@gmail.com>
 <ec150822-45f6-1e6f-1a76-2ef9a21da20d@cavium.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <76146321-10e0-8dff-c763-9c76e2666b09@gmail.com>
Date:   Mon, 29 Jan 2018 12:10:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <ec150822-45f6-1e6f-1a76-2ef9a21da20d@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 01/26/2018 12:31 AM, Steven J. Hill wrote:
> On 01/23/2018 07:40 PM, Florian Fainelli wrote:
> 
> [...]
> 
>>
>> Florian Fainelli (2):
>>   MIPS: Allow including mach-generic/dma-coherence.h
>>   MIPS: Update dma-coherence.h files
>>
> I have tested these on our Octeon III platforms with PCIe and saw
> no issues. Thanks.
> 
> Steve
> 
> 
> Tested-by: Steven J. Hill <steven.hill@cavium.com>

Thanks for testing Steven!
-- 
Florian
