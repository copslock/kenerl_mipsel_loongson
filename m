Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Dec 2017 12:18:39 +0100 (CET)
Received: from mail-lf0-x22b.google.com ([IPv6:2a00:1450:4010:c07::22b]:35481
        "EHLO mail-lf0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbdLVLSdeh8hE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Dec 2017 12:18:33 +0100
Received: by mail-lf0-x22b.google.com with SMTP id j124so31154971lfg.2
        for <linux-mips@linux-mips.org>; Fri, 22 Dec 2017 03:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4C82aFSggH5Ta92LueouW6V9XGTDZSeK0CeCRuC0cho=;
        b=uBHCv0KdcqySOPxKl9VPA4Xl1zq1XgPAxLFZCgO5Q8YqWKbzXEcEtq4adhEZnJoDDF
         Hv06gs3cA+OoxHUJON4TiLC85rzOKqe/GFMzD6khzKOvVpHfwdAXYjPgn+pfuZ0fo5kd
         o+SoF+geICar06YAc93xogX5wB/S4b6V803+PdFJb8slGnCgcc8J6EQ/rIwnpIq/PMU1
         kQJjAusZYlTQJhKvNJHCEBSvOX4/meEAP9Lo9zfD+fKADyFkjN0QoHckYaVTD5uXsYGe
         5b2+ulRE4Iid2JLRCLAJG4vC9uLeLCZ+PukO8bIZ6Cx/NPjSpkVOkVdw0vB4b1fzmVFa
         138Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4C82aFSggH5Ta92LueouW6V9XGTDZSeK0CeCRuC0cho=;
        b=GbyW86QepuSdoxlNYqrCMvtxFECsUl+mppgPDv1PLGiENK+qH4e1xpuPe0zoyjfasr
         8R+DtE6ZYRQ1UjsvoFuUUwYWrG/sq4A/8vmh5Kfza/46rYKnWEou47lgJ7vPxFxfLHjX
         23R7lc67itpBkDXm3BkJXBTTMGa6ETFqqzGLnnONwL4asAajlUz6B5ionkSVWPzcQAGp
         cX+1L1UoLmd+L9cXzhZVFijlDnezMQ88FEJqYUCMMYWSlvfTNsfb/LOfLbInN2HU9ry1
         ySPwdT40uJkPfatWbBtCSlNSJEFzEE74umURjeBOMlj0Uz0ZDmhalflhS1MoUEAg68cg
         s0cw==
X-Gm-Message-State: AKGB3mILhZVnitdAZaL0pt3QUW8jgZIlCCyFLBXlMiiM94vk6aG2mQwr
        t+jYi8jL53wC1mXnY9XO1JE=
X-Google-Smtp-Source: ACJfBosLe0RufHdY9wnLPo7EJ/DktEfS1QNz9MI4lSC80VZtVB8WBhp8sDKvP+0AeRma+1pJ5mKVkA==
X-Received: by 10.25.20.166 with SMTP id 38mr8737001lfu.112.1513941507975;
        Fri, 22 Dec 2017 03:18:27 -0800 (PST)
Received: from upc8.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id p89sm4494137ljp.33.2017.12.22.03.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2017 03:18:27 -0800 (PST)
Subject: Re: [P5600 && EVA memory caching question] PCI region
To:     James Hogan <james.hogan@mips.com>
Cc:     linux-mips@linux-mips.org, paul.burton@mips.com
References: <6132c323-32a7-1d38-b77c-a191be22faa4@gmail.com>
 <20171206114611.GM5027@jhogan-linux.mipstec.com>
 <330a5200-531f-fcfa-674a-c81fb3144e92@gmail.com>
 <20171214152138.GV5027@jhogan-linux.mipstec.com>
 <ca9adcbc-9777-46a0-ce0b-15e83e01fc72@gmail.com>
 <20171215232821.GA5027@jhogan-linux.mipstec.com>
 <b8706fae-aea8-99b5-f91d-37690eff6949@gmail.com>
 <20171221134119.GE5027@jhogan-linux.mipstec.com>
From:   Yuri Frolov <crashing.kernel@gmail.com>
Message-ID: <d4198e82-5658-1bce-8415-cfc9dee56336@gmail.com>
Date:   Fri, 22 Dec 2017 14:18:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171221134119.GE5027@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <crashing.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61556
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

Sorry, I forgot to ask,
> yes, the Malta implementation is slightly ugly as it relies on a
> hardware physical memory alias of RAM starting at PA 0x80000000.
any good docs about this hardware aliasing? I'm not sure I understand it 
correctly, just want to understand things right.

-- yuri
