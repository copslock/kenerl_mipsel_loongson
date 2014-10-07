Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 21:27:30 +0200 (CEST)
Received: from mail-yk0-f169.google.com ([209.85.160.169]:38477 "EHLO
        mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010752AbaJGT13Z8R30 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 21:27:29 +0200
Received: by mail-yk0-f169.google.com with SMTP id 10so3185265ykt.28
        for <multiple recipients>; Tue, 07 Oct 2014 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id;
        bh=3A+rmKiSd/NST8rj+QMKCnzTGf8xqfcN4KAGH9sQGm0=;
        b=KZsVlRiJloW/yNz5AcJV9+JwY6NJFbIHxxXYoKX4tUYcTrFCQdWlYKfl0HzcEsYnGA
         pgkrG5BOJyMYRXGAvaynNw81DBz/plpTrWw+QEb+AKIJTIDSD4gqVPpWS80oatbEQoRA
         /8CtOW8w+0B63QzEZG0oz5Q7CrD3qRLT11JJyVDc1Of+LNsE08j6n3pdFUM3PR9NTL3x
         d//fgTjbbOngE1jg7UciJoM+8n6GBuYZ890l2yQb40+hr7QF48TEfTdtJQ9czqcODCtW
         u9UCj6EGJyFTUrhA3rB/fvwTvTVEnM4dX9xwrxmRIRSjlUSvRrav8RseabEiwsLXNitn
         Mc3w==
X-Received: by 10.236.26.41 with SMTP id b29mr8539301yha.36.1412710043280;
        Tue, 07 Oct 2014 12:27:23 -0700 (PDT)
Received: from t430.minyard.home (pool-173-57-152-84.dllstx.fios.verizon.net. [173.57.152.84])
        by mx.google.com with ESMTPSA id q40sm8886213yhg.32.2014.10.07.12.27.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 12:27:22 -0700 (PDT)
Received: from t430.minyard.home (t430.minyard.home [127.0.0.1])
        by t430.minyard.home (8.14.7/8.14.7) with ESMTP id s97JRKfn017529;
        Tue, 7 Oct 2014 14:27:20 -0500
Received: (from cminyard@localhost)
        by t430.minyard.home (8.14.7/8.14.7/Submit) id s97JRKRO017527;
        Tue, 7 Oct 2014 14:27:20 -0500
From:   minyard@acm.org
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 
Date:   Tue,  7 Oct 2014 14:27:11 -0500
Message-Id: <1412710034-16908-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 1.8.3.1
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
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

I'm dealing with issues with bad backtraces in MIPS kdumps.  This
patch series fixes the issues with these backtraces.

Note that this does not currently enable DWARF unwinding on the
restore side.  It's less useful (unless you have a backtrace that
runs through the restore code).  It could be done, I think,
without major hassle, but I'll save that for future assuming
these sorts of changes are ok.

Those moves a lot of generic stuff from the x86 dwarf2.h to a new
asm-generic version, but does not make any functional changes to
that code.
