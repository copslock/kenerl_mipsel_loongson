Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jun 2010 18:16:17 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:38657 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491947Ab0F0QQM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Jun 2010 18:16:12 +0200
Received: by gwj21 with SMTP id 21so4191142gwj.36
        for <linux-mips@linux-mips.org>; Sun, 27 Jun 2010 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=vc9g6E/OPJcWLZ3Wr6jhtOqhq2BXJc3j5YlJKFXUiAo=;
        b=WLdqKd/1agj1ZkaQ7tEbbswTKCQd36OYdJK5o14dNrRmQSY6+7pDvdTQ9Be6fzyWSk
         6+YX10JWw6KSxIBXNK3UpF/kXFkEYPlcUeWk82OQkn4jGqGSzeiZrNelzgeWzfgrGuLB
         dCjreRc7wrZJK+h/j1XTFajlHpnDGt3DFczos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=njaSUp4jKepBuXxaTXJjqYH4Fr1YHdvnfiENRlFGzr4RUWyONKIVJwSCjEMqbnSdnW
         18tKOZtrD9OiN/wUIKDfCppihIeRou/y/PZi35zM5UWe04ovVX9Mihgwb0DLkYVVtRki
         C2N3LplZWQwkiX92J6QdCnhsyDXAsjHGXrrYY=
MIME-Version: 1.0
Received: by 10.91.51.6 with SMTP id d6mr3368462agk.85.1277655366605; Sun, 27 
        Jun 2010 09:16:06 -0700 (PDT)
Received: by 10.90.63.13 with HTTP; Sun, 27 Jun 2010 09:16:06 -0700 (PDT)
Date:   Mon, 28 Jun 2010 00:16:06 +0800
Message-ID: <AANLkTikXife5CaPBQ4k_FUUM6-VD2C7SOOEbyugRhIqG@mail.gmail.com>
Subject: some question about wmb in mips
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18205

Dear all:
AFAIK, wmb in mips is implemented by calling sync,
wmb->fast_wmb->__sync, which makes sure Loads and stores executed
before the SYNC are completed before loads
and stores after the SYNC can start
But will this instruction write the cache back too?
take usb example, it will call this maco before it let host processing
the commands on dram, so I wondering whether sync will write the cache
back to memory.
appreciate your help,
miloody
