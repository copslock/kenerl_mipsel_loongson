Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 17:26:17 +0200 (CEST)
Received: from mail-we0-f173.google.com ([74.125.82.173]:42875 "EHLO
        mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835182Ab3FQP0PfRHfk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jun 2013 17:26:15 +0200
Received: by mail-we0-f173.google.com with SMTP id x54so2474005wes.4
        for <multiple recipients>; Mon, 17 Jun 2013 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=nQjAPr3neGo3q3lX4WwSS1cGopw33utwLu+w78UNLiQ=;
        b=okn5OFH2BNhn0aisZ3TXS0tzErRYYVDxYGiNj85Viy2Lmjx/gA0yFR45Q6JsbJQwd0
         Nuo+OeUucgDZ899icjY29prQXuf1pt3P6qo91NM6PIoD00Kig31xdxtg0VQHJOGvHrkT
         XFdXiL8ny+KLfiGWucC+kyTbos+qLiGcUiK1WRyZc63L9oAGr8MBH7HICucUjMhOhkXA
         hse9g0ymz/+zYgSrY4mKTI9j23xla/M/PxytBZGv+WpQCjCDgFpaFezMipP2u/R4ObbN
         vFVBwCbTrE1K65O7ulH+jfZSE4w4hwXh37b5YldqrgmhH2wfeZfeN0F/l8QmIvqyWzOx
         SQuw==
X-Received: by 10.180.188.141 with SMTP id ga13mr5271453wic.9.1371482770110;
        Mon, 17 Jun 2013 08:26:10 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-116-217-184.cust.dsl.vodafone.it. [37.116.217.184])
        by mx.google.com with ESMTPSA id fv11sm22772352wic.11.2013.06.17.08.26.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 08:26:08 -0700 (PDT)
Message-ID: <51BF2A8C.5020903@redhat.com>
Date:   Mon, 17 Jun 2013 17:26:04 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/2] kvm/mips: ABI fix for 3.10
References: <1370892828-21676-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1370892828-21676-1-git-send-email-ddaney.cavm@gmail.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36953
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

Il 10/06/2013 21:33, David Daney ha scritto:
> From: David Daney <david.daney@cavium.com>
> 
> As requested by Gleb Natapov, we need to define and use KVM_REG_MIPS
> when using the GET_ONE_REG/SET_ONE_REG ioctl.  Since this is part of
> the MIPS kvm support that is new in 3.10, it should be merged before a
> bad ABI leaks out into an 'official' kernel release.
> 
> David Daney (2):
>   kvm: Add definition of KVM_REG_MIPS
>   mips/kvm: Use KVM_REG_MIPS and proper size indicators for *_ONE_REG
> 
>  arch/mips/include/uapi/asm/kvm.h | 81 +++++++++++++++++++--------------------
>  arch/mips/kvm/kvm_mips.c         | 83 ++++++++++++++++++++++++++--------------
>  include/uapi/linux/kvm.h         |  1 +
>  3 files changed, 94 insertions(+), 71 deletions(-)
> 

CCed people probably already know, but anyway: this is already in
Linus's tree (commit af180b81a3f4ea925fae88878f367e676e99bf73).

Paolo
