Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 11:01:20 +0100 (CET)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:44358 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832210Ab3AXKBTDuKp- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2013 11:01:19 +0100
Received: by mail-lb0-f172.google.com with SMTP id n8so5159636lbj.3
        for <linux-mips@linux-mips.org>; Thu, 24 Jan 2013 02:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=abYCbYMxIwGVbjgQ6RShZVwcdmZizzWPrOm+FRap0wc=;
        b=nycSO4GcVX8DX+B3EYFOt7OXNImJhuEL7S75z5n8RkqurGpQhfO5byEEtXBRA7XJVa
         pX/VQ3ZiYouIV4ZhQmXztTP9seAxA1JVAF1kU0r+MbUSev9cn2V7+rj91DUlCJxceroT
         o60Ehx9uIeEUfWtj9gV1ReI35L/sUAcR5qmKrvWgKsrRR51Q0VfI9NPtZ6fLOvfYoR1J
         a7i00w4UcNMc0S6llkiS6Vps0GH1EfdU4U2fHNiQkmU9UVneIwMYkLSBwR+9SyTR+sWN
         QtLURRLesbAiozEhcm4v9WweBBzjpBx5s/31qV7alRDBaaglQ6hSySPrfpFB2zAI2Q7A
         +EKw==
X-Received: by 10.112.28.105 with SMTP id a9mr533904lbh.66.1359021673437;
        Thu, 24 Jan 2013 02:01:13 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id fh4sm9369464lbb.7.2013.01.24.02.01.12
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 02:01:12 -0800 (PST)
Message-ID: <510105C4.9030403@openwrt.org>
Date:   Thu, 24 Jan 2013 10:58:28 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [RFC 08/11] MIPS: ralink: adds early_printk support
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-9-git-send-email-blogic@openwrt.org> <5100610A.80609@mvista.com> <5100DB68.20903@phrozen.org> <5100E183.5080801@phrozen.org> <5100E1E7.8010409@phrozen.org>
In-Reply-To: <5100E1E7.8010409@phrozen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

On 01/24/2013 08:25 AM, John Crispin wrote:
> brainfart ... its too early :-)
>
>
>> while our driver needs
>>
>> +#define UART_REG_LCR 5
>>
> should read ....
>
> #define UART_REG_LSR            7

Ok, I did not see the registers have different offsets compared to a 
traditional 8250 UART, makes sense then.
--
Florian
