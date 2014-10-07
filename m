Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 20:51:08 +0200 (CEST)
Received: from mail-yh0-f50.google.com ([209.85.213.50]:59316 "EHLO
        mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010743AbaJGSvGkhN6K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 20:51:06 +0200
Received: by mail-yh0-f50.google.com with SMTP id a41so3266378yho.9
        for <multiple recipients>; Tue, 07 Oct 2014 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id;
        bh=7G0nBMruLdyBP1LEN1xY8dIhxsMbhAXNrtP7CwsIOgo=;
        b=nQoxEdchRrSEnMkC4NxQdajoTgbzOqjG4nHIqlxZfYJWZtiSm90YVWCnJOdby1+UGo
         0GxM4zcZs43DBqwimZji/GAGj0lWTP5ybR9lG9uPvAeMCIADiOhUzipkIbWFKeRQ0yt6
         FJAltCcQ2qpj720Ye6LH61d3iYMeKFiMOSpmn/LUrr/P+1MeGHcXK5qq3DAbqUyXUFnE
         MbKBHXJYF5GypDBsl2MRmVZxZIKAvDPxSoilvwIoJTyy27vLgR9zR2gXngh60fEuwm47
         qR+xHbTFyEq8JgltbxiK2MkcaBrNeb1VoviH1jxlNj6fpByZFVrX+YqhzX8e848/xWFf
         Em2g==
X-Received: by 10.236.75.99 with SMTP id y63mr7857423yhd.105.1412707860366;
        Tue, 07 Oct 2014 11:51:00 -0700 (PDT)
Received: from t430.minyard.home (pool-173-57-152-84.dllstx.fios.verizon.net. [173.57.152.84])
        by mx.google.com with ESMTPSA id t72sm8835421yho.56.2014.10.07.11.50.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 11:50:59 -0700 (PDT)
Received: from t430.minyard.home (t430.minyard.home [127.0.0.1])
        by t430.minyard.home (8.14.7/8.14.7) with ESMTP id s97IovmI016064;
        Tue, 7 Oct 2014 13:50:57 -0500
Received: (from cminyard@localhost)
        by t430.minyard.home (8.14.7/8.14.7/Submit) id s97IoulQ016062;
        Tue, 7 Oct 2014 13:50:56 -0500
From:   minyard@acm.org
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/3] DWARF unwinding for MIPS
Date:   Tue,  7 Oct 2014 13:50:51 -0500
Message-Id: <1412707854-15555-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 1.8.3.1
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43077
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
without major hassle., but I'll save that for future assuming
these sorts of changes are ok.
