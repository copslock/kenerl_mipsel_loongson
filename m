Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 22:36:58 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36386 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032841AbcEUUgzeASnr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 22:36:55 +0200
Received: by mail-lb0-f171.google.com with SMTP id h1so44912549lbj.3
        for <linux-mips@linux-mips.org>; Sat, 21 May 2016 13:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=haG7oNUdPZwMIVuMiIYIzJnDlPgFJqih26OedlnVf8k=;
        b=lo3BxFK1xbL8I+5eay7mPt4FlcKbsLERWP3S2tg6e2AGvhC/8RbIRyiMgYibXeUllU
         wvCBbCBXee18T0cPlzPNmnuqROe//z5y6PK88NSiQESBVLQw1yaw74gpIbxUzXZvTCFB
         DNiTyDfMOvGLgdeHUWXoXn6uJCDNDONKEmqCdLXMz4V2W8CFcQYtI/kdTPBQdB0ZKvJP
         RM5uvsS+Bv9qfPT4kfrMnUydl9Ovg5uON9qv0U8dcBA/QX0aQfIG5c3KKWKNTOIQzdzj
         HY/lWyBeIqDff5nhZqkv3r/BOqM4B8A1rxV/ACjtFzdIF/YpZWL8573W3GRc/zsIMkp8
         MnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=haG7oNUdPZwMIVuMiIYIzJnDlPgFJqih26OedlnVf8k=;
        b=IX4TUmvaKyuZluzEupVUnJDDAbI78fAk2REI9OLWL6NvE+26+zgVI20Apk5uB78L5G
         7SsyoRWh0etObZBzbQFgAOTFJjHkWzHnr6rMK5n2WD7mL38Wr/EQU3MRetj0/Tkp6nA8
         0IYhbxjVaAbcu6JrSuBY+grGF7SaGyZ6UQnfmYN1Y0h5XtTll5QPyqGyi31lj1hZNMPo
         9Y8xtA0ceQAiXxAOuMIjhjkZBcjft5eKfDZlfV3icZUaS4xlaEUIBFhJ5JOOQjk4vMx6
         MB9nh5YU+qHJR0O1hvhMUUXwxeF6JUGrLRk9/XVQbRNvb4PGTqA5KSUI4LdHGnUfjrTH
         dqVw==
X-Gm-Message-State: AOPr4FWfjqVQX+6PnXYY4hhLDQvkDU35+E8YsZvFvEYTY1mebFBBxwEQGN+Jb6F/cO6X8g==
X-Received: by 10.112.169.8 with SMTP id aa8mr3239655lbc.110.1463863010199;
        Sat, 21 May 2016 13:36:50 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.87.73])
        by smtp.gmail.com with ESMTPSA id z1sm4354302lbw.2.2016.05.21.13.36.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 May 2016 13:36:49 -0700 (PDT)
Subject: Re: [PATCH 0193/1529] Fix typo
To:     Andrea Gelmini <andrea.gelmini@gelma.net>
References: <20160521120120.9981-1-andrea.gelmini@gelma.net>
 <d5911496-4d32-f1a1-92ff-a63b87dff7c0@cogentembedded.com>
Cc:     trivial@kernel.org, ralf@linux-mips.org, macro@imgtec.com,
        paul.burton@imgtec.com, Leonid.Yegoshin@imgtec.com,
        linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <19a7270d-69a2-fbca-7834-a7db9b58f11c@cogentembedded.com>
Date:   Sat, 21 May 2016 23:36:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <d5911496-4d32-f1a1-92ff-a63b87dff7c0@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53603
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

On 5/21/2016 11:27 PM, Sergei Shtylyov wrote:

>> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
>> ---
>>  arch/mips/kernel/mips-r2-to-r6-emul.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c
>> b/arch/mips/kernel/mips-r2-to-r6-emul.c
>> index 625ee77..edfa845 100644
>> --- a/arch/mips/kernel/mips-r2-to-r6-emul.c
>> +++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
>> @@ -2202,7 +2202,7 @@ fpu_emul:
>>      }
>>
>>      /*
>> -     * Lets not return to userland just yet. It's constly and
>> +     * Lets not return to userland just yet. It's costly  and

>    Let's?

    Oh, and remove the double space please.

MBR, Sergei
