Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 13:33:10 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33463 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027028AbcDSLdIDKilI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 13:33:08 +0200
Received: by mail-pa0-f47.google.com with SMTP id zm5so5989625pac.0
        for <linux-mips@linux-mips.org>; Tue, 19 Apr 2016 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Tlen3K4y/0uoIaica2V7tIJ/oboVl4kmhwsgZ+/35Z8=;
        b=JlIvsacZv7jT/VrfCxQqbmEVch66QKY9dMLlgM4Rl86BC9W4Ys16EfaFDnRAY1tg8V
         ja3QW6VduLg0eMfkYA9CMWzEpZVGALAEFlO250LeL/tPwdHcg2IYDuD7RDMPukX5yBXR
         1+CM26UsETdOxHXtUMKH+YC8pvc4qEgmjLXkJka/qI5EKQslcpmwHo7Ao60K9z0VTVyx
         sPbUwhz2E96sm0z+3DzoWDA5CKxHUmjQ9O8Wk1FtPWaPohhy3fx/Me1cFg0UdOJ/N91L
         VTi/bwMXBib9YiOJ+JMbIOqy1FPA4NTIahVVbXY9gJkqxrKjm5FnlcD/0vabXTqLuczx
         T9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Tlen3K4y/0uoIaica2V7tIJ/oboVl4kmhwsgZ+/35Z8=;
        b=i3gromaBaWttttU55j3Knn4g1SWMsDrNHg1k+BAkznDl9vs6yoACopM7Cp0dLglsId
         8942alPXEpLJCpmlvW18GG8jvzdepTIXP1sdg9sHdS/vJOTqvAL99wB01QDD1NnvC/9d
         bLLLI4WX5NqDRNYInJJzOE07x90tCJfHLWPa5BSNSfS9b7ChYLr1qTsWbYMrIZNYqWcM
         pn7KkA4KKjvGdZP4kwItlTtLKNY92lzRj8n8WC/Lv+62++fIY3+9t0u5DQT6ZYOiWdhn
         sV+nXwCR8pzEcGR1yhIncS68wRX4jvhkvsVg/+Bvsef1wraUEli8XgZyUj/syc53bujJ
         XbvA==
X-Gm-Message-State: AOPr4FX0IYxJcc/cRyGTRRIiCNUQ6kvn+vfEolSqd2IjHqt3RBAUfPfzUm960cZYD53iDw==
X-Received: by 10.66.72.198 with SMTP id f6mr3382721pav.60.1461065581970;
        Tue, 19 Apr 2016 04:33:01 -0700 (PDT)
Received: from cotter.ozlabs.ibm.com (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id l6sm16567425pfb.12.2016.04.19.04.32.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 04:33:01 -0700 (PDT)
Subject: Re: [PATCH] arch/defconfig: remove CONFIG_RESOURCE_COUNTERS
To:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <146105442758.18940.2792564159961963110.stgit@zurg>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <5716175F.9030001@gmail.com>
Date:   Tue, 19 Apr 2016 21:32:47 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <146105442758.18940.2792564159961963110.stgit@zurg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bsingharora@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bsingharora@gmail.com
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



On 19/04/16 18:27, Konstantin Khlebnikov wrote:
> This option replaced by PAGE_COUNTER which is selected by MEMCG.
> 
> Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>

Acked-by: Balbir Singh <bsingharora@gmail.com>
