Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 May 2013 16:43:25 +0200 (CEST)
Received: from mail-qe0-f47.google.com ([209.85.128.47]:50534 "EHLO
        mail-qe0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834882Ab3E1OnU2e0kk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 May 2013 16:43:20 +0200
Received: by mail-qe0-f47.google.com with SMTP id f6so3469593qej.34
        for <multiple recipients>; Tue, 28 May 2013 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=nwRu8IXuna+n2TU2Qd8Pr0OKR6G9tWMSMa0flvnYQ0c=;
        b=xNeUmAqFolLyfv4iiG1olMMaZ9zzylgFLtlUbTbHvi8L6MyzTiSVEXg4QOd2RtAKtW
         44kVJOUFQJ/lc4pQIljp2MnJSkTbGOCREKeZ/FzzA1ig7NFQabiMUHhB1EEtgvJLlcGK
         K2Gz7PrkZ3fgJqqjrUo7/ZdcC2gm6GI5c9dOPozVOmUhCcyfwyFbKTAdII45pae3z2zx
         6mHQQZb/oqfsu9eBiT+JVUK5B/KBEvqO/YQafg7EBQ4MKM23ttvK8IrKIDAW0cLsKozw
         EQOnujJKl/SoP1Dc8ghe80WJgDjAF+qAkRAvl2ABJC6YLXEiBvTgKEW5awOZLUjoiimj
         YsfQ==
X-Received: by 10.229.72.8 with SMTP id k8mr9177625qcj.152.1369752194396;
        Tue, 28 May 2013 07:43:14 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-117-138-128.cust.dsl.vodafone.it. [37.117.138.128])
        by mx.google.com with ESMTPSA id v1sm28218775qab.8.2013.05.28.07.43.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 07:43:13 -0700 (PDT)
Message-ID: <51A4C276.2030401@redhat.com>
Date:   Tue, 28 May 2013 16:43:02 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 08/18] KVM/MIPS32-VZ: Entry point for trampolining to
 the guest and trap handlers.
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-9-git-send-email-sanjayl@kymasys.com>
In-Reply-To: <1368942460-15577-9-git-send-email-sanjayl@kymasys.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36621
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

Il 19/05/2013 07:47, Sanjay Lal ha scritto:
> - Add support for the MIPS VZ-ASE
> - Whitespace fixes
> 
> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>  arch/mips/kvm/kvm_locore.S | 1088 +++++++++++++++++++++++---------------------
>  1 file changed, 573 insertions(+), 515 deletions(-)

This is unreadable, can you split the whitespace fixes?

Paolo
