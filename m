Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2018 09:06:52 +0100 (CET)
Received: from mail-lj1-x242.google.com ([IPv6:2a00:1450:4864:20::242]:32960
        "EHLO mail-lj1-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991063AbeJ2IGo3xLqz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Oct 2018 09:06:44 +0100
Received: by mail-lj1-x242.google.com with SMTP id z21-v6so6852414ljz.0
        for <linux-mips@linux-mips.org>; Mon, 29 Oct 2018 01:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ajaYwJF4Ljrrll4IuoXvlD3RjAFhr9gdHOnHhXAu5Zs=;
        b=bgtfFerzqxC6ZUuW/O5tRqis/zoiuS3TRapqRabfRAjRT6CbGF3xgSXW/A9SlH2G4O
         s/JXPY7DoPAYN0uosA05sDINjNfda8s2Nq6OapQWkAyjEuyKBqs10HB7CSvEe14F5iEW
         ZroMXJabEv34xiq5PH9zA7msP+7mqsRx2TqRJCOjq5I6oYTP/WDWWSzIYrjCkIl2ptTz
         UX4P25hpz71nbGq1MgfQfwCnRO64i/GrEXANeX6hTTT/fGunYPdkCMCIb217u0ypIPrm
         SPg9tGHE5M7ql0UsRWXrROLk3cCNHkiWOvY98Iuzbl6d1fjcwl3/ULZmjj0krWyOOi5K
         iQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ajaYwJF4Ljrrll4IuoXvlD3RjAFhr9gdHOnHhXAu5Zs=;
        b=m1SeW2sOifqEqZ4pw6H0DyVsZ7T+Kct3vhS2i/6FAOIgzoI2lJ45SGY+mENmtEDGlK
         eJq6JUtY1HrK+JJXx0MDza5TPtquJGisN546MmIKAvt7R/p7IBi6GOh86UCR9enmNVgj
         KdQ8ACJuNwRseRCIaw0e192xxu+8BaqAhT8EZwPYxS9iNwABcc4CKFanklN1Hr7hewFa
         dSdU6Pbwbx4DlCelLvYDcd1ufus9EsvzNoWVVEo+h8iHE4g9alKEnTenkQxlKBJ9HJnG
         LfIkCFL4dJ4b7YHxnEbBu8piLDqTPfVb4qMkdyqW4RqDJao6rg6yylRumqrqw8S7zuYh
         ag7g==
X-Gm-Message-State: AGRZ1gJ+w1QeV19ZRlBdscOuEE3Sp+Ol4fijcmpbdnaey/Z3aNGWfXwA
        elbaQUvCFwy2YFXiuO7XfrlyIw==
X-Google-Smtp-Source: AJdET5cKauyhWO1h2ZqTBuRWJK5O+Kd2QrHv5LHiQChZveprNqHnA11mW3b1cYjhThIm2NJUoLJRTQ==
X-Received: by 2002:a2e:215a:: with SMTP id h87-v6mr9407080ljh.102.1540800398714;
        Mon, 29 Oct 2018 01:06:38 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.80.69])
        by smtp.gmail.com with ESMTPSA id c22sm2922682lfd.88.2018.10.29.01.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 01:06:37 -0700 (PDT)
Subject: Re: [PATCH] clk: boston: fix possible memory leak in
 clk_boston_setup()
To:     Yi Wang <wang.yi59@zte.com.cn>, paul.burton@mips.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn
References: <1540800277-24524-1-git-send-email-wang.yi59@zte.com.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5484fe07-5909-dc67-5de6-72e878060a54@cogentembedded.com>
Date:   Mon, 29 Oct 2018 11:06:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540800277-24524-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66968
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

Hello!

On 10/29/2018 11:04 AM, Yi Wang wrote:

> 'onecell' is malloced in clk_boston_setup(), but not be freed

    Is not freed.

> before leaving from the error handling cases.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
[...]

MBR, Sergei
