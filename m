Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2012 19:09:23 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:55854 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903520Ab2F0RJT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jun 2012 19:09:19 +0200
Received: by dadm1 with SMTP id m1so1786229dad.36
        for <linux-mips@linux-mips.org>; Wed, 27 Jun 2012 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Xz2cVu7+8RUr4cZbjg3dpukPilF2kxDfJAa/KYUVjO4=;
        b=MpiNx4O+oX9Cn3jo+rsQL6sszzBVNMKBjQmTK3+QW9+/SKg0ROHY7fyNAzDz6ViQ9y
         FgnWJ3LHRfRpLGZODxng8wx9LBbqZqsAS6VcQdARGn94/YFc7k1aK/p93RH5aaab3uPj
         IqxSl0QF7auxV9JuMEJ60UQQhYMepeKS2PHJ//kZIwM5jZQURkEsQnTsqkh29H0AeyJs
         vRYK5nUWQhzjSEmLYjZS2EPd9mmykgGf/oUuDgScmMR7xLFSL8QEjM81C1pD81CvZ0d8
         qLbeAInnMYsR7EVfmG7XTIdD4DWqcceKaTPlBh9CP4cEF8aWN8ne2V8DOLbIRHEa74Fn
         MxIA==
MIME-Version: 1.0
Received: by 10.68.130.67 with SMTP id oc3mr35154843pbb.18.1340816952490; Wed,
 27 Jun 2012 10:09:12 -0700 (PDT)
Received: by 10.68.240.41 with HTTP; Wed, 27 Jun 2012 10:09:12 -0700 (PDT)
Date:   Thu, 28 Jun 2012 01:09:12 +0800
Message-ID: <CANudz+vaPhxjwrxZqySr6qAo-MR7K-KqssigO_fE2Z9hbuO2Vw@mail.gmail.com>
Subject: some question about mips mtc0/mfc0 usage
From:   loody <miloody@gmail.com>
To:     Linux MIPS List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
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

Hi all:
My mips is 24k core series, and I have some questions when I using mtc0/mfc0.
1. no matter what "spacing" in the execution-hazard or
instruction-hazard, is it enough to use "ehb" and "JALR.HB" once?
2.
below is excerpted from the spec.

producer        consumer
                hazard on        spacing
MTC0        -> Interrupted  instruction
            Status              2
MTC0        ->Load/Store  affected by new state
   StatusER       3
MTC0        -> Coprocessor   instruction affected by new state       StatusCU 4
MTC0        -> Instruction    fetch  seeing the new value
      EntryHiASID 10

Are there any example which can tell me what does
" Interrupted instruction"
"Load/Store affected by new state"
"Coprocessor instruction affected by new state"
" Instruction fetch seeing the new value"
mean?

-- 
Thanks for your help in advance,
