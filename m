Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2015 09:43:04 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36160 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007638AbbIWHnDXgzyQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Sep 2015 09:43:03 +0200
Received: by pablk4 with SMTP id lk4so2222615pab.3;
        Wed, 23 Sep 2015 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9kFTWC7rd7NVBVTYzQLxS6oeAcg8BicS/6aAlRY3wP8=;
        b=D93D+SpD4w206mHJI5+szGR+sZCNLYBvohxEraiNKjNHCP0K2wky6dIixgxv2uFlpb
         uyGqTPmHG+FEvSYqUmBd/JKRHNWrGtJUopC8A4UHbFR9Mj8PFyAyDO2cIfwuCeIwC8GR
         VbCMkT7guaF+szoliClDLuxZ8PTsb7U8USw7chacxgZqyqhmZEKUeIlKdBM/51ZfRnEg
         iJNyGfSIC4x/yQIbbgSBO139sy1xCdN3LXFQIn8CeRkjKcj5MJRNgEqXfA21z5dTJtlR
         +VKwpkRiAnWTskOkClR3Qt8UBgQUfn/p65G8N8mpE7Y8nL+v9TdulfTTYYNILdq5IxLo
         3IlA==
X-Received: by 10.66.100.168 with SMTP id ez8mr35922297pab.142.1442994177109;
        Wed, 23 Sep 2015 00:42:57 -0700 (PDT)
Received: from sudip-pc ([49.206.240.178])
        by smtp.gmail.com with ESMTPSA id gq7sm6269433pac.5.2015.09.23.00.42.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 23 Sep 2015 00:42:56 -0700 (PDT)
Date:   Wed, 23 Sep 2015 13:12:08 +0530
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: linux-next: Tree for Sep 23
Message-ID: <20150923074207.GA27002@sudip-pc>
References: <20150923142343.35797c0f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150923142343.35797c0f@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49336
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

On Wed, Sep 23, 2015 at 02:23:43PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20150922:
mips allmodconfig failed with the error:
No rule to make target 'arch/mips/mm/sc-debugfs.o', needed by 'arch/mips/mm/built-in.o'

caused by:
13ea0032658d ("MIPS: Allow L2 prefetch to be configured via debugfs")

regards
sudip
