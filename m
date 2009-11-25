Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 16:22:19 +0100 (CET)
Received: from mail-yx0-f193.google.com ([209.85.210.193]:52920 "EHLO
        mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492922AbZKYPTP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 16:19:15 +0100
Received: by yxe31 with SMTP id 31so6853597yxe.21
        for <linux-mips@linux-mips.org>; Wed, 25 Nov 2009 07:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Wx0fsiTXy0OjTjKNRduG6Xacu7EG92oMQPhouUNUlBw=;
        b=oRn2YrGbx8ja/KYmB+Nr6PHdmt/rumofqgkk18n8jlLnGo78ZOfHSXw5EWvahCRpHv
         wMhfv12f8QCLq64nE61zcPeNKyymE0JLH10HWHPpD7aWR8pIMY/x9tcU2lHQyndRjUzc
         B1lkbBAvEuxFz7cRXrBPThtedt5ppKS19h86M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=gutPfL9ClUW+x6QLYeAi2f1/KSGvbl/OIrOse+RwmFAnjxz7Y2Huxb/crb/9GM/ttB
         XMQYvkqTyR/akRSMKBVMGpZOxpntgbyN/zfjB9ti+mHypcVylO7QfPleu41kGkzL26ua
         2xv84z+kqmFUnWz2ckBIBvojnNwZhy1Vmr3rA=
MIME-Version: 1.0
Received: by 10.90.37.8 with SMTP id k8mr2996662agk.19.1259161927482; Wed, 25 
        Nov 2009 07:12:07 -0800 (PST)
Date:   Wed, 25 Nov 2009 23:12:07 +0800
Message-ID: <e997b7420911250712n3380225racdaad413c5b0b53@mail.gmail.com>
Subject: Is it possible to reset non-zero cpus in kernel?
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25130
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Does anyone here has ever used a mips XLR machine?


Though xlr arch is not supported by kernel source tree, I hope there
might be someone using xlr on this maillst ,plz help.


In a mips64 arch, is it possible to reset all the cores ,except for
NO.0 core , into the 'msgwait' state?

Any suggestion  would be appreciate.
