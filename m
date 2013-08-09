Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 13:51:09 +0200 (CEST)
Received: from mail-ee0-f48.google.com ([74.125.83.48]:53104 "EHLO
        mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822461Ab3HILuwViVwI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Aug 2013 13:50:52 +0200
Received: by mail-ee0-f48.google.com with SMTP id l10so2041486eei.21
        for <multiple recipients>; Fri, 09 Aug 2013 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bFij5y2RJ1QUw0sKXy9EBLUJMXVxd6Sbp829rgxyf2I=;
        b=U5nDOiuSibamcIeJCGqq7e3ZDBoubnwOxqx+YFt7azthsMSrh5XnhJFTpWwLUgfG8+
         HRL1G/8JoZq4FzbNxOiZdxx7hZY0fAXU21GgFQerfkZqKv1HoUv0iUoZbF4VQM5puO3G
         o3fIEv/BKZ+h20c383nQ6XLmWlGokiaUt2FHSxEs/lAKdGJ5UgJLB3MGn+4jbQQII0H8
         f/XHdzqnBZbOPkk7DvBB68ToZMWf/SzUH81DREyM/wIzjGRT9AWIWJvUn/GiIK0+21CO
         n6EB5dQm6Y7xhZQa4c3OUFUXdY+JDM4eJB3gXkVGY5u+97xcH5M0WFTK1wqL3NR7GHhW
         9gpg==
X-Received: by 10.14.200.132 with SMTP id z4mr12842774een.14.1376049046937;
        Fri, 09 Aug 2013 04:50:46 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-mxp-t.redhat.com. [209.132.186.18])
        by mx.google.com with ESMTPSA id m54sm28036307eex.2.2013.08.09.04.50.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 04:50:45 -0700 (PDT)
Message-ID: <5204D776.6040903@redhat.com>
Date:   Fri, 09 Aug 2013 13:50:14 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/3] mips/kvm: Code cleanups for kvm_locore.S
References: <1375388555-4045-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1375388555-4045-1-git-send-email-ddaney.cavm@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37494
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

Il 01/08/2013 22:22, David Daney ha scritto:
> From: David Daney <david.daney@cavium.com>
> 
> These shouldn't be too controversial, they just clean things up
> without changing the generated code.
> 
> More substantial patches will follow, but it seemed like a good idea
> to clean this up first.
> 
> David Daney (3):
>   mips/kvm: Improve code formatting in arch/mips/kvm/kvm_locore.S
>   mips/kvm: Cleanup .push/.pop directives in kvm_locore.S
>   mips/kvm: Make kvm_locore.S 64-bit buildable/safe.
> 
>  arch/mips/kvm/kvm_locore.S | 965 ++++++++++++++++++++++-----------------------
>  1 file changed, 480 insertions(+), 485 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
