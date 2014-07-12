Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 07:50:29 +0200 (CEST)
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58433 "EHLO
        mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822968AbaGLFu1FtlNq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jul 2014 07:50:27 +0200
Received: by mail-vc0-f174.google.com with SMTP id hy4so3785471vcb.19
        for <multiple recipients>; Fri, 11 Jul 2014 22:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=cwjyfX5PsOGulJo4ib618trI7gUd1bPm0nyQH1PQbPg=;
        b=lGvuCYnj68Mz3OHOROyDZFtbnB/z3poIukVzmq1nrLYgmQPDVYF6HjsXcZc8O7PQDs
         z07rsoplvv92dJcL33pv+OsPowoHaX8P+NDBUY1Rmdni5P//SfpOhLWpBjUfdPQ77VuJ
         qIlKoyrfTbN1dMxz2qBYQcpuBNhh+6g3/uSE0Ob8/J7dvmsSBWKvmUhB9AXX6cQFAxOj
         GHV2VRy+wYOn9obEaddIiMVMwXflHnJMjktbA9qL/ddbQ+vREEuxVMBYso5iPsyHqiRI
         Rtn6VBsB/XsYm/ZerH3XJPVlSA44QyfW8GJ+NjYih4aScWRv16tyttY22Yu18D0hizZp
         yQ7Q==
MIME-Version: 1.0
X-Received: by 10.221.42.135 with SMTP id ty7mr3851813vcb.14.1405144220867;
 Fri, 11 Jul 2014 22:50:20 -0700 (PDT)
Received: by 10.221.53.5 with HTTP; Fri, 11 Jul 2014 22:50:20 -0700 (PDT)
Date:   Sat, 12 Jul 2014 01:50:20 -0400
Message-ID: <CAPDOMVhOpxBrjJNxM7wbomvmwe9Mxb+vh0zvsEA0bd6b0XNQNA@mail.gmail.com>
Subject: FIX ME in mc146818rtc.h
From:   Nick Krause <xerofoify@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

Hey Ralf and other Mips  developers ,
I was wondering about the fix me in this file and how you want to fix this.
Cheers Nick
