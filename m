Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2012 20:23:56 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35521 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903439Ab2IXSXu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2012 20:23:50 +0200
Received: by padbi5 with SMTP id bi5so1656739pad.36
        for <multiple recipients>; Mon, 24 Sep 2012 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=DZlv4501ZD/mVzPylBgmcikrAMI+bbLtQ+j9+Y51m94=;
        b=MFBvozTcuR7hW9OvX0MZq2yZ8KBOXWvzJ+xNOGwoRLUtdEpHLcNjb0P5uzQl9NYi8p
         5RocUsP6/9Kq+znJlbELTBW3Xlbw5KPIZpDNh7oZLdIMyCSLeze/S72EHMFTPW/mwk/x
         9Zsi7x7lVO/xu5iONPLDZptQaEcfvT9bVEfzAb321XE9A2/9bNAZk1mU4oDnITBPcvfh
         uVqDfOR5EFBHaF2CzIeSZFfO0WXsxBffnjjL44F+5y2lq6vBrPEk9DGs+kYcYU5ia29F
         3ZuKNqXTXdXzG4flY2z/z6395f2l7Q9OCCHvE43MTu84AhRHYsoxmO3elfmVJ0z0c1Wz
         Vrjw==
Received: by 10.68.190.197 with SMTP id gs5mr39595457pbc.124.1348511023601;
        Mon, 24 Sep 2012 11:23:43 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ky6sm5223472pbc.18.2012.09.24.11.23.41
        (version=SSLv3 cipher=OTHER);
        Mon, 24 Sep 2012 11:23:42 -0700 (PDT)
Message-ID: <5060A52C.1050504@gmail.com>
Date:   Mon, 24 Sep 2012 11:23:40 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-next@vger.kernel.org
Subject: Re: [PATCH -next] MIPS: ptrace: Add missing #include <asm/syscall.h>
References: <1347913216-11140-1-git-send-email-geert@linux-m68k.org> <20120923173609.GE13842@linux-mips.org>
In-Reply-To: <20120923173609.GE13842@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 34546
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/23/2012 10:36 AM, Ralf Baechle wrote:
> On Mon, Sep 17, 2012 at 10:20:16PM +0200, Geert Uytterhoeven wrote:
>
>> arch/mips/kernel/ptrace.c: In function ‘syscall_trace_enter’:
>> arch/mips/kernel/ptrace.c:664: error: implicit declaration of function ‘__syscall_get_arch’
>> make[2]: *** [arch/mips/kernel/ptrace.o] Error 1
>
> Thanks, I already had fixed that in the linux-trace tree; the latest
> version just had not yet propagated yet to the other trees.
>

It is still not on mips-for-linux-next.  Perhaps we should arrange for 
it to be there, so that the actual propagation may commence.

David Daney
