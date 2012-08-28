Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2012 07:42:43 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34152 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903718Ab2H1Fmj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Aug 2012 07:42:39 +0200
Received: by lbbgf7 with SMTP id gf7so2863224lbb.36
        for <linux-mips@linux-mips.org>; Mon, 27 Aug 2012 22:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6/uI87KS3KRtkOhQwSJNh437mEUY2aBSEdD6ex+Js38=;
        b=zVH6BsUXJrg/wyn+q52zbMMUUAvl3trpflCp0TTUpsShNvxi1SdI3EDdNsIdIl6J2s
         V6e+7FpyT/m23Q1QVE0raOoz3ttzNbF862akJlacnt501plbnfu1BM0t2BoEYcUQpONZ
         T9BTkS3/I76+c8DaFsWufc3t1EUOlboojvCZWcjRjAPDU4jeGHFtMRSbXGrfv2UQYN0d
         Vn8iUX5MxZDjEuoJ65QYERlSQiYdlRdjMC5nZiVxt9fAo5FKgqka/q93NxlfViWuag8K
         crGv8kM2AVtYxUp1j9bq57p/0jjwCsJQ85nx3s/yq502O5eAI5n541BSZnK+OI0Bk2cc
         Ys+w==
MIME-Version: 1.0
Received: by 10.112.86.200 with SMTP id r8mr7575980lbz.87.1346132554228; Mon,
 27 Aug 2012 22:42:34 -0700 (PDT)
Received: by 10.114.21.199 with HTTP; Mon, 27 Aug 2012 22:42:34 -0700 (PDT)
In-Reply-To: <CAF1ivSYqNpzZD5U6Ne_FL_gDmPC0aETb7Gt3uyWZzNp9tTMP5Q@mail.gmail.com>
References: <CAF1ivSYqNpzZD5U6Ne_FL_gDmPC0aETb7Gt3uyWZzNp9tTMP5Q@mail.gmail.com>
Date:   Tue, 28 Aug 2012 11:12:34 +0530
Message-ID: <CAMmEz3R6NCpAFvE5O88nnUYJONk=-E2PK3==-Kmzf1+B7wHv7g@mail.gmail.com>
Subject: Re: panic in hrtimer_run_queues
From:   Noor <noor.mubeen@gmail.com>
To:     Lin Ming <mlin@ss.pku.edu.cn>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noor.mubeen@gmail.com
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

given ra : 8002c0ac hrtimer_run_queues+0x160/0x1bc
shouldn't it be that you tripped here: 8002c0a4. you can double check
from hrtimer_run_queues+0x160

 8002c098:       0c00aeaa        jal     8002baa8 <__remove_hrtimer>
 8002c09c:       00003821        move    a3,zero
 8002c0a0:       8e220020        lw      v0,32(s1)
 8002c0a4:       0040f809         jalr    v0                 <--- tripped here
 8002c0a8:       02202021        move    a0,s1
 8002c0ac:       02002821        move    a1,s0       <--- ra set to this

ofcourse v0 is not *s1+32, but might need attention ??
