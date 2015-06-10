Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 18:36:55 +0200 (CEST)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33812 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008014AbbFJQgyLiDd4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jun 2015 18:36:54 +0200
Received: by wgv5 with SMTP id 5so40090687wgv.1;
        Wed, 10 Jun 2015 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=5MgrV9MH6qvZVltvsgdbe2hOcAl7nFcLnFhVx8PQZj8=;
        b=sDDe3WKmjm9/Ys01doQt/AFfpR9rr5OtMmcfBjPBTdFgxZHq/nxlp+d3b/zyVpDru/
         0j/5iUcSNlXHcbK3krYrLs1V/8F2clCBrbgVFVG2UyRn2WBDu0kcrUs59Z9GX0KP4zFT
         Pka/cQdZzMe+9syqwbuL6htscgKq0wG6bzJTQYPjhw2Gad+IkfqE3GtPYkwlUq1bgW5A
         UDzKCTwPKtOV9mSW5ckjxsEaJiVkd5HIQXRahhaQFJc9Pn/A5UUxLGGBQrSBgflW7lD4
         XchpPT64aO4BLBNXlzfoDD+w8lZBf553WguiMfgM6gqSHn0u9ntFgCQYz4B+bX8dALWX
         R1HA==
X-Received: by 10.194.157.168 with SMTP id wn8mr7551974wjb.79.1433954209014;
        Wed, 10 Jun 2015 09:36:49 -0700 (PDT)
Received: from localhost ([47.60.122.142])
        by mx.google.com with ESMTPSA id nb9sm8713700wic.10.2015.06.10.09.36.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2015 09:36:48 -0700 (PDT)
Message-ID: <5578679D.2030307@gmail.com>
Date:   Wed, 10 Jun 2015 18:36:45 +0200
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, Ingo Molnar <mingo@kernel.org>,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Generic kernel features that need architecture(mips) support
References: <55759543.1010408@gmail.com> <20150610145804.GG2753@linux-mips.org>
In-Reply-To: <20150610145804.GG2753@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <xose.vazquez@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xose.vazquez@gmail.com
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

On 06/10/2015 04:58 PM, Ralf Baechle wrote:

> How are the documentation files in Documentation/features/ maintained?
> They were automatically generated so I wonder if I have to take care
> of anything.

CC: Ingo and related ml.
