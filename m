Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jun 2010 18:00:08 +0200 (CEST)
Received: from mail-yw0-f172.google.com ([209.85.211.172]:54931 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492093Ab0FMQAF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Jun 2010 18:00:05 +0200
Received: by ywh2 with SMTP id 2so2208813ywh.0
        for <linux-mips@linux-mips.org>; Sun, 13 Jun 2010 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Zpwg/+Dn1/N6mpVRMu4TObuH5G11WI/SJxOMMl7s4qg=;
        b=qkWDjhwBVZ/egifyMGYRRjn1vm1xLMRwwJMh3STI6lGzlQBojiyuROv9JS0sftBK0n
         cM7PakYCvRlu88qybpG4oGqdmnIH20f50T9/fvywpr3QkodoQN8HgUrqt6yZ8/OVWfrG
         YflgKbsT+7YO/1NcPqzrhX5o8wTUMl4Z+UaaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=f4sJ3acuiPgK4Z0qSAOdavFWDDyo8fN+UXbsAyz+ZL8rZaxm5I+jLYQo/ZsAvUNtL6
         JvhkYCMFbfdyNyk7pCnPzqHhcxKSWjYHpHpHnLJGu51aykuy60lmQ7UkYrWOS2qMFHXI
         /tWSrkFXWRVRyXiXlqE8S7zeBb7AlNmHvmsoY=
MIME-Version: 1.0
Received: by 10.91.19.18 with SMTP id w18mr3874194agi.160.1276444797701; Sun, 
        13 Jun 2010 08:59:57 -0700 (PDT)
Received: by 10.90.63.13 with HTTP; Sun, 13 Jun 2010 08:59:57 -0700 (PDT)
Date:   Sun, 13 Jun 2010 23:59:57 +0800
Message-ID: <AANLkTikmXmu9uhxnk2OXuCICMpe-hdUJHaB-okhkNf3t@mail.gmail.com>
Subject: Do I Need to enable or set l2 cache in mips for linux work
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8966

Dear all:
My cpu is 24ke and are there any l2 cache configs I have to take care
of, such linux can take advantage of it.
BTW, will I can find any tool or test program for measuring the
performance of l2 cache under linux?
Appreciate your help,
miloody
