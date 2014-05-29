Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 21:38:44 +0200 (CEST)
Received: from mail-we0-f173.google.com ([74.125.82.173]:37586 "EHLO
        mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822268AbaE2TikitBZ9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 21:38:40 +0200
Received: by mail-we0-f173.google.com with SMTP id u57so938678wes.18
        for <multiple recipients>; Thu, 29 May 2014 12:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=nZUYtiLgP5TVzkwcUQV5Zk67TVh4SdzB8DHzTSnFEJE=;
        b=NcZ7mtKtkSo0Q1pmNTJN3LlnCcGiwXCesuwBfWRDLIcsVVYJlBOOuI/1os2fAnyH6G
         c/9MtcmkJUyQ9Z8LKE5hQCU2VR0CX+yfugIsNzsHid6ERP19g/mZ9miGYaDk8tJ8BGkU
         /E/CMWTRHTLrgbGlbMKwCwL0t//VFFWd1nQn2AVVCrQ+3iclU/f2RUHEXMxranrLLPqq
         UOyxr3B64k2GHlhfqoERIghwA394i6OcPHJirZvdUD/7S0UIZqtLPovX51GJagWNEY2p
         29g98ksd4Z+8otUQ2w1aBa/4nyT1DS6ZTGX2HzhCxa2DTaeB14KzajgceY584LAnLryT
         B/VA==
X-Received: by 10.180.211.36 with SMTP id mz4mr63216008wic.20.1401392315248;
        Thu, 29 May 2014 12:38:35 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-117-132-7.cust.vodafonedsl.it. [37.117.132.7])
        by mx.google.com with ESMTPSA id vm8sm4016187wjc.27.2014.05.29.12.38.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 May 2014 12:38:33 -0700 (PDT)
Message-ID: <53878CB5.6070202@redhat.com>
Date:   Thu, 29 May 2014 21:38:29 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
CC:     gleb@kernel.org, kvm@vger.kernel.org, sanjayl@kymasys.com,
        james.hogan@imgtec.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: KVM: remove the stale memory alias support function
 unalias_gfn
References: <1401390742-3550-1-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1401390742-3550-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

Il 29/05/2014 21:12, Deng-Cheng Zhu ha scritto:
> kvm_mips.c | 5 -----
>  1 file changed

Applied, thanks.

paolo
