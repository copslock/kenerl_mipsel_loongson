Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2018 13:19:19 +0200 (CEST)
Received: from mail-lf0-x22d.google.com ([IPv6:2a00:1450:4010:c07::22d]:35758
        "EHLO mail-lf0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbeFMLTN0Vw0l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2018 13:19:13 +0200
Received: by mail-lf0-x22d.google.com with SMTP id i15-v6so3337988lfc.2
        for <linux-mips@linux-mips.org>; Wed, 13 Jun 2018 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=x5pq6mtAGm/tikYlXHRhXwV0T88lEBHd9mNQJujUnjQ=;
        b=YzIcAk0LiCKBZt68AknMLT3meUzPlzhqtvyw/DYRC9bH9x37a5tcYm8wplUvdQs8Jt
         U8gPtV9Ka6EZQAzqMh9IuLLYI4UgrRZ0R8usvfwlp0m6LXvpIlJ1E9XVcEk0xs/RDuOy
         Xs2FUgHOyLlIl+5zmstDJCW02e4BW3sAZewMje/NFIcxBdlswynHsaDX1VPC5gbTw9mX
         0t+7JxZzXl+d5zzYfjaPBy/z+fNipBPkB344zLv88xTeD8AGTsb6m1PoPaVHZ6nOyvYm
         9UJsSn2uBw/Kph5tq4che7xFxDdcFGgQh60CS2OqrYC13bOJLN2nkDtTdF7z/kVbY2dW
         H7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=x5pq6mtAGm/tikYlXHRhXwV0T88lEBHd9mNQJujUnjQ=;
        b=MyccKeMs8bsBcE3Bqm2SNmtZjsA0key6ndi+OWKy8+pwAj5P5pLVdoK47Ysqx8xP0U
         socTCSnzLHm1wjQXGTzPFAyuMhopIN0YvFgTD72pgnhfo1Oz8hgaP20f4L/leteeBB22
         ra4gNfY1YgDj9DchFjUgCgznM31Gc9YZKp1AedQz+lRxEVfDbJH+QtN4Sb2AHIUX44UR
         9SwO40kpyN3H8vUBr9MXdsjMRkS2HpSi8o+TExJSv6D7P29Lt0HMLVwqVqMW4Rocc/D9
         ACLoYoxrSsKlmyIHVv05a9+YIcLSIziorz9UX2FW9xJ5l+ew5yixWtEKEGpP3r3kO5A9
         SuxQ==
X-Gm-Message-State: APt69E0YHVsLa3lkoEUHWODkA0bF0WZkbAwZYrFbWsuAuoCkdwQQ3A0B
        /H6pOsNasWvJ3kYSYQ/SYa0D/m1k
X-Google-Smtp-Source: ADUXVKKeBsRo+oYvUar4hZEGZxmAMpcC2Kx1m4ERHpaAjTTl0MmBtyVEnRf/JqdW9f6ouFLF1E0nJQ==
X-Received: by 2002:a2e:8184:: with SMTP id e4-v6mr2929527ljg.93.1528888747473;
        Wed, 13 Jun 2018 04:19:07 -0700 (PDT)
Received: from upc8.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id u24-v6sm495165ljj.96.2018.06.13.04.19.06
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 04:19:06 -0700 (PDT)
To:     linux-mips@linux-mips.org
From:   Yuri Frolov <crashing.kernel@gmail.com>
Subject: [vmlinuz.bin] Does u-boot support loading vmlinuz[.bin]?
Message-ID: <90a06531-2663-3982-962d-ff8025ee4388@gmail.com>
Date:   Wed, 13 Jun 2018 14:19:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <crashing.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64253
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

Hi,

do I understand correctly, that the native format for mips arch. u-boot uses is uImage?
Yocto's default for mips is vmlinuz.bin for some reason, here is the question.
