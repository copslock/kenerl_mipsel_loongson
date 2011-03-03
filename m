Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2011 14:07:55 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:48899 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491870Ab1CCNHu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2011 14:07:50 +0100
Received: by vws7 with SMTP id 7so982452vws.36
        for <linux-mips@linux-mips.org>; Thu, 03 Mar 2011 05:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=rt/LLtR5/j2rftoW0h6pjM4pzLkQOq7B0UfzqHYT6EQ=;
        b=DFLuiahnVViwVPuVn9IEGYOlVnI/BkAat/9k38jSCK8fO/dRctc08iry4O8P0DBCvt
         OeaYbvT0B2AKsBpyMncuGneG7dh1GhzhYqgf4Cz7pYk7fIdtMmN0Bu/C2fGamKBkvFNO
         5Jn/sQ9WmCtfKsJELapa8bil1NH4UO3MyV/C4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=EAhNp8bZNw3AbxCszS2TR+D/Tf1LWnSQ76CDPAwb2p1I8UTZRjwHNVwDaZkelxDrFO
         zp+dUCmdIjAMYC8CY/mbZL7eYqbnnRJpZQF3rJQFmklkmdgFVd72lrs/MUluKB7T3prR
         gzVtEnqBGWHWegGyPT6AvKZ52CDgXbLIsqmBU=
MIME-Version: 1.0
Received: by 10.52.70.82 with SMTP id k18mr1671531vdu.194.1299157355389; Thu,
 03 Mar 2011 05:02:35 -0800 (PST)
Received: by 10.52.158.71 with HTTP; Thu, 3 Mar 2011 05:02:35 -0800 (PST)
Date:   Thu, 3 Mar 2011 18:32:35 +0530
Message-ID: <AANLkTikFHPYf74QNKYEQD2o+=VvZgVNGgbbydcUiF0WF@mail.gmail.com>
Subject: Memory Compaction feature.
From:   naveen yadav <yad.naveen@gmail.com>
To:     kernelnewbies@nl.linux.org, linux-mips@linux-mips.org,
        linux-arm-kernel-request@lists.arm.linux.org.uk
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi All,

I want clarification is anybody verify this feature on ARM or MIPS architecture.

http://lwn.net/Articles/381677/

Kind regards
