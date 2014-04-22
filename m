Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 23:37:47 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:49746 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834671AbaDVVhoZihp3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 23:37:44 +0200
Received: by mail-ig0-f170.google.com with SMTP id uq10so3392392igb.5
        for <linux-mips@linux-mips.org>; Tue, 22 Apr 2014 14:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=u1Wbx6f3tLUzSSfm0gYfm9iFLhrO1fKZE8oEoeXyQ3E=;
        b=ajsYw7Krhcus+EVOu2/olaz75zmDtl0O2mKlWTxB+zFQcq3x5oIDy/qJP5NyGtI4g2
         ME4UxwKefOJCs2dVVjXDUeMw3/wrb/WyyaMLXKV8queMQJKVMam9roVvAaNnbDz3UVtk
         MEu9Z0tJESB2sCo6+eyC6ilhQQicdMZtidmiUvDkrQeNl5VdJNTphrRBb8XJFerhtK+I
         G8cAADqytnKMCCfE1htdSTw/cB7+VmBtuF2va7YuAH20CmlT4xXR22AECgVa8kFgq+Zu
         nBkXqriyPQCHZPOb1NjNHMZpxW3EMA5dAbZDB6S/KhnGxRTu0Lu5b8wNUx08I/7ZhMdZ
         UWDg==
X-Received: by 10.50.25.67 with SMTP id a3mr474330igg.28.1398202657144;
        Tue, 22 Apr 2014 14:37:37 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id p7sm31149822igg.15.2014.04.22.14.37.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 14:37:36 -0700 (PDT)
Message-ID: <5356E11F.1000805@gmail.com>
Date:   Tue, 22 Apr 2014 14:37:35 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Holger Hans Peter Freyther <holger@freyther.de>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Implement perf_callchain_user
References: <1313022966-28152-1-git-send-email-zecke@selfish.org> <loom.20110822T193146-370@post.gmane.org> <loom.20140421T105026-95@post.gmane.org> <5355B864.7090209@gmail.com> <20140422063652.GF15993@xiaoyu.lan>
In-Reply-To: <20140422063652.GF15993@xiaoyu.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39898
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

On 04/21/2014 11:36 PM, Holger Hans Peter Freyther wrote:
> On Mon, Apr 21, 2014 at 05:31:32PM -0700, David Daney wrote:
>
> Hi!
>
>> I implemented it for MIPS, the patches are on the relevant mailing lists.
>> Perhaps some day they will get merged.
>
> this was a ping for my patches from 2011. Is linux-mips following a
> different review/patch posting scheme?
>

That was unclear.  Now that almost three years have passed, the only 
reasonable thing to do is resend the patches rebased against the current 
kernel.

That said, given the fact that stackframe analysis is not reliable, 
coupled with the fact that we have DWARF based unwinding of userspace 
threads working in perf with captured stack images, makes me think that 
the patches should not be merged.

David Daney



> cheers
> 	holger
>
