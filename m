Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2014 05:20:16 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:44721 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006629AbaIDDUPeek7u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Sep 2014 05:20:15 +0200
Received: by mail-ig0-f173.google.com with SMTP id h18so371890igc.12
        for <linux-mips@linux-mips.org>; Wed, 03 Sep 2014 20:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=tFned2RqE74sQvI7LwywBRW8tr4LDcrO6/fDVRUTOlQ=;
        b=MDO9wrA3VTbiuALOwJoP50Ay7RvzQ/CsN6jLcJR4pTmaLEJMNGkMJ2qatG6064QsnP
         ATuq5+uPYpEa6aWul2WLbnZeu2gR+s/+Crg+vPqw6NBUqWC/3L/KY2uBb/H4o6q5HZki
         6KS/26NjMFRy2PcZJZHlLeCWAXAU7G0avsTcPgbYjbbUPrt/PgsitJVn4tVN2huPPK1L
         nYyY3RJORlym/hmaMEFB/eqwE1r+5GIJ/WbC4anJJm0K2PkeZvjigEyXvEf0cATV9J8J
         R53TIqxrhicy1xOfs8D/zrNPO9oC5Tf04a40A0W0XSDYvpz5b0hMMDctnZDrfoQAUccJ
         HCew==
X-Received: by 10.50.115.73 with SMTP id jm9mr1940196igb.3.1409800809385; Wed,
 03 Sep 2014 20:20:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.201 with HTTP; Wed, 3 Sep 2014 20:19:49 -0700 (PDT)
From:   cee1 <fykcee1@gmail.com>
Date:   Thu, 4 Sep 2014 11:19:49 +0800
Message-ID: <CAGXxSxXx-RD78Ex7qkeLtxEFR5j3But8bm1Xzod8g4yHKDei4A@mail.gmail.com>
Subject: Question about csum_partial_copy_nocheck
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fykcee1@gmail.com
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

Hi all,

I notice the implementation of
csum_partial_copy_nocheck(http://lxr.free-electrons.com/source/arch/mips/lib/csum_partial.S#L458)
weird for me.

It actually skips assignment of AT(at) and errptr(t9), while in the
exception handlers, these uninitialized AT/errptr will be accessed.
Will it cause some problems? Or my understanding is not correct?



-- 
Regards,

- cee1
