Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2014 00:03:21 +0100 (CET)
Received: from mail-qc0-f173.google.com ([209.85.216.173]:40697 "EHLO
        mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822155AbaCCXDTrqnxp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Mar 2014 00:03:19 +0100
Received: by mail-qc0-f173.google.com with SMTP id r5so3402017qcx.32
        for <multiple recipients>; Mon, 03 Mar 2014 15:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+59sYIsoGY0yg/Io+BGbLoJ46dXT5yuJyiJX3N7nLis=;
        b=P7f2oUoZogH7wpT3sSxz8HdOh7tnsLKZ4ItNPk1hLsZ83q+jW1Rrz0RVb8Y1lfFAGD
         wFEW87qTj0HzyVbbytW2eJIIVsZUbcb6OZJ7eu4aWOAcEKAG4gjalBza7Hz2qQH9cR2r
         L/ZSfLLJoMS4HlZ4tbxYjiyUOQLn4FmTBMnG8iDBgC6TdAa4sYQ9sMPjgd2wFL9SxiG9
         FrvJ5nIm3h46uO8KEffwVfhtR7i0jJ1b+SiwEr4+u+TQf1EYhgEPtS288Hrz7EuAp+oT
         rssL8/As1F8NksKc2m+x8tatfgTI0HgBX/jkblOCrdM7mqUAPGcYPcvWOq+MvSr6Q1CY
         qDQA==
X-Received: by 10.224.45.197 with SMTP id g5mr26791425qaf.52.1393887793370;
        Mon, 03 Mar 2014 15:03:13 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id b14sm43064759qac.17.2014.03.03.15.03.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Mar 2014 15:03:12 -0800 (PST)
Message-ID: <53150A2F.4010408@gmail.com>
Date:   Mon, 03 Mar 2014 15:03:11 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 3/5] MIPS: Set page size to 16KB for malta SMP defconfigs
References: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com> <1392904828-12969-4-git-send-email-markos.chandras@imgtec.com> <20140221173829.GI19285@linux-mips.org> <53148C5A.7020101@imgtec.com> <20140303222423.GA573@drone.musicnaut.iki.fi>
In-Reply-To: <20140303222423.GA573@drone.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39400
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

On 03/03/2014 02:24 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Mar 03, 2014 at 02:06:18PM +0000, Markos Chandras wrote:
>> Are you referring to programs hard coding the page size to 4k instead of
>> using the getpagesize()? Well yes this could be a problem. But is that a
>> real problem? We are changing the default value so whoever has such an old
>> userland can easily switch to the 4k page size. It may also be a good
>> opportunity to expose such application and get the fixed properly :) But if
>> that's not acceptable, we can drop the patch. Paul what do you think?
> Not so long ago there was an issue with Debian where Iceweasel or
> Spidermonkey failed on MIPS/Loongson because of its 8K page size (the
> userspace assumed 4K). You will get such issues as long as x86 dominates,
> it's not a matter of "old userland".
>
It is not just getpagesize().  People also used to amuse themselves by 
patching ld so that it did Program Header layout in a manner that was 
incompatible with anything other than 4K pages.  This was mostly seen in 
toolchains used by people using uClibc.
