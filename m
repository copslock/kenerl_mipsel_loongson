Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2016 23:59:36 +0200 (CEST)
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35017 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27043259AbcFTV7esOhk- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2016 23:59:34 +0200
Received: by mail-lf0-f50.google.com with SMTP id l188so48499553lfe.2;
        Mon, 20 Jun 2016 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=GlExdjKWHRtuSUGXW1OucW21hiV4TcEDwbTNkGQ0xF8=;
        b=blYg+yNBRLa+NEeL/jAM2kV2BZj5ndT9joJVy2JC1C1PWGT/Lo+Dc9qO0V8cScSKM9
         04PZAtlijD7oJHbrUDrTEX+BXIi4A8KrBSlmn7AvP1cZD2wkwdZh29fqjRGym/j3HuR1
         JRmFHhFeiGBrsXTgvAY8NFq+iyv9889DP3CYRJA6mbvcL0QKyXo9ceMEXa3x67RJqcLa
         eCrvqNfPXhhUpy1wd1EySM+hyIh41cGLWfGvyVI5v0/SQK5uJQq82fwoyYc0kGkP6Phb
         RCWrkWrZBj3hJcKu6jaTwoLt2WNj7RLWjBgdm98VCIn7abPwUFyi80/VCnvf96E9o5Z6
         zWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=GlExdjKWHRtuSUGXW1OucW21hiV4TcEDwbTNkGQ0xF8=;
        b=GPAuWr40U8kz8B1jSnAHBORvX9Gjeepxe7LXL7FKM6VvuQUrFq2rmOuludZj/ZymYk
         Iv/lNyu/wsWbWKLdkMRLiNIJKdlL52BmehSpwrC+Uty4uBD293gxWh3ybv9hfl03QXR1
         q0ASJhBrazaxSLaFN7iccQHByVtsJtM5HXf5s9LMkSq/d1HGJxRd/aiQ+LIacY410Jln
         juHbSfJqDedveXRtVALcwePvhbi8YfBOw0O8ejO+HdV2u5JO/lkVBNQsETjkxXoFUSS4
         wYyy8I2XrAUEb8NiAtx1lzYUgT06jznvRN3gu7sV7OKNa/zxp4E987F8kjY11OcqANCD
         XV6g==
X-Gm-Message-State: ALyK8tL+0WPNesGYhed3Mtmk3LlfkDTVkcWEiccHOAJzm93sUv4a9a2L/vla7Miw7K3ASA==
X-Received: by 10.28.184.5 with SMTP id i5mr109156wmf.85.1466459969222;
        Mon, 20 Jun 2016 14:59:29 -0700 (PDT)
Received: from [192.168.0.29] (95f1ff31.skybroadband.com. [149.241.255.49])
        by smtp.gmail.com with ESMTPSA id z14sm64155588wjw.6.2016.06.20.14.59.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Jun 2016 14:59:28 -0700 (PDT)
Message-ID: <57686738.70900@gmail.com>
Date:   Mon, 20 Jun 2016 22:59:20 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org
Subject: Re: linux-next: Tree for Jun 20
References: <20160620160537.3ea30484@canb.auug.org.au>
In-Reply-To: <20160620160537.3ea30484@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

On Monday 20 June 2016 07:05 AM, Stephen Rothwell wrote:
> Hi all,
>
> Changes since 20160617:

I just started trying gcc 6.1.0 for mips and mips allmodconfig is 
failing with the error:

{standard input}: Assembler messages:
{standard input}:147: Error: number (0x9000000080000000) larger than 32 bits

{standard input}:176: Error: number (0x9000000080000000) larger than 32 bits

{standard input}:198: Error: number (0x9000000080000000) larger than 32 bits

make[3]: *** [arch/mips/mm/sc-ip22.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [arch/mips/mm] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [arch/mips] Error 2
make[1]: *** Waiting for unfinished jobs....

build log can be seen at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/138824794

regards
sudip
