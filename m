Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Oct 2013 00:07:10 +0200 (CEST)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:40826 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822305Ab3JKWHIKxzz7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Oct 2013 00:07:08 +0200
Received: by mail-ie0-f181.google.com with SMTP id tp5so9383018ieb.40
        for <multiple recipients>; Fri, 11 Oct 2013 15:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=F6ZarSfOMrr+muZwHtWnAUmKsxTDUDLnRHo7fb8EGP0=;
        b=cu1RF3jnNNhlFZxsRJBhj2ezBG7Pvn4lAcwXg2HBRyxTo4J2pfyJhJHjKjG9bkWBZM
         RqbUNmvMitSbcUEECePG5jQsUgrlbWj5+tIUNMGS8zl8YP9/fW4SvKSh1cmuLK+bB2sf
         5J+aGs0wrZRX/X+Ug+cbGRQ34hQijbzWF8fTC2uPPsCXKi1TRxUSnajrhwD0NckCfb9K
         kJpYsUlqQt1/fI5/E7TaIy2xKZHiaMDyjIAI0ACpwtOlHmk3LEQeDoqcpj0VVwRj6QBA
         Nr5twPDffyI/A2fSCtzvBVjP6EaNHgBFQSgxYVKjUaFbtJNKTxTjXzeQD+XXzu8oTzdC
         SoKQ==
X-Received: by 10.43.77.212 with SMTP id zj20mr12948632icb.5.1381529221547;
        Fri, 11 Oct 2013 15:07:01 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id p5sm5050192igj.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 15:07:00 -0700 (PDT)
Message-ID: <52587681.8090703@gmail.com>
Date:   Fri, 11 Oct 2013 15:06:57 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Anton Arapov <anton@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] UPROBES: Remove useless __weak attribute
References: <20131009120809.GN1615@linux-mips.org> <20131011005128.GA2199@linux.vnet.ibm.com> <20131011122407.GO1615@linux-mips.org>
In-Reply-To: <20131011122407.GO1615@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/11/2013 05:24 AM, Ralf Baechle wrote:
> On Fri, Oct 11, 2013 at 06:21:28AM +0530, Srikar Dronamraju wrote:
>
>> Will be nice to have another arch(mips) support for uprobes.
>
> It's basically ready to be merged - but it's triggering issues elsewhere
> in the kernel which I have to resolve first.
>
> The short version is that the memory special mapping created by uprobe
> with VM_EXEC but not VM_READ permissions is not working but it's working
> if I add VM_READ.  That should not be necessary so something deep down
> in the guts of arch/mips is wrong.
>

Weird, I have a testcase that explicitly tests VM_EXEC and !VM_READ that 
works.

Do you have more information about the failure, I can look at it in the 
simulator and see where it goes wrong.

Thanks,
David Daney
