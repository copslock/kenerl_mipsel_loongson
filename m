Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 18:15:55 +0100 (CET)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33782 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010433AbbKCRPxqtz1A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2015 18:15:53 +0100
Received: by lfbf136 with SMTP id f136so25897057lfb.0
        for <linux-mips@linux-mips.org>; Tue, 03 Nov 2015 09:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded_com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=a+AMN7tUt7/fWi8wcKn0IeqlJP1D5WPMMsnfYQ24TK0=;
        b=dpPa6rKxAAD2F/6Z4PF9xUmUIITRLaUCTCZ+qPUkn87hJtSkSS2BL1wzEctDAxxXKV
         xpUNHQTxnXVf27/0Kjv9ofPwpxFBNlQiFV0vWjNFR4JNKzhSk+qmRvc+IFxjLxj7+hPf
         u8NKfdhiWG7PMYQoI/T62Nr5bgtOT9eKo31FN12JpdK/fvs2LLa9pKbBruZ/gg179dYX
         f+QdUiUS6Q/wPDVJBnD2LDGQ+2JPQrXprAZ2WiLooDTPvG8R57oZ6B058HqATv/EJLeO
         9amN5YML5+YL+Q5Izwsf3/UUlVjTMUNOv+MRA+As3vrK586OrqrlV/MZrLmUteFj+zaV
         OmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=a+AMN7tUt7/fWi8wcKn0IeqlJP1D5WPMMsnfYQ24TK0=;
        b=kHFYxxcAHAcAOPbK2MjbYAzAa9qfNRznEPENpsqqiXd4GJYswQ0svomYefk6b6RnH4
         0/4J7eqlO/2BOcFmmoN5ym620PowYbnvpX/l3nHEvzLwlywaOWa/aj+KtB8S+fo0rFvq
         m9JzYHrg5ho2/FbaUlS3F8eCXH6utyGG7IA3TcAffVgTPAhl+7v1aToTjB64Q44gtduI
         c0viPhunuvEcdVweuz6Fq2VauImfFUQXkfCa5SYSJk1Njfw6zRHf51D5szkJZIAjXrpf
         d6Mj9hAlVHtLCQ0/TakEG1XYS6qnyuKyi82ERAnd3gep/kOnVCzxxs24iDgEIde36Xij
         k3QQ==
X-Gm-Message-State: ALoCoQlhhzt6r0eI8va0XCGaiK0wOaf0pkEo6C4pkG6oGLZENf4Iz92NHI9j27ss1ktofa48crgh
X-Received: by 10.25.148.204 with SMTP id w195mr8982321lfd.77.1446570948244;
        Tue, 03 Nov 2015 09:15:48 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.192])
        by smtp.gmail.com with ESMTPSA id re5sm1349204lbb.36.2015.11.03.09.15.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2015 09:15:47 -0800 (PST)
Subject: Re: [PATCH] MIPS: kernel: proc: Fix typo in proc.c
To:     Tony Wu <tung7970@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
References: <20151103163943.GA49024@yggdrasil>
Cc:     Markos Chandras <markos.chandras@imgtec.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <5638EBC1.6010206@cogentembedded.com>
Date:   Tue, 3 Nov 2015 20:15:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151103163943.GA49024@yggdrasil>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 11/03/2015 07:39 PM, Tony Wu wrote:

> Fix typo introduced in commit 515a6393 (MIPS: kernel: proc: Add

    Please run the patch scripts/checkpatch.pl -- it now enforces certain 
style of the commit citing.

> MIPS R6 support to /proc/cpuinfo), mips1 should be tested against
> cpu_has_mips_1, not cpu_has_mips_r1.
>
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: Markos Chandras <markos.chandras@imgtec.com>

MBR, Sergei
