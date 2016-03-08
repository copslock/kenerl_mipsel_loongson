Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2016 19:38:56 +0100 (CET)
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35087 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008041AbcCHSiy1hPj0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Mar 2016 19:38:54 +0100
Received: by mail-pf0-f176.google.com with SMTP id x188so18711128pfb.2;
        Tue, 08 Mar 2016 10:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ceazBs/ioczryJruVp9GEMVJsHQjV+RDvhtxtItX+3M=;
        b=JrDAaiPuuQI8LePporueKKo/TTL0APkhhwvZApTpJmXhDoPIkk++WU7LvZFloiy6Mj
         1ox2PHAInNuioPnKKffBNZzjxS42zYrwhKBlF1Ef35bWKRAYr77HCujzPQ+1kFF8Oj/q
         f0oR5D1Fr9EXbWLiBLEi0piJTir5qOyZ2ssUEcpPDmCsTSBbT9QmbS4lScuQOdcMHykU
         sq4qeNg+t7XQMaeskUBvOW88Cdb4YT7J8FT4LClr5Hs8T8z/C8HaCWkVld828tICHJ4M
         MHIGJLhLooqGLkzqts9uGWNvno3zYQrOkJlmv3R0Xf4c74l/KaZfJjVwPyV1BbIeM5JD
         rHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ceazBs/ioczryJruVp9GEMVJsHQjV+RDvhtxtItX+3M=;
        b=fO3tjaMv8kLbhEon3B6jlDDxQG9uOKgJD5+sGcnIZK56Nx+vf+cQJP6GdMh41so2kd
         Pex7UAwBrC+wWK82ftY9dxs/BHPTOl9INpE/yYInH48BS9ouLn2S+yfAQ6u/No5Zy0hj
         ZBFog55oj5XYB+bzczASEouT0zByh53GUJIzCdZQj8REXNQbxy+Z/RGr9EsAax6eeTXX
         MssPgUr46c3SbvOJvCxLTHBn7p+z6WZ+T+HWzU+BXL4tGwn/2giCveUXWE/LqnT709EV
         GDo5Nt6B+hfzfAV1eVuUzJrGZZ7luZwARAtiVq8yDzaJ5TKkybBAnDoPYWHhCpzHRukh
         BRPg==
X-Gm-Message-State: AD7BkJICUGRhd5swSSPBAwpTILb3uqzP+K7DyL4tvGiNBmCNUvQnjxqAE3psYdXrHHqCZA==
X-Received: by 10.98.8.219 with SMTP id 88mr44066376pfi.51.1457462328695;
        Tue, 08 Mar 2016 10:38:48 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id ml5sm6662434pab.2.2016.03.08.10.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2016 10:38:47 -0800 (PST)
Subject: Re: [PATCH v2 03/15] MIPS: PCI: Compatibility with ARM-like PCI host
 drivers
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
 <1454499045-5020-4-git-send-email-paul.burton@imgtec.com>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        Yijing Wang <wangyijing@huawei.com>,
        John Crispin <blogic@openwrt.org>,
        Yinghai Lu <yinghai@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56DF1BDD.3070800@gmail.com>
Date:   Tue, 8 Mar 2016 10:37:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1454499045-5020-4-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 03/02/16 03:30, Paul Burton wrote:
> Introduce support for struct hw_pci & the associated pci_common_init_dev
> function as used by the PCI drivers written for ARM platforms under
> drivers/pci. This is in preparation for reusing the xilinx-pcie driver
> on the MIPS Boston board.
> 
> Platforms that make use of this more generic code will need to select
> CONFIG_MIPS_GENERIC_PCI. Platforms which don't will continue to work as
> they have, with the intent that PCI drivers be migrated towards struct
> hw_pci & drivers/pci/ over time.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

FWIW , with a out of tree (for now) PCIE RC driver written with ARM PCI
setup in mind, and this worked like a charm, thanks!
-- 
Florian
