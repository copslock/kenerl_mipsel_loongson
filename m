Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2014 18:43:06 +0100 (CET)
Received: from mail-qa0-f43.google.com ([209.85.216.43]:38262 "EHLO
        mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821115AbaCJRnEMJGL- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Mar 2014 18:43:04 +0100
Received: by mail-qa0-f43.google.com with SMTP id j15so7247672qaq.16
        for <multiple recipients>; Mon, 10 Mar 2014 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TUMUiC3po89vhe1lkOidVqtmWzcPpdB+gXlJYNA9ov0=;
        b=qZGMbbNt7q/7Mywwz622NlMvqq+69FjxLsxLRCtCseuWkDnxpnAFXqKJfxHVJ2dGGs
         BnXJ54Cu9i6yEXUiP3uNIJRpXnCVlWTO/MUcic6bhHFaZY+k8ZzXVqEcGjhKp0q3DRRp
         AiUEeqgtRQ8I6yXizXX9Yzt6IeEzKv1ALcbu70lbD4hIOzSINPJPUC9S17bz4QPY3mJU
         Wl/ZtmN1nGJ3FFOwqHWreKEpQlVVFZmAalnL+qCg79m0T2T29Q0sjhrifOCgPSb5+z0G
         sLPaFNL+ozT5+A7nIVATYs2KwvA9ph3FmINkJc+o7Tqa4EXCOESy8G21xeSL5lbWvAKP
         2qkQ==
X-Received: by 10.140.41.74 with SMTP id y68mr3467571qgy.105.1394473377823;
        Mon, 10 Mar 2014 10:42:57 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id 67sm27407180qgr.15.2014.03.10.10.42.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Mar 2014 10:42:57 -0700 (PDT)
Message-ID: <531DF99F.3040403@gmail.com>
Date:   Mon, 10 Mar 2014 10:42:55 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aurelien Jarno <aurelien@aurel32.net>
CC:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 3/5] MIPS: Set page size to 16KB for malta SMP defconfigs
References: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com> <1392904828-12969-4-git-send-email-markos.chandras@imgtec.com> <20140221173829.GI19285@linux-mips.org> <53148C5A.7020101@imgtec.com> <20140303222423.GA573@drone.musicnaut.iki.fi> <20140310135506.GA28583@hall.aurel32.net>
In-Reply-To: <20140310135506.GA28583@hall.aurel32.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39443
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

On 03/10/2014 06:55 AM, Aurelien Jarno wrote:
> On Tue, Mar 04, 2014 at 12:24:23AM +0200, Aaro Koskinen wrote:
>> Hi,
>>
>> On Mon, Mar 03, 2014 at 02:06:18PM +0000, Markos Chandras wrote:
>>> Are you referring to programs hard coding the page size to 4k instead of
>>> using the getpagesize()? Well yes this could be a problem. But is that a
>>> real problem? We are changing the default value so whoever has such an old
>>> userland can easily switch to the 4k page size. It may also be a good
>>> opportunity to expose such application and get the fixed properly :) But if
>>> that's not acceptable, we can drop the patch. Paul what do you think?
>>
>> Not so long ago there was an issue with Debian where Iceweasel or
>> Spidermonkey failed on MIPS/Loongson because of its 8K page size (the
>> userspace assumed 4K). You will get such issues as long as x86 dominates,
>> it's not a matter of "old userland".
>
> In Debian I am aware of the problem on at least all mozilla based
> products (the problem is jemalloc) and GCL.
>
> The problem is not that the page size is hardcoded to 4K, but that it is
> detected at build time instead of run time.

Of course that is incorrect, pagesize must be detected at runtime.  Any 
package that does otherwise is defective and should be fixed.

If they need an upper bound, we can supply that.  It is 64K.


> This is only a problem for
> distributions where a package could be built on one machine and run on
> another, but it should not affect people building such packages
> themselves, or using the same set of machines.
>
> The fact that the page size is not 4K is usually correctly handled, as
> other architectures like alpha and itanium were using 8K or 16K pages.
>
