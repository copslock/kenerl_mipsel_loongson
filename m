Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 18:14:48 +0200 (CEST)
Received: from mail-io0-f169.google.com ([209.85.223.169]:36784 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012348AbbHLQOrIfT7h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 18:14:47 +0200
Received: by iodv127 with SMTP id v127so9134742iod.3
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3jqnlnIEU2Zf6wp1OI6mmCHl22nDzQLjcJSvc4jrCKk=;
        b=bljbze3d48dW8uSU1+HZcZfv3PlvyCSx7gNJ6ND4kbRaBjvTfDdzuqb36CrkIGfxce
         2+m4N6BcXGgxctUNOAjFXzmVAI/XHGKuUw1GS/Ri3kBpyFYXb43VrTzRpwiB6J7AZkEp
         h+pKMESVJzgnhSKFVqWMbGP7cmIwk/geH5ummZtYg4C0TFd6DcHBZEKl3QVLV/8yKOgI
         ARM/9ZVuf5+NS6VLLxqixvgQIojSVUT40iQVkwsj6uFOLVrer6uDCZyauTEOy/h7wcP5
         a57kPxQ3u3ihWw9g8FJ+tTrHtQBexbUpZr4LG6LGiRMuYRcsOmvjQ7wvo+PgWg9mv/0L
         t+WA==
X-Received: by 10.107.40.147 with SMTP id o141mr33293085ioo.83.1439396081383;
        Wed, 12 Aug 2015 09:14:41 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id rq1sm10706961igb.21.2015.08.12.09.14.39
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 09:14:40 -0700 (PDT)
Message-ID: <55CB70EE.4080802@gmail.com>
Date:   Wed, 12 Aug 2015 09:14:38 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Alex Smith <alex.smith@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: VDSO
References: <55CB1E0C.4070405@imgtec.com>
In-Reply-To: <55CB1E0C.4070405@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48823
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

On 08/12/2015 03:21 AM, Alex Smith wrote:
> Hi,
>
> I'm intending to start work on a proper VDSO implementation for MIPS that can provide user implementations of gettimeofday() and such, as well as take over from the current signal return trampoline code.
>
> Just wondering if there's anyone else who's doing any work towards this so we can avoid duplication of effort if so?
>

I am not working on it, but have a small laundry list of what could be done:

1) Perhaps the VA of the vdso needs to be randomized.

2) Provide proper .eh_frame data for the signal return trampolines.

3) gettimeofday (as you suggest).

4) Provide optimized versions of memcpy, etc.

David Daney
