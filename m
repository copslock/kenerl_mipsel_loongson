Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 09:57:33 +0200 (CEST)
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44073 "EHLO
        mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820484AbaE3H52NF0HD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2014 09:57:28 +0200
Received: by mail-wg0-f44.google.com with SMTP id a1so1538156wgh.3
        for <multiple recipients>; Fri, 30 May 2014 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mm/DEUrJPxypjmI7aaBTrdwt6WCQU0VawD4a75Cv7dM=;
        b=g5BzzNzmOhD3WvfO/aQSA13Haq85H+j6Hkl5KSRhVdnabYNU7QtT40XD7JtNMkFMAz
         +fgDyPEUvoajpuk9x8JH7nTwqMcbHYWm6stEgJhNsZmYEd4I0FEH0ZJMT6O4F1iVOk0R
         2pqLSqWR0jHrUvR8fS0pTCTxd0piMuU86flvMbpFBdct59xyMbnE/GXB/f01OIgLg8lw
         bBly6rFYsA0OTr+MPu8a7C+N7OuvtA2G6+Til7sWTFNhezRSlyWTNFPIINtVpjOAt9kK
         4rDVcCLEQPtUQur9YD/r8u44xc8DTFxQbRFXmXDCQbTJxDvcrCO4hOWH944k86bbca1O
         LD9g==
X-Received: by 10.180.100.129 with SMTP id ey1mr4075170wib.60.1401436642833;
        Fri, 30 May 2014 00:57:22 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-117-132-7.cust.vodafonedsl.it. [37.117.132.7])
        by mx.google.com with ESMTPSA id bj2sm3825417wib.3.2014.05.30.00.57.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 May 2014 00:57:21 -0700 (PDT)
Message-ID: <538839DE.3000804@redhat.com>
Date:   Fri, 30 May 2014 09:57:18 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH v2 00/23] MIPS: KVM: Fixes and guest timer rewrite
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com> <53870DAD.7050900@redhat.com> <53874719.5070604@imgtec.com> <538750F8.7040202@redhat.com> <53875FEE.1020607@imgtec.com> <53876850.20600@redhat.com> <53879C3E.3040102@imgtec.com>
In-Reply-To: <53879C3E.3040102@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40378
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

Il 29/05/2014 22:44, James Hogan ha scritto:
> Yes, I agree with your analysis and had considered something like this,
> although it doesn't particularly appeal to my sense of perfectionism :).

I can see that.  But I think the simplification of the code is worth it.

It is hard to explain why the invalid times-goes-backwards case can 
happen if env->count_save_time is overwritten with data from another 
machine.  I think the explanation is that (due to 
timers_state.cpu_ticks_enabled) the value of "cpu_get_clock_at(now) - 
env->count_save_time" does not depend on get_clock(), but the code 
doesn't have any comment for that.

Rather than adding comments, we might as well force it to be always zero 
and just write get_clock() to COUNT_RESUME.

Finally, having to serialize env->count_save_time makes harder to 
support migration from TCG to KVM and back.

> It would be race free though, and if you're stopping the VM at all you
> expect to lose some time anyway.

Since you mentioned perfectionism, :) your code also loses some time; 
COUNT_RESUME is written based on when the CPU state becomes clean, not 
on when the CPU was restarted.

Paolo
