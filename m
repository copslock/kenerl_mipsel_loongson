Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2018 00:45:32 +0200 (CEST)
Received: from mail-pl0-x241.google.com ([IPv6:2607:f8b0:400e:c01::241]:45190
        "EHLO mail-pl0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993856AbeDCWpZMGOmy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2018 00:45:25 +0200
Received: by mail-pl0-x241.google.com with SMTP id v18-v6so9161406ply.12
        for <linux-mips@linux-mips.org>; Tue, 03 Apr 2018 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+IcK4JzFElj4IiNXGjW+USB6bBom/3BvoZmUu9Ql7OY=;
        b=AMvymfhtmUcWkOhb4WLX0G/84ns0+hjKvX6u2io6bH9XGa9gnI2xqSsIZkdOymrrWM
         yCfwmMFQxyvn+rb228CJyj97CgDfS6ripbf0ASVSDkxSGsyZFKSpmvIIJP2odrciwdWM
         EckwPeKu61OS6Q+5rD6uZdfV1Xev9s5O56PEag1y2eD9ZXEGxNcA/WdzifRnmzaMVv2M
         Nh9eYDPyR9cqyrEfShmFrWI4TiEIcbpmc4Sdr7viiFFxpPJZo4HPkw9YLAkW/BCWzSTl
         panauUDM3hPMGrztBpwYOeh1AxAAlkISUWrPH+sQ6mDRqHq44XkbpDbO4w2OFgrfcv2A
         238g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+IcK4JzFElj4IiNXGjW+USB6bBom/3BvoZmUu9Ql7OY=;
        b=muUMA+cUvHLDaqPgN5Qy1QQQjJ+rADKn/zhsholdGfKtS0b6CmjxHRUvSd+ZRzsbAO
         H7TGtbIoQ0oIl0N7/d3k9WEQ25YaWGE+zms0RIbkB6eyANUw1aUnC289hC5bJQg+23x5
         z6OUqBqwLyeuvkKVBpS4vucy/Ak1IjUp4ArbkLrelFebOCgHrc9E00iILRnKJ4IX3twi
         StmDMBpbfbmqLrpe3o4c4DPlapX/NCp89V5Ut0KfLaRjjy6B4rTQ1apozSqCqfNiKazw
         X/KbCyeB6t8rt4a5R95PVwXAh98ZYxFp9gFaoaaNmj5SSy/J5Bj5jlKBqGRGi2w6y2mo
         FCmQ==
X-Gm-Message-State: AElRT7EMP1VXw9Xr2WGafkm/c6Fj8k4qzX2344lN6wsAjgXr7Er5s/0y
        q6duUVOXv20GF/zxVjO6RkKcUg==
X-Google-Smtp-Source: AIpwx4/aIqMk+MZM+RHC02oH+Du0Apu8VDkHgUV3ONKc91FRlaRY54Y7Xpgryyt9+N5qsEPvaBIyPA==
X-Received: by 2002:a17:902:2d01:: with SMTP id o1-v6mr15673196plb.309.1522795519127;
        Tue, 03 Apr 2018 15:45:19 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 13sm7493139pfm.10.2018.04.03.15.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 15:45:18 -0700 (PDT)
Date:   Tue, 03 Apr 2018 15:45:18 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Apr 2018 15:44:57 PDT (-0700)
Subject:     Re: [PATCH v4 1/3] Add notrace to lib/ucmpdi2.c
In-Reply-To: <20180403144544.GA3275@saruman>
CC:     matt.redfearn@mips.com, antonynpavlov@gmail.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     jhogan@kernel.org
Message-ID: <mhng-0ca80fed-0881-48ef-8d61-3b104f48ecae@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@sifive.com
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

On Tue, 03 Apr 2018 07:45:45 PDT (-0700), jhogan@kernel.org wrote:
> On Tue, Apr 03, 2018 at 02:51:06PM +0100, Matt Redfearn wrote:
>> On 29/03/18 22:59, Palmer Dabbelt wrote:
>> > Ah, thanks, I think I must have forgotten about this.  I assume these 
>> > three are going through your tree?
>> 
>> Yeah I think that's the plan - James will need your ack to patch 2 if 
>> that's ok.
>
> Yeh, I've applied v5 for 4.17 with Palmer's reviewed-by, but I'll change
> to an ack if thats okay with Palmer.
>

Either way is OK for me.
