Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2018 18:28:59 +0200 (CEST)
Received: from mail-lf0-x230.google.com ([IPv6:2a00:1450:4010:c07::230]:32809
        "EHLO mail-lf0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993634AbeFMQ2wlhoy5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2018 18:28:52 +0200
Received: by mail-lf0-x230.google.com with SMTP id y20-v6so4927947lfy.0
        for <linux-mips@linux-mips.org>; Wed, 13 Jun 2018 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZR6vhLlWA7hRbXqn1/D9EyOHbsVtA0ZiIKn55dYzErU=;
        b=VqsIuVKxXUcufH0FrBpVLrRAwcGkEDwMS49W5epGISlSwUh7cC6S4ol5+s04k3y7O2
         Hrm+84W0dqvxOY6fbp55IiNV+QWFIauqvgBC0pOM+gQ1BeTsYQyUztNoN9j2fkU69R3j
         jBeiXmlfKlddYplk2ShRduXxRgloVyPk1CXf+iEy6GbaouxZUMRrsxKmmw2rGPF8vTIb
         zR3a8qfs1IcU+fMXGTuLOBDhpSR+cCbD7mRqCS7TtF3TOSi8TrbfR4JWnq5bCMzmLjzu
         Q8FG863hu7yKQMakiawXiCJhw6pdRl1edVk090SQJiHxwKvY+u6yVfqj1wVjvtBwRmZ4
         Hd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZR6vhLlWA7hRbXqn1/D9EyOHbsVtA0ZiIKn55dYzErU=;
        b=IueXzW8IfbHGaQt7U12nMsSRP8ZA2UZoCBINRUvsfFo9KlY78vOeapMvIv+nuWWlF1
         LyrrAnMzwACReTYkgxT62UtTC850mqQ6LVPm+RxIR2ebhLfbXBK9ppcuDuXFVoGnzRd5
         z3RYpUjol8Wg9xwf7+wuyWGsbg8MQ5C6CJWER2JJk7iP0iB7FZqRjjBRTti1LQvfdm9U
         Xh+SuVRT6Wz8a9DOzD97EUDP6fWXGuVZ3opSzBHI93QJFF3Ko4AH3gZ7eFpLJSsPsEI0
         9dUmzk7ghrCf0xHpfDrlEkGLbSeVGmGuZEAviRlHz/slJMOKaZcWHyflJS4NhKXhbgm8
         d/Nw==
X-Gm-Message-State: APt69E2CAE3sK5/p6OPIvMZB6nv4ap2LSb/7KVeZwdeuYxAVL4sATYj9
        SlNwmBVuEvYc7cdYf6YhkZ7Si/g4
X-Google-Smtp-Source: ADUXVKKYe6/mEVQHD/A0AibvlPti7s3Z/925IKoYS3lvKyo6YmA/Jy6qOWBuJpeniVdNyiHYMEubMw==
X-Received: by 2002:a2e:804c:: with SMTP id p12-v6mr3624495ljg.22.1528907326339;
        Wed, 13 Jun 2018 09:28:46 -0700 (PDT)
Received: from upc8.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id w4-v6sm588856ljj.58.2018.06.13.09.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 09:28:45 -0700 (PDT)
Subject: Re: [vmlinuz.bin] Does u-boot support loading vmlinuz[.bin]?
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-mips@linux-mips.org
References: <90a06531-2663-3982-962d-ff8025ee4388@gmail.com>
 <20180613153510.GB31768@makrotopia.org>
From:   Yuri Frolov <crashing.kernel@gmail.com>
Message-ID: <2cfa098d-46f4-b4b2-10f9-e447b89c7fda@gmail.com>
Date:   Wed, 13 Jun 2018 19:28:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180613153510.GB31768@makrotopia.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <crashing.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: crashing.kernel@gmail.com
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



On 06/13/2018 06:35 PM, Daniel Golle wrote:
> Hi Yuri,
> 
> On Wed, Jun 13, 2018 at 02:19:06PM +0300, Yuri Frolov wrote:
>> Hi,
>>
>> do I understand correctly, that the native format for mips arch. u-boot uses is uImage?
>> Yocto's default for mips is vmlinuz.bin for some reason, here is the question.
>>
> 
> You got to enable U-Boot's CONFIG_CMD_BOOTZ and use the bootz command
> in order to boot that. Or change that default to generate FIT or legacy
> uImage instead.
> 

bootz_setup is properly defined only for arm (arch/arm/lib/zimage.c); default bootz_setup returns an error.
So, is bootz supposed to work for architectures other than arm?
